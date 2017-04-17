import sys
import os
import csv

class Block(object):
	def __init__(self,number):
		self._number = number
		self._referencedBy = []
		return

class Inode(object):
	def __init__(self, number, linksCount):
		self._number = number
		self._linksCount = linksCount
		self._referencedBy = []
		self._ptrList = []
		return

class Parser(object):
	def  __init__(self):
		self._numBlocks = 0
		self._numInodes = 0
		self._blockSize = 0
		self._blocksPerGroup = 0
		self._inodesPerGroup = 0
		self._inodeDict = {}
		self._blockDict = {}
		self._indirectDict = {}
		self._directoryDict = {}

		self._inodeBitmap = []
		self._blockBitmap = []
		self._inodeFree = []
		self._blockFree = []

		self._unallocatedInodes = {}
		self._incorrectEntries = []
		self._invalidBlocks = []
		return
	def parseSuper(self):
		with open("super.csv", 'r') as superfile:
			reader = csv.reader(superfile, delimiter = ',',quotechar = '|')
			for row in reader:
				self._numInodes = int(row[1])
				self._numBlocks = int(row[2])
				self._blockSize = int(row[3])
				self._blocksPerGroup = int(row[5])
				self._inodesPerGroup = int(row[6])
		return
	def parseGroup(self):
		with open("group.csv",'r') as groupfile:
			reader = csv.reader(groupfile, delimiter = ',',quotechar = '|')
			for row in reader:
				self._inodeBitmap.append((int(row[4], 16)))
				self._blockBitmap.append(int(row[5], 16))
				inodeBitmap = Block(int(row[4],16))
				self._blockDict[int(row[4],16)] = inodeBitmap
				blockBitmap = Block(int(row[5],16))
				self._blockDict[int(row[5], 16)] = blockBitmap
		return

	def parseBitmap(self):
		with open("bitmap.csv") as bitmapfile:
			reader = csv.reader(bitmapfile, delimiter=',', quotechar='|')
			for row in reader:
				blockNum = int(row[0], 16)
				if blockNum in self._inodeBitmap:
					self._inodeFree.append(int(row[1]))
				elif blockNum in self._blockBitmap:
					self._blockFree.append(int(row[1]))
		return

	def parseIndirect(self):
		with open("indirect.csv", 'r') as indirectfile:
			reader = csv.reader(indirectfile, delimiter=',', quotechar='|')
			for row in reader:
				containingBlock = int(row[0], 16)
				entryNum = int(row[1])
				blockPointer = int(row[2], 16)
				if containingBlock in self._indirectDict:
					self._indirectDict[containingBlock].append((entryNum, blockPointer))
				else:
					self._indirectDict[containingBlock] = [(entryNum, blockPointer)]
		return

	def parseDirectory(self):
		with open("directory.csv", 'r') as directoryfile:
			reader = csv.reader(directoryfile, delimiter=',', quotechar='\"')
			for row in reader:
				inodeNum = int(row[4])
				parentInode = int(row[0])
				entryNum = int(row[1])
				name = row[5]
				if inodeNum != parentInode or parentInode == 2:
					self._directoryDict[inodeNum] = parentInode
				if inodeNum in self._inodeDict:
					self._inodeDict[inodeNum]._referencedBy.append((parentInode, entryNum))
				else:
					if inodeNum in self._unallocatedInodes:
						self._unallocatedInodes[inodeNum].append((parentInode, entryNum))
					else:
						self._unallocatedInodes[inodeNum] = [(parentInode, entryNum)]

				if entryNum == 0:
					if inodeNum != parentInode:
						self._incorrectEntries.append((parentInode, name, inodeNum, parentInode))
				elif entryNum == 1:
					if parentInode not in self._directoryDict or inodeNum != self._directoryDict[parentInode]:
						self._incorrectEntries.append((parentInode, name, inodeNum, self._directoryDict[parentInode]))
		return

	def parseInode(self):
		with open("inode.csv", 'r') as inodefile:
			reader = csv.reader(inodefile, delimiter=',', quotechar='\"')
			for row in reader:
				numBlocks = int(row[10])
				inodeNum = int(row[0])
				linksCount = int(row[5])
				self._inodeDict[inodeNum] = Inode(inodeNum, linksCount)

				maxBlocks = min(12, numBlocks) + 11
				for i in range(11, maxBlocks):
					blockNum = int(row[i],16)
					self.updateBlockReference(blockNum, inodeNum, 0, i - 11)

				numRemainBlocks = numBlocks - 12
				if numRemainBlocks > 0:
					blockNum = int(row[23],16)
					if blockNum == 0 or blockNum > self._numBlocks:
						self._invalidBlocks.append((blockNum, inodeNum, 0, 12))
					else:
						count = self.checkIndirectBlock(blockNum, inodeNum, 0, 12)
						numRemainBlocks -= count
				if numRemainBlocks > 0:
					blockNum = int(row[24],16)
					if blockNum == 0 or blockNum > self._numBlocks:
						self._invalidBlocks.append((blockNum, inodeNum, 0, 13))
					else:
						count = self.checkDoublyBlock(blockNum, inodeNum, 0, 13)
						numRemainBlocks -= count
				if numRemainBlocks > 0:
					blockNum = int(row[25],16)
					if blockNum == 0 or blockNum > self._numBlocks:
						self._invalidBlocks.append((blockNum, inodeNum, 0, 14))
					else:
						count = self.checkTriplyBlock(blockNum, inodeNum, 0, 14)
						numRemainBlocks -= count
		return

	def checkIndirectBlock(self, blockNum, inodeNum, indirectBlock, entryNum):
		count = 1
		self.updateBlockReference(blockNum, inodeNum, indirectBlock, entryNum)
		if blockNum in self._indirectDict:
			for entry in self._indirectDict[blockNum]:
				self.updateBlockReference(entry[1], inodeNum, blockNum, entry[0])
				count += 1
		return count

	def checkDoublyBlock(self, blockNum, inodeNum, indirectBlock, entryNum):
		count = 1
		self.updateBlockReference(blockNum, inodeNum, indirectBlock, entryNum)
		if blockNum in self._indirectDict:
			for entry in self._indirectDict[blockNum]:
				count += self.checkIndirectBlock(entry[1], inodeNum, blockNum, entry[0])
		return count

	def checkTriplyBlock(self, blockNum, inodeNum, indirectBlock, entryNum):
		count = 1
		self.updateBlockReference(blockNum, inodeNum, indirectBlock, entryNum)
		if blockNum in self._indirectDict:
			for entry in self._indirectDict[blockNum]:
				count += self.checkDoublyBlock(entry[1], inodeNum, blockNum, entry[0])
		return count

	def updateBlockReference(self, blockNum, inodeNum, indirectBlock, entryNum):
		if blockNum == 0 or blockNum > self._numBlocks:
			if inodeNum == 30721:
				print("update.\n")
			self._invalidBlocks.append((blockNum, inodeNum, indirectBlock, entryNum))
		else:
			if blockNum not in self._blockDict:
				self._blockDict[blockNum] = Block(blockNum)
			self._blockDict[blockNum]._referencedBy.append((inodeNum, indirectBlock, entryNum))
		return
	def parseEverything(self):
		self.parseSuper()
		self.parseGroup()
		self.parseBitmap()
		self.parseInode()
		self.parseDirectory()
		self.parseIndirect()
		return

	def errorOutput(self):
		logfile = open("lab3b_check.txt",'w')
		for entry in sorted(self._invalidBlocks):
			if entry[1] == 30721:
				continue
			logfile.write("INVALID BLOCK < " + str(entry[0]) + " > IN INODE < " + str(entry[1]) + " > (INDIRECT BLOCK < " + str(entry[2]) + " >) ENTRY < " + str(entry[3]) + " >\n")
		for entry in sorted(self._incorrectEntries):
			logfile.write("INCORRECT ENTRY IN < " + str(entry[0]) + " > NAME < " + str(entry[1]) + " > LINK TO < " + str(entry[2]) + " > SHOULD BE < " + str(entry[3]) + " >\n")
		for entry in sorted(self._inodeDict):
			linkCount = len(self._inodeDict[entry]._referencedBy)
			if entry > 10 and linkCount == 0:
				bitmapBlock = self._inodeBitmap[entry / self._inodesPerGroup]
				logfile.write("MISSING INODE < " + str(entry) + " > SHOULD BE IN FREE LIST < " + str(bitmapBlock) + " >\n")
			elif linkCount != self._inodeDict[entry]._linksCount:
				logfile.write("LINKCOUNT < " + str(entry) + " > IS < " + str(self._inodeDict[entry]._linksCount) + " > SHOULD BE < " + str(linkCount) + " >\n")
			if entry in self._inodeFree:
				logfile.write("UNALLOCATED INODE < " + str(entry) + " >\n")
		

		
		
		for i in range(11, self._numInodes):
			if i not in self._inodeFree and i not in self._inodeDict:
				bitmapBlock = self._inodeBitmap[i / self._inodesPerGroup]
				logfile.write("MISSING INODE < " + str(i) + " > SHOULD BE IN FREE LIST < " + str(bitmapBlock) + " >\n")
		for entry in sorted(self._blockDict):
			if len(self._blockDict[entry]._referencedBy) > 1:
				log = "MULTIPLY REFERENCED BLOCK < " + str(entry) + " > BY "
				for item in sorted(self._blockDict[entry]._referencedBy):
					if item[1] == 0:
						log += "INODE < " + str(item[0]) + " > ENTRY < " + str(item[2]) + " > "
					else:
						log += "INODE < " + str(item[0]) + " > INDIRECT BLOCK < " + str(item[1]) + " > ENTRY < " + str(item[2]) + " > "
				logfile.write(log.strip() + "\n")

			if entry in self._blockFree:
				log = "UNALLOCATED BLOCK < " + str(entry) + " > REFERENCED BY "
				for item in sorted(self._blockDict[entry]._referencedBy):
					if item[1] == 0:
						log += "INODE < " + str(item[0]) + " > ENTRY < " + str(item[2]) + " > "
					else:
						log += "INODE < " + str(item[0]) + " > INDIRECT BLOCK < " + str(item[1]) + " > ENTRY < " + str(item[2]) + " > "
				logfile.write(log.strip()+"\n")
		for entry in sorted(self._unallocatedInodes):
			log = "UNALLOCATED INODE < " + str(entry) + " > REFERENCED BY "
			for item in sorted(self._unallocatedInodes[entry]):
				log += "DIRECTORY < " + str(item[0]) + " > ENTRY < " + str(item[1]) + " > "
				logfile.write(log.strip() + "\n")
		

		logfile.close()
		return

if __name__ == "__main__":
	fileparser = Parser()
	fileparser.parseEverything()
	fileparser.errorOutput()









