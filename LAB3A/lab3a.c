#include <sys/types.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <inttypes.h>
#include <math.h>
#include <linux/types.h>
int imageFd, superFd, groupFd, bitmapFd, inodeFd, directoryFd, indirectFd;
FILE *superFp, *groupFp, *bitmapFp, *inodeFp, *directoryFp, *indirectFp;
struct stat st;
int filesize;
char* filename;
int block_size;
int num_groups;
int ** DirectoryInodes;
int *RegularInodes;
int inodesCount = 0;
int dirInodesCount = 0;
struct super_t {
	uint32_t   s_inodes_count;         /* Inodes count */
    uint32_t   s_blocks_count;         /* Blocks count */
    uint32_t   s_r_blocks_count;       /* Reserved blocks count */
    uint32_t   s_free_blocks_count;    /* Free blocks count */
    uint32_t   s_free_inodes_count;    /* Free inodes count */
    uint32_t   s_first_data_block;     /* First Data Block */
    uint32_t   s_log_block_size;       /* Block size */
    int32_t   s_log_frag_size;        /* Fragment size */
    uint32_t   s_blocks_per_group;     /* # Blocks per group */
    uint32_t   s_frags_per_group;      /* # Fragments per group */
    uint32_t   s_inodes_per_group;     /* # Inodes per group */
    uint32_t   s_mtime;                /* Mount time */
    uint32_t   s_wtime;                /* Write time */
    uint16_t   s_mnt_count;            /* Mount count */
    int16_t   s_max_mnt_count;        /* Maximal mount count */
    uint16_t   s_magic;                /* Magic signature */
} super_buf;
struct group_t {
	uint32_t bg_block_bitmap;
	uint32_t bg_inode_bitmap;
	uint32_t bg_inode_table;
	uint16_t bg_free_blocks_count;
	uint16_t bg_free_inodes_count;
	uint16_t bg_used_dirs_count;
} *group;
int isPowerOfTwo (unsigned int x)
{
 while (((x % 2) == 0) && x > 1) /* While x is even and > 1 */
   x /= 2;
 return (x == 1);
}
void parseArgs(int argc, char **argv){
	if(argc != 2){
		fprintf(stderr, "Error: Please provide a disk image name as the only argument\n");
		exit(EXIT_FAILURE);
	}
	else{
		filename = malloc( (strlen(argv[1]) + 1) * sizeof(char));
		filename = argv[1];
	}
	imageFd = open(filename, O_RDONLY);

}
void parseSuper()
{
	stat(filename, &st);
	filesize = st.st_size;
	superFd = creat("super.csv",S_IRWXU);
	pread(imageFd, &super_buf, sizeof(struct super_t), 1024);
	if (super_buf.s_magic != 0xEF53){
		dprintf(STDERR_FILENO,"Superblock - invalid magic: %x\n", super_buf.s_magic);
		exit(1);
	}
	block_size = 1024 << super_buf.s_log_block_size;
	if (!isPowerOfTwo(block_size) || block_size < 1024 || super_buf.s_log_block_size > 4096)
	{
		dprintf(STDERR_FILENO,"Superblock - invalid block size: %d\n",block_size);
		exit(1);
	}
	int valid_block_count = ceil((double)filesize/block_size);
	if (super_buf.s_blocks_count > valid_block_count)
	{
		dprintf(STDERR_FILENO, "Superblock - invalid block count %d > image size %d\n", super_buf.s_blocks_count, valid_block_count);
		exit(1);
	}
	if (block_size == 1024)
	{
		if (super_buf.s_first_data_block != 1)
		{
			dprintf(STDERR_FILENO,"Superblock - invalid first block %d > image size %d\n", super_buf.s_first_data_block, valid_block_count);
			exit(1);
		}
	}else{
		if (super_buf.s_first_data_block != 0)
		{
			dprintf(STDERR_FILENO,"Superblock - invalid first block %d > image size %d\n", super_buf.s_first_data_block, valid_block_count);
			exit(1);
		}
	}
	if (super_buf.s_blocks_count % super_buf.s_blocks_per_group != 0)
	{
		dprintf(STDERR_FILENO, "Superblock - %d blocks, %d blocks/group\n", super_buf.s_blocks_count, super_buf.s_blocks_per_group);
		exit(1);
	}
	if (super_buf.s_inodes_count % super_buf.s_inodes_per_group != 0)
	{
		dprintf(STDERR_FILENO,"Superblock - %d Inodes, %d Inodes/group\n",super_buf.s_inodes_count, super_buf.s_inodes_per_group);
		exit(1);
	}
	dprintf(superFd, "%x,%d,%d,%d,%d,%d,%d,%d,%d\n",super_buf.s_magic,super_buf.s_inodes_count,super_buf.s_blocks_count,block_size,block_size,super_buf.s_blocks_per_group,super_buf.s_inodes_per_group,super_buf.s_frags_per_group,super_buf.s_first_data_block);
	close(superFd);
	//printf("Superblock parsed!\n");
}


