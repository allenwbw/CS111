#!/bin/bash

echo "./lab2_add --threads=2 --iterations=100"
(>&2 echo "./lab2_add --threads=2 --iterations=100")
for i in `seq 1 10`; do
    ./lab2_add --threads=2 --iterations=100 >> lab2_add.csv
done

echo "./lab2_add --threads=2 --iterations=1000"
(>&2 echo "./lab2_add --threads=2 --iterations=1000")
for i in `seq 1 10`; do
    ./lab2_add --threads=2 --iterations=1000 >> lab2_add.csv
done

echo "./lab2_add --threads=2 --iterations=10000"
(>&2 echo "./lab2_add --threads=2 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --threads=2 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --threads=2 --iterations=100000"
(>&2 echo "./lab2_add --threads=2 --iterations=100000")
for i in `seq 1 10`; do
    ./lab2_add --threads=2 --iterations=100000 >> lab2_add.csv
done

echo "./lab2_add --threads=4 --iterations=100"
(>&2 echo "./lab2_add --threads=4 --iterations=100")
for i in `seq 1 10`; do
    ./lab2_add --threads=4 --iterations=100 >> lab2_add.csv
done

echo "./lab2_add --threads=4 --iterations=1000"
(>&2 echo "./lab2_add --threads=4 --iterations=1000")
for i in `seq 1 10`; do
    ./lab2_add --threads=4 --iterations=1000 >> lab2_add.csv
done

echo "./lab2_add --threads=4 --iterations=10000"
(>&2 echo "./lab2_add --threads=4 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --threads=4 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --threads=4 --iterations=100000"
(>&2 echo "./lab2_add --threads=4 --iterations=100000")
for i in `seq 1 10`; do
    ./lab2_add --threads=4 --iterations=100000 >> lab2_add.csv
done

echo "./lab2_add --threads=8 --iterations=100"
(>&2 echo "./lab2_add --threads=8 --iterations=100")
for i in `seq 1 10`; do
    ./lab2_add --threads=8 --iterations=100 >> lab2_add.csv
done

echo "./lab2_add --threads=8 --iterations=1000"
(>&2 echo "./lab2_add --threads=8 --iterations=1000")
for i in `seq 1 10`; do
    ./lab2_add --threads=8 --iterations=1000 >> lab2_add.csv
done

echo "./lab2_add --threads=8 --iterations=10000"
(>&2 echo "./lab2_add --threads=8 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --threads=8 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --threads=8 --iterations=100000"
(>&2 echo "./lab2_add --threads=8 --iterations=100000")
for i in `seq 1 10`; do
    ./lab2_add --threads=8 --iterations=100000 >> lab2_add.csv
done

echo "./lab2_add --threads=1 --iterations=100"
(>&2 echo "./lab2_add --threads=1 --iterations=100")
for i in `seq 1 10`; do
    ./lab2_add --threads=1 --iterations=100 >> lab2_add.csv
done

echo "./lab2_add --threads=1 --iterations=1000"
(>&2 echo "./lab2_add --threads=1 --iterations=1000")
for i in `seq 1 10`; do
    ./lab2_add --threads=1 --iterations=1000 >> lab2_add.csv
done


echo "./lab2_add --threads=1 --iterations=10000"
(>&2 echo "./lab2_add --threads=1 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --threads=1 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --threads=1 --iterations=100000"
(>&2 echo "./lab2_add --threads=1 --iterations=100000")
for i in `seq 1 10`; do
    ./lab2_add --threads=1 --iterations=100000 >> lab2_add.csv
done

echo "./lab2_add --threads=1 --iterations=100"
(>&2 echo "./lab2_add --threads=1 --iterations=100")
for i in `seq 1 10`; do
    ./lab2_add --threads=1 --iterations=100 >> lab2_add.csv
done

echo "./lab2_add --threads=1 --iterations=1000"
(>&2 echo "./lab2_add --threads=1 --iterations=1000")
for i in `seq 1 10`; do
    ./lab2_add --threads=1 --iterations=1000 >> lab2_add.csv
done


echo "./lab2_add --threads=1 --iterations=10000"
(>&2 echo "./lab2_add --threads=1 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --threads=1 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --threads=1 --iterations=100000"
(>&2 echo "./lab2_add --threads=1 --iterations=100000")
for i in `seq 1 10`; do
    ./lab2_add --threads=1 --iterations=100000 >> lab2_add.csv
done

############ test_yield ############

echo "./lab2_add --yield --threads=2 --iterations=10"
(>&2 echo "./lab2_add --yield --threads=2 --iterations=10")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=2 --iterations=10 >> lab2_add.csv
done

echo "./lab2_add --yield --threads=2 --iterations=20"
(>&2 echo "./lab2_add --yield --threads=2 --iterations=20")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=2 --iterations=20 >> lab2_add.csv
done

echo "./lab2_add --yield --threads=2 --iterations=40"
(>&2 echo "./lab2_add --yield --threads=2 --iterations=40")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=2 --iterations=40 >> lab2_add.csv
done

echo "./lab2_add --yield --threads=2 --iterations=80"
(>&2 echo "./lab2_add --yield --threads=2 --iterations=80")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=2 --iterations=80 >> lab2_add.csv
done

echo "./lab2_add --yield --threads=2 --iterations=100"
(>&2 echo "./lab2_add --yield --threads=2 --iterations=100")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=2 --iterations=100 >> lab2_add.csv
done

echo "./lab2_add --yield --threads=2 --iterations=1000"
(>&2 echo "./lab2_add --yield --threads=2 --iterations=1000")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=2 --iterations=1000 >> lab2_add.csv
done

echo "./lab2_add --yield --threads=2 --iterations=10000"
(>&2 echo "./lab2_add --yield --threads=2 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=2 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --yield --threads=2 --iterations=100000"
(>&2 echo "./lab2_add --yield --threads=2 --iterations=100000")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=2 --iterations=100000 >> lab2_add.csv
done

echo "./lab2_add --yield --threads=4 --iterations=10"
(>&2 echo "./lab2_add --yield --threads=4 --iterations=10")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=4 --iterations=10 >> lab2_add.csv
done

echo "./lab2_add --yield --threads=4 --iterations=20"
(>&2 echo "./lab2_add --yield --threads=4 --iterations=20")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=4 --iterations=20 >> lab2_add.csv
done

echo "./lab2_add --yield --threads=4 --iterations=40"
(>&2 echo "./lab2_add --yield --threads=4 --iterations=40")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=4 --iterations=40 >> lab2_add.csv
done

echo "./lab2_add --yield --threads=4 --iterations=80"
(>&2 echo "./lab2_add --yield --threads=4 --iterations=80")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=4 --iterations=80 >> lab2_add.csv
done

echo "./lab2_add --yield --threads=4 --iterations=100"
(>&2 echo "./lab2_add --yield --threads=4 --iterations=100")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=4 --iterations=100 >> lab2_add.csv
done

echo "./lab2_add --yield --threads=4 --iterations=1000"
(>&2 echo "./lab2_add --yield --threads=4 --iterations=1000")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=4 --iterations=1000 >> lab2_add.csv
done

echo "./lab2_add --yield --threads=4 --iterations=10000"
(>&2 echo "./lab2_add --yield --threads=4 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=4 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --yield --threads=4 --iterations=100000"
(>&2 echo "./lab2_add --yield --threads=4 --iterations=100000")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=4 --iterations=100000 >> lab2_add.csv
done

echo "./lab2_add --yield --threads=8 --iterations=10"
(>&2 echo "./lab2_add --yield --threads=8 --iterations=10")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=8 --iterations=10 >> lab2_add.csv
done

echo "./lab2_add --yield --threads=8 --iterations=20"
(>&2 echo "./lab2_add --yield --threads=8 --iterations=20")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=8 --iterations=20 >> lab2_add.csv
done

echo "./lab2_add --yield --threads=8 --iterations=40"
(>&2 echo "./lab2_add --yield --threads=8 --iterations=40")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=8 --iterations=40 >> lab2_add.csv
done

echo "./lab2_add --yield --threads=8 --iterations=80"
(>&2 echo "./lab2_add --yield --threads=8 --iterations=80")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=8 --iterations=80 >> lab2_add.csv
done

echo "./lab2_add --yield --threads=8 --iterations=100"
(>&2 echo "./lab2_add --yield --threads=8 --iterations=100")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=8 --iterations=100 >> lab2_add.csv
done

echo "./lab2_add --yield --threads=8 --iterations=1000"
(>&2 echo "./lab2_add --yield --threads=8 --iterations=1000")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=8 --iterations=1000 >> lab2_add.csv
done

echo "./lab2_add --yield --threads=8 --iterations=10000"
(>&2 echo "./lab2_add --yield --threads=8 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=8 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --yield --threads=8 --iterations=100000"
(>&2 echo "./lab2_add --yield --threads=8 --iterations=100000")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=8 --iterations=100000 >> lab2_add.csv
done

echo "./lab2_add --yield --threads=12 --iterations=10"
(>&2 echo "./lab2_add --yield --threads=12 --iterations=10")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=12 --iterations=10 >> lab2_add.csv
done

echo "./lab2_add --yield --threads=12 --iterations=20"
(>&2 echo "./lab2_add --yield --threads=12 --iterations=20")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=12 --iterations=20 >> lab2_add.csv
done

echo "./lab2_add --yield --threads=12 --iterations=40"
(>&2 echo "./lab2_add --yield --threads=12 --iterations=40")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=12 --iterations=40 >> lab2_add.csv
done

echo "./lab2_add --yield --threads=12 --iterations=80"
(>&2 echo "./lab2_add --yield --threads=12 --iterations=80")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=12 --iterations=80 >> lab2_add.csv
done

echo "./lab2_add --yield --threads=12 --iterations=100"
(>&2 echo "./lab2_add --yield --threads=12 --iterations=100")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=12 --iterations=100 >> lab2_add.csv
done

echo "./lab2_add --yield --threads=12 --iterations=1000"
(>&2 echo "./lab2_add --yield --threads=12 --iterations=1000")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=12 --iterations=1000 >> lab2_add.csv
done


echo "./lab2_add --yield --threads=12 --iterations=10000"
(>&2 echo "./lab2_add --yield --threads=12 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=12 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --yield --threads=12 --iterations=100000"
(>&2 echo "./lab2_add --yield --threads=12 --iterations=100000")
for i in `seq 1 10`; do
    ./lab2_add --yield --threads=12 --iterations=100000 >> lab2_add.csv
done

############# test_yield_protected ###############

echo "./lab2_add --yield --sync=m --threads=2 --iterations=10000"
(>&2 echo "./lab2_add --yield --sync=m --threads=2 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --yield --sync=m --threads=2 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --yield --sync=m --threads=4 --iterations=10000"
(>&2 echo "./lab2_add --yield --sync=m --threads=4 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --yield --sync=m --threads=4 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --yield --sync=m --threads=8 --iterations=10000"
(>&2 echo "./lab2_add --yield --sync=m --threads=8 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --yield --sync=m --threads=8 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --yield --sync=m --threads=12 --iterations=10000"
(>&2 echo "./lab2_add --yield --sync=m --threads=12 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --yield --sync=m --threads=12 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --yield --sync=c --threads=2 --iterations=10000"
(>&2 echo "./lab2_add --yield --sync=c --threads=2 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --yield --sync=c --threads=2 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --yield --sync=c --threads=4 --iterations=10000"
(>&2 echo "./lab2_add --yield --sync=c --threads=4 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --yield --sync=c --threads=4 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --yield --sync=c --threads=8 --iterations=10000"
(>&2 echo "./lab2_add --yield --sync=c --threads=8 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --yield --sync=c --threads=8 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --yield --sync=c --threads=12 --iterations=10000"
(>&2 echo "./lab2_add --yield --sync=c --threads=12 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --yield --sync=c --threads=12 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --yield --sync=s --threads=2 --iterations=1000"
(>&2 echo "./lab2_add --yield --sync=s --threads=2 --iterations=1000")
for i in `seq 1 10`; do
    ./lab2_add --yield --sync=s --threads=2 --iterations=1000 >> lab2_add.csv
done

echo "./lab2_add --yield --sync=s --threads=4 --iterations=1000"
(>&2 echo "./lab2_add --yield --sync=s --threads=4 --iterations=1000")
for i in `seq 1 10`; do
    ./lab2_add --yield --sync=s --threads=4 --iterations=1000 >> lab2_add.csv
done

echo "./lab2_add --yield --sync=s --threads=8 --iterations=1000"
(>&2 echo "./lab2_add --yield --sync=s --threads=8 --iterations=1000")
for i in `seq 1 10`; do
    ./lab2_add --yield --sync=s --threads=8 --iterations=1000 >> lab2_add.csv
done

echo "./lab2_add --yield --sync=s --threads=12 --iterations=1000"
(>&2 echo "./lab2_add --yield --sync=s --threads=12 --iterations=1000")
for i in `seq 1 10`; do
    ./lab2_add --yield --sync=s --threads=12 --iterations=1000 >> lab2_add.csv
done

############## test_protected #############

echo "./lab2_add --threads=1 --iterations=10000"
(>&2 echo "./lab2_add --threads=1 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --threads=1 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --threads=2 --iterations=10000"
(>&2 echo "./lab2_add --threads=2 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --threads=2 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --threads=4 --iterations=10000"
(>&2 echo "./lab2_add --threads=4 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --threads=4 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --threads=8 --iterations=10000"
(>&2 echo "./lab2_add --threads=8 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --threads=8 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --threads=12 --iterations=10000"
(>&2 echo "./lab2_add --threads=12 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --threads=12 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --sync=m --threads=1 --iterations=10000"
(>&2 echo "./lab2_add --sync=m --threads=1 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --sync=m --threads=1 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --sync=m --threads=2 --iterations=10000"
(>&2 echo "./lab2_add --sync=m --threads=2 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --sync=m --threads=2 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --sync=m --threads=4 --iterations=10000"
(>&2 echo "./lab2_add --sync=m --threads=4 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --sync=m --threads=4 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --sync=m --threads=8 --iterations=10000"
(>&2 echo "./lab2_add --sync=m --threads=8 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --sync=m --threads=8 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --sync=m --threads=12 --iterations=10000"
(>&2 echo "./lab2_add --sync=m --threads=12 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --sync=m --threads=12 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --sync=c --threads=1 --iterations=10000"
(>&2 echo "./lab2_add --sync=c --threads=1 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --sync=c --threads=1 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --sync=c --threads=2 --iterations=10000"
(>&2 echo "./lab2_add --sync=c --threads=2 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --sync=c --threads=2 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --sync=c --threads=4 --iterations=10000"
(>&2 echo "./lab2_add --sync=c --threads=4 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --sync=c --threads=4 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --sync=c --threads=8 --iterations=10000"
(>&2 echo "./lab2_add --sync=c --threads=8 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --sync=c --threads=8 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --sync=c --threads=12 --iterations=10000"
(>&2 echo "./lab2_add --sync=c --threads=12 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --sync=c --threads=12 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --sync=s --threads=1 --iterations=10000"
(>&2 echo "./lab2_add --sync=s --threads=1 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --sync=s --threads=1 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --sync=s --threads=2 --iterations=10000"
(>&2 echo "./lab2_add --sync=s --threads=2 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --sync=s --threads=2 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --sync=s --threads=4 --iterations=10000"
(>&2 echo "./lab2_add --sync=s --threads=4 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --sync=s --threads=4 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --sync=s --threads=8 --iterations=10000"
(>&2 echo "./lab2_add --sync=s --threads=8 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --sync=s --threads=8 --iterations=10000 >> lab2_add.csv
done

echo "./lab2_add --sync=s --threads=12 --iterations=10000"
(>&2 echo "./lab2_add --sync=s --threads=12 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2_add --sync=s --threads=12 --iterations=10000 >> lab2_add.csv
done