void parseGroup()
{
	groupFp = fopen("group.csv", "w");
	num_groups = ceil((double)super_buf.s_blocks_count/ super_buf.s_blocks_per_group);
	double remainder = num_groups - ((double)super_buf.s_blocks_count/ super_buf.s_blocks_per_group);
	group = malloc(sizeof(struct group_t) * num_groups);
	int offset;
	switch(block_size){
		case 1024:
			offset = 1024 + 1024;
			break;
		case 2048:
			offset = 2048;
			break;
		case 4096:
			offset = 4096;
			break;
	}
	int i;
	for(i = 0; i < num_groups; i++)
	{	
		int contained = super_buf.s_blocks_per_group;
		pread(imageFd,&group[i],sizeof(struct group_t),offset + i * 32);
		int start = i * super_buf.s_blocks_per_group;
		int end = start + super_buf.s_blocks_per_group;
		if (group[i].bg_inode_table < start || group[i].bg_inode_table > end)
		{
			dprintf(STDERR_FILENO,"Group %d: blocks %d-%d, Inode table starts at %d\n",i,start,end,group[i].bg_inode_table);
			exit(1);
		}
		if (group[i].bg_inode_bitmap < start || group[i].bg_inode_bitmap > end)
		{
			dprintf(STDERR_FILENO,"Group %d: blocks %d-%d, free Inode map starts at %d\n",i,start,end,group[i].bg_inode_bitmap);
			exit(1);
		}
		if (group[i].bg_block_bitmap < start || group[i].bg_block_bitmap > end)
		{
			dprintf(STDERR_FILENO, "Group %d: blocks %d-%d, free block map starts at %d\n",i,start,end,group[i].bg_block_bitmap);
			exit(1);
		}
		fprintf(groupFp,"%d,%d,%d,%d,%x,%x,%x\n",contained,group[i].bg_free_blocks_count,group[i].bg_free_inodes_count,group[i].bg_used_dirs_count,group[i].bg_inode_bitmap,group[i].bg_block_bitmap,group[i].bg_inode_table);
	}
	fclose(groupFp);
	//printf("Group descriptor parsed!\n");
}
void parseBitmap(){
	bitmapFp = fopen("bitmap.csv","w");
	int i;
	char buf;
	for (i = 0; i < num_groups; ++i)
	{
		int j;
		for (j = 0; j < block_size; j++)
		{
			pread(imageFd, &buf, 1, (group[i].bg_block_bitmap * block_size)+j);
			int8_t bit = 1;
			int k;
			for (k = 1; k <= 8; k++)
			{
				int used = buf & bit;
				if (!used)
				{
					fprintf(bitmapFp, "%x,", group[i].bg_block_bitmap);
					fprintf(bitmapFp, "%d\n", j * 8 + i * super_buf.s_blocks_per_group + k);
				}
				bit = bit << 1;
			}

		}
		for (j = 0; j < block_size; j++)
		{
			pread(imageFd, &buf, 1, (group[i].bg_inode_bitmap * block_size)+j);
			int8_t bit = 1;
			int k;
			for (k = 1; k <= 8; k++)
			{
				int used = buf & bit;
				if (!used)
				{
					fprintf(bitmapFp, "%x,", group[i].bg_inode_bitmap);
					fprintf(bitmapFp, "%d\n", j * 8 + i * super_buf.s_inodes_per_group + k);
				}
				bit = bit << 1;
			}

		}
	}
	fclose(bitmapFp);
	//printf("Bitmap parsed!\n");
}

void parseInode()
{
	inodeFp = fopen("inode.csv", "w");
	DirectoryInodes = malloc(sizeof(int*) * super_buf.s_inodes_count);
	int i;
	for(i = 0; i < super_buf.s_inodes_count; i++)
	{
		DirectoryInodes[i] = malloc(2 * sizeof(int));
	}
	RegularInodes = malloc(super_buf.s_inodes_count * sizeof(int));
	for(i = 0; i < num_groups; i++)
	{
		int j;
		for(j = 0;  j < block_size; j++)
		{
			char buf;
			pread(imageFd, &buf, 1, group[i].bg_inode_bitmap * block_size + j);
			int8_t bit = 1;
			int k;
			for(k = 1; k <= 8; k++)
			{
				int used = buf & bit;
				int base = group[i].bg_inode_table * block_size + (j * 8 + k - 1)*128;
				if (used != 0 && (j * 8 + k) <= super_buf.s_inodes_per_group)
				{
					uint16_t buf16;
					int InodeNumber = j * 8 + k + (i * super_buf.s_inodes_per_group);
					fprintf(inodeFp, "%d,", InodeNumber);
					pread(imageFd, &buf16, 2, base);
					RegularInodes[inodesCount] = base;
					inodesCount++;
					if (buf16 & 0x8000)
					{
						fprintf(inodeFp, "f,");					
					}
					else if(buf16 & 0xA000)
					{
						fprintf(inodeFp,"s,");
					}else if(buf16 & 0x4000){
						DirectoryInodes[dirInodesCount][0] = base;
						DirectoryInodes[dirInodesCount][1] = InodeNumber;
						dirInodesCount++;
						fprintf(inodeFp, "d,");
					}else {
						fprintf(inodeFp, "?,");
					}
					//mode
					fprintf(inodeFp, "%o,", buf16);
					//uid
					uint32_t uid = 0;
					uint32_t buf32 = 0;
					pread(imageFd, &buf32, 2, base + 2);
					uid = buf32;
					pread(imageFd, &buf32, 2, base + 116 + 4);
					uid = uid | (buf32 << 16);
					fprintf(inodeFp, "%d,", uid);
					//group
					uint32_t gid;
					pread(imageFd, &buf32, 2, base + 24);
					gid = buf32;
					pread(imageFd, &buf32, 2, base + 116 + 6);
					gid = gid | (buf32 << 16);
					fprintf(inodeFp, "%d,", gid);
					//link count
					pread(imageFd, &buf16, 2, base + 26);
					fprintf(inodeFp, "%d," , buf16);
					//creation time
					pread(imageFd, &buf32, 4, base + 12);
					fprintf(inodeFp, "%x,",buf32);
					//modification time
					pread(imageFd, &buf32, 4, base + 16);
					fprintf(inodeFp, "%x,", buf32);
					//access time
					pread(imageFd, &buf32, 4, base + 8);
					fprintf(inodeFp, "%x,", buf32);
					//file size
					uint64_t f_size;
					uint64_t buf64;
					pread(imageFd, &buf64, 4, base + 4);
					f_size = buf64;
					pread(imageFd, &buf64, 4, base + 108);
					f_size = f_size | (buf64 << 32);
					fprintf(inodeFp, "%ld,", f_size);
					//block counts
					pread(imageFd, &buf32, 4, base + 28);
					fprintf(inodeFp, "%d,", buf32/(block_size/512));
					//data block pointers
					int r;
					for(r = 0; r < 15; r++)
					{
						pread(imageFd, &buf32, 4, base + 40 + (r * 4));
						if (r != 14)
						{
							fprintf(inodeFp, "%x,", buf32);
						}else{
							fprintf(inodeFp, "%x", buf32);
						}
					}
					fprintf(inodeFp, "\n");
				}
				bit = bit << 1;
			}
		}
	}
	fclose(inodeFp);
	//printf("Inode table parsed!\n");
	//printf("Inode count: %d\n", inodesCount);
	//printf("Directory count: %d\n", dirInodesCount);
}

void parseDirectory()
{
	directoryFp = fopen("directory.csv", "w");
	int i;
	for(i = 0; i < dirInodesCount; i++)
	{
		int entry = 0;
		int j;
		uint32_t buf32;
		for(j = 0; j < 12; j++)
		{
			pread(imageFd, &buf32, 4, DirectoryInodes[i][0] + 40 + (j * 4));
			uint32_t offset = buf32;
			uint8_t buf8;
			uint16_t buf16;
			if(offset != 0)
			{
				int entryOffset = block_size * offset;
				while(entryOffset < block_size * offset + block_size)
				{
					pread(imageFd, &buf8, 1, entryOffset + 6);
					int name_len = buf8;
					pread(imageFd, &buf32, 4, entryOffset);
					int inodeNumber = buf32;
					pread(imageFd, &buf16, 2, entryOffset + 4);
					int rc_len = buf16;
					if (inodeNumber == 0)
					{
						entryOffset += rc_len;
						entry++;
						continue;
					}
					fprintf(directoryFp, "%d,", DirectoryInodes[i][1]);
					fprintf(directoryFp,"%d,", entry);
					entry++;
					fprintf(directoryFp, "%d,", rc_len);
					fprintf(directoryFp,"%d,",name_len);
					fprintf(directoryFp, "%d,", inodeNumber);
					fprintf(directoryFp,"\"");
					char name_buf;
					int k;
					for(k = 0; k < name_len; k++)
					{
						pread(imageFd, &name_buf, 1, entryOffset + 8 + k);
						fprintf(directoryFp, "%c", name_buf);
					}
					fprintf(directoryFp, "\"\n");
					entryOffset += rc_len;
				}
			}
		}
		pread(imageFd, &buf32, 4, DirectoryInodes[i][0] + 40 + 12*4);
		uint32_t offset = buf32;
		if (offset != 0)
		{
			for(j = 0; j < block_size / 4; j++)
			{
				int entryOffset = block_size * offset + (j*4);
				pread(imageFd, &buf32, 4, entryOffset);
				int secBlock = buf32;
				uint8_t buf8;
				uint16_t buf16;
				if (secBlock != 0)
				{
					entryOffset = secBlock * block_size;
					while(entryOffset < secBlock * block_size + block_size)
					{
						pread(imageFd, &buf8, 1, entryOffset + 6);
						int name_len = buf8;
						pread(imageFd, &buf32, 4, entryOffset);
						int inodeNumber = buf32;
						pread(imageFd, &buf16, 2, entryOffset + 4);
						int rc_len = buf16;
						if (inodeNumber == 0)
						{
							entryOffset += rc_len;
							entry++;
							continue;
						}
						fprintf(directoryFp, "%d,", DirectoryInodes[i][1]);
						fprintf(directoryFp,"%d,", entry);
						entry++;
						fprintf(directoryFp, "%d,", rc_len);
						fprintf(directoryFp,"%d,",name_len);
						fprintf(directoryFp, "%d,", inodeNumber);
						fprintf(directoryFp,"\"");
						char name_buf;
						int k;
						for(k = 0; k < name_len; k++)
						{
							pread(imageFd, &name_buf, 1, entryOffset + 8 + k);
							fprintf(directoryFp, "%c", name_buf);
						}
						fprintf(directoryFp, "\"\n");
						entryOffset += rc_len;
						
					}
				}
			}
		}

		pread(imageFd, &buf32, 4, DirectoryInodes[i][0] + 40 + 13*4);
		offset = buf32;
		if (offset != 0)
		{
			for(j = 0; j < block_size / 4; j++)
			{
				int entryOffset = block_size * offset + (j * 4);
				pread(imageFd, &buf32, 4, entryOffset);
				int secBlock = buf32;
				if (secBlock != 0)
				{
					int k;
					for(k = 0; k < block_size / 4; k++)
					{
						pread(imageFd, &buf32, 4, secBlock * block_size + k*4);
						int trdBlock = buf32;
						if (trdBlock != 0)
						{
							entryOffset = trdBlock * block_size;
							uint8_t buf8;
							uint16_t buf16;
							while(entryOffset < trdBlock * block_size + block_size)
							{

								pread(imageFd, &buf8, 1, entryOffset + 6);
								int name_len = buf8;
								pread(imageFd, &buf32, 4, entryOffset);
								int inodeNumber = buf32;
								pread(imageFd, &buf16, 2, entryOffset + 4);
								int rc_len = buf16;
								if (inodeNumber == 0)
								{
									entryOffset += rc_len;
									entry++;
									continue;
								}
								fprintf(directoryFp, "%d,", DirectoryInodes[i][1]);
								fprintf(directoryFp,"%d,", entry);
								entry++;
								fprintf(directoryFp, "%d,", rc_len);
								fprintf(directoryFp,"%d,",name_len);
								fprintf(directoryFp, "%d,", inodeNumber);
								fprintf(directoryFp,"\"");
								char name_buf;
								int k;
								for(k = 0; k < name_len; k++)
								{
									pread(imageFd, &name_buf, 1, entryOffset + 8 + k);
									fprintf(directoryFp, "%c", name_buf);
								}
								fprintf(directoryFp, "\"\n");
								entryOffset += rc_len;
							}
						}
					}
				}

			}
		}

		pread(imageFd, &buf32, 4, DirectoryInodes[i][0]+40+14*4);
		offset = buf32;
		if (offset != 0)
		{
			for(j = 0; j < block_size / 4; j++)
			{
				int entryOffset = block_size * offset + (j*4);
				pread(imageFd, &buf32, 4, entryOffset);
				int secBlock = buf32;
				if (secBlock != 0)
				{
					int k;
					for (k = 0; k < block_size / 4; k++)
					{
						pread(imageFd, &buf32, 4, secBlock*block_size + k*4);
						int trdBlock = buf32;
						if (trdBlock != 0)
						{
							int r;
							for(r = 0; r < block_size / 4; r++)
							{
								pread(imageFd, &buf32, 4, trdBlock * block_size+ r*4);
								int fthBlock = buf32;
								uint8_t buf8;
								uint16_t buf16;
								if (fthBlock != 0)
								{
									entryOffset = fthBlock * block_size;
									while(entryOffset< fthBlock * block_size + block_size)
									{
										pread(imageFd, &buf8, 1, entryOffset + 6);
										int name_len = buf8;
										pread(imageFd, &buf32, 4, entryOffset);
										int inodeNumber = buf32;
										pread(imageFd, &buf16, 2, entryOffset + 4);
										int rc_len = buf16;
										if (inodeNumber == 0)
										{
											entryOffset += rc_len;
											entry++;
											continue;
										}
										fprintf(directoryFp, "%d,", DirectoryInodes[i][1]);
										fprintf(directoryFp,"%d,", entry);
										entry++;
										fprintf(directoryFp, "%d,", rc_len);
										fprintf(directoryFp,"%d,",name_len);
										fprintf(directoryFp, "%d,", inodeNumber);
										fprintf(directoryFp,"\"");
										char name_buf;
										int k;
										for(k = 0; k < name_len; k++)
										{
											pread(imageFd, &name_buf, 1, entryOffset + 8 + k);
											fprintf(directoryFp, "%c", name_buf);
										}
										fprintf(directoryFp, "\"\n");
										entryOffset += rc_len;
									}
								}
							}
						}
					}
				}
			}
		}
	}
	fclose(directoryFp);
	//printf("Directory parsed!\n");
}

void parseIndirect()
{
	indirectFp = fopen("indirect.csv", "w");
	int entry = 0;
	uint32_t buf32;

	int i;
	for(i = 0; i < inodesCount; i++)
	{
		entry = 0;
		pread(imageFd, &buf32, 4, RegularInodes[i] + 40 + (12 * 4));
		int block_1_indirect = buf32;
		int j;
		if (block_1_indirect != 0)
		{
			for(j = 0; j < block_size / 4; j++)
			{
				pread(imageFd, &buf32, 4, block_1_indirect * block_size + j*4);
				int block_2_indirect = buf32;
				if (block_2_indirect != 0)
				{
					fprintf(indirectFp, "%x,", block_1_indirect);
					fprintf(indirectFp, "%d,", entry);
					entry++;
					fprintf(indirectFp, "%x\n", block_2_indirect);
				}
			}
		}else{
			continue;
		}
		entry = 0;
		pread(imageFd, &buf32, 4, RegularInodes[i] + 40 + 13*4);
		block_1_indirect = buf32;
		if (block_1_indirect != 0)
		{
			for(j = 0; j < block_size / 4; j++)
			{
				pread(imageFd, &buf32, 4, block_1_indirect * block_size + block_size);
				int block_2_indirect = buf32;
				if (block_2_indirect != 0)
				{
					fprintf(indirectFp, "%x,", block_1_indirect);
					fprintf(indirectFp, "%d,", entry);
					fprintf(indirectFp, "%x\n", block_2_indirect);
					entry++;
				}
			}
			entry = 0;
			for(j = 0; j < block_size / 4; j++)
			{
				pread(imageFd, &buf32, 4, block_1_indirect * block_size + j*4);
				int block_2_indirect = buf32;
				if (block_2_indirect != 0)
				{
					entry = 0;
					int k;
					for(k = 0; k < block_size/ 4; k++)
					{
						pread(imageFd, &buf32, 4, block_2_indirect * block_size + k*4);
						int block_3_indirect = buf32;
						if (block_3_indirect != 0)
						{
							fprintf(indirectFp, "%x,", block_2_indirect);
							fprintf(indirectFp, "%d,", entry);
							fprintf(indirectFp, "%x\n", block_3_indirect);
							entry++;
						}
					}
				}
			}
		}else{
			continue;
		}
		entry = 0;
		pread(imageFd, &buf32, 4, RegularInodes[i] + 40 + (14*4));
		block_1_indirect = buf32;
		if (block_1_indirect != 0)
		{
			for(j = 0; j < block_size / 4; j++)
			{
				pread(imageFd, &buf32, 4, block_1_indirect * block_size + j*4);
				int block_2_indirect = buf32;
				if (block_2_indirect != 0)
				{
					fprintf(indirectFp, "%x,", block_1_indirect);
					fprintf(indirectFp, "%d,", entry);
					entry++;
					fprintf(indirectFp, "%x\n", block_2_indirect);
				}
			}
			entry = 0;
			for(j = 0; j < block_size / 4; j++)
			{
				pread(imageFd, &buf32, 4, block_1_indirect * block_size + j*4);
				int block_2_indirect = buf32;
				if (block_2_indirect != 0)
				{
					entry = 0;
					int k;
					for(k = 0; k < block_size/ 4; k++)
					{
						pread(imageFd, &buf32, 4, block_2_indirect * block_size + k*4);
						int block_3_indirect = buf32;
						if (block_3_indirect != 0)
						{
							fprintf(indirectFp, "%x,", block_2_indirect);
							fprintf(indirectFp, "%d,", entry);
							fprintf(indirectFp, "%x\n", block_3_indirect);
							entry++;
						}
					}
				}
			}
			entry = 0;
	
			for(j = 0; j < block_size / 4; j++)
			{
				pread(imageFd, &buf32, 4, block_1_indirect * block_size + j*4);
				int block_2_indirect = buf32;
				if (block_2_indirect != 0)
				{
					entry = 0;
					int k;
					for(k = 0; k < block_size / 4; k++)
					{
						pread(imageFd, &buf32, 4, block_2_indirect * block_size + (k*4));
						int block_3_indirect = buf32;
						if (block_3_indirect != 0)
						{
							entry = 0;
							int r;
							for(r = 0; r < block_size / 4; r++)
							{
								pread(imageFd, &buf32, 4, block_3_indirect * block_size + r * 4);
								int block_4_indirect = buf32;
								if (block_4_indirect != 0)
								{
									fprintf(indirectFp, "%x,", block_3_indirect);
									fprintf(indirectFp, "%d,", entry);
									fprintf(indirectFp, "%x\n", block_4_indirect);
									entry++;
								}
							}
						}
					}
				}
			}
		}
	}
	fclose(indirectFp);
	//printf("Indirect parsed!\n");
}


int main(int argc, char **argv)
{
	parseArgs(argc, argv);
	parseSuper();
	parseGroup();
	parseBitmap();
	parseInode();
	parseDirectory();
	parseIndirect();
	close(imageFd);
	exit(EXIT_SUCCESS);
}


















