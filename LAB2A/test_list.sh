#!/bin/bash

#
echo "./lab2-list --threads=1 --iterations=10"
(>&2 echo "./lab2-list --threads=1 --iterations=10")
for i in `seq 1 10`; do
    ./lab2-list --threads=1 --iterations=10 >> lab2_list.csv
done

echo "./lab2-list --threads=1 --iterations=100"
(>&2 echo "./lab2-list --threads=1 --iterations=100")
for i in `seq 1 10`; do
    ./lab2-list --threads=1 --iterations=100 >> lab2_list.csv
done

echo "./lab2-list --threads=1 --iterations=1000"
(>&2 echo "./lab2-list --threads=1 --iterations=1000")
for i in `seq 1 10`; do
    ./lab2-list --threads=1 --iterations=1000 >> lab2_list.csv
done

echo "./lab2-list --threads=1 --iterations=10000"
(>&2 echo "./lab2-list --threads=1 --iterations=10000")
for i in `seq 1 10`; do
    ./lab2-list --threads=1 --iterations=10000 >> lab2_list.csv
done

echo "./lab2-list --threads=1 --iterations=20000"
(>&2 echo "./lab2-list --threads=1 --iterations=20000")
for i in `seq 1 10`; do
    ./lab2-list --threads=1 --iterations=20000 >> lab2_list.csv
done

########## parallel without yield ##########
### threads = 2
echo "./lab2-list --threads=2 --iterations=10"
(>&2 echo "./lab2-list --threads=2 --iterations=10")
for i in `seq 1 10`; do
    ./lab2-list --threads=2 --iterations=10 >> lab2_list.csv || true
done

echo "./lab2-list --threads=2 --iterations=100"
(>&2 echo "./lab2-list --threads=2 --iterations=100")
for i in `seq 1 10`; do
    ./lab2-list --threads=2 --iterations=100 >> lab2_list.csv || true
done

echo "./lab2-list --threads=2 --iterations=1000"
(>&2 echo "./lab2-list --threads=2 --iterations=1000")
for i in `seq 1 10`; do
    ./lab2-list --threads=2 --iterations=1000 >> lab2_list.csv || true
done

### threads = 4
echo "./lab2-list --threads=4 --iterations=10"
(>&2 echo "./lab2-list --threads=4 --iterations=10")
for i in `seq 1 10`; do
    ./lab2-list --threads=4 --iterations=10 >> lab2_list.csv || true
done

echo "./lab2-list --threads=4 --iterations=100"
(>&2 echo "./lab2-list --threads=4 --iterations=100")
for i in `seq 1 10`; do
    ./lab2-list --threads=4 --iterations=100 >> lab2_list.csv || true
done

echo "./lab2-list --threads=4 --iterations=1000"
(>&2 echo "./lab2-list --threads=4 --iterations=1000")
for i in `seq 1 10`; do
    ./lab2-list --threads=4 --iterations=1000 >> lab2_list.csv || true
done

### threads = 8
echo "./lab2-list --threads=8 --iterations=10"
(>&2 echo "./lab2-list --threads=8 --iterations=10")
for i in `seq 1 10`; do
    ./lab2-list --threads=8 --iterations=10 >> lab2_list.csv || true
done

echo "./lab2-list --threads=8 --iterations=100"
(>&2 echo "./lab2-list --threads=8 --iterations=100")
for i in `seq 1 10`; do
    ./lab2-list --threads=8 --iterations=100 >> lab2_list.csv || true
done

echo "./lab2-list --threads=8 --iterations=1000"
(>&2 echo "./lab2-list --threads=8 --iterations=1000")
for i in `seq 1 10`; do
    ./lab2-list --threads=8 --iterations=1000 >> lab2_list.csv || true
done

### threads = 12
echo "./lab2-list --threads=12 --iterations=10"
(>&2 echo "./lab2-list --threads=12 --iterations=10")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --iterations=10 >> lab2_list.csv || true
done

echo "./lab2-list --threads=12 --iterations=100"
(>&2 echo "./lab2-list --threads=12 --iterations=100")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --iterations=100 >> lab2_list.csv || true
done

echo "./lab2-list --threads=12 --iterations=1000"
(>&2 echo "./lab2-list --threads=12 --iterations=1000")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --iterations=1000 >> lab2_list.csv || true
done

########## parallel with various yielding combination ###########
### threads = 2
echo "./lab2-list --threads=2 --yield=i --iterations=2"
(>&2 echo "./lab2-list --threads=2 --yield=i --iterations=2")
for i in `seq 1 10`; do
    ./lab2-list --threads=2 --yield=i --iterations=2 >> lab2_list.csv || true
done

echo "./lab2-list --threads=2 --yield=i --iterations=4"
(>&2 echo "./lab2-list --threads=2 --yield=i --iterations=4")
for i in `seq 1 10`; do
    ./lab2-list --threads=2 --yield=i --iterations=4 >> lab2_list.csv || true
done

echo "./lab2-list --threads=2 --yield=i --iterations=8"
(>&2 echo "./lab2-list --threads=2 --yield=i --iterations=8")
for i in `seq 1 10`; do
    ./lab2-list --threads=2 --yield=i --iterations=8 >> lab2_list.csv || true
done

echo "./lab2-list --threads=2 --yield=i --iterations=16"
(>&2 echo "./lab2-list --threads=2 --yield=i --iterations=16")
for i in `seq 1 10`; do
    ./lab2-list --threads=2 --yield=i --iterations=16 >> lab2_list.csv || true
done

echo "./lab2-list --threads=2 --yield=i --iterations=32"
(>&2 echo "./lab2-list --threads=2 --yield=i --iterations=32")
for i in `seq 1 10`; do
    ./lab2-list --threads=2 --yield=i --iterations=32 >> lab2_list.csv || true
done

echo "./lab2-list --threads=2 --yield=d --iterations=2"
(>&2 echo "./lab2-list --threads=2 --yield=d --iterations=2")
for i in `seq 1 10`; do
    ./lab2-list --threads=2 --yield=d --iterations=2 >> lab2_list.csv || true
done

echo "./lab2-list --threads=2 --yield=d --iterations=4"
(>&2 echo "./lab2-list --threads=2 --yield=d --iterations=4")
for i in `seq 1 10`; do
    ./lab2-list --threads=2 --yield=d --iterations=4 >> lab2_list.csv || true
done

echo "./lab2-list --threads=2 --yield=d --iterations=8"
(>&2 echo "./lab2-list --threads=2 --yield=d --iterations=8")
for i in `seq 1 10`; do
    ./lab2-list --threads=2 --yield=d --iterations=8 >> lab2_list.csv || true
done

echo "./lab2-list --threads=2 --yield=d --iterations=16"
(>&2 echo "./lab2-list --threads=2 --yield=d --iterations=16")
for i in `seq 1 10`; do
    ./lab2-list --threads=2 --yield=d --iterations=16 >> lab2_list.csv || true
done

echo "./lab2-list --threads=2 --yield=d --iterations=32"
(>&2 echo "./lab2-list --threads=2 --yield=d --iterations=32")
for i in `seq 1 10`; do
    ./lab2-list --threads=2 --yield=d --iterations=32 >> lab2_list.csv || true
done

echo "./lab2-list --threads=2 --yield=il --iterations=2"
(>&2 echo "./lab2-list --threads=2 --yield=il --iterations=2")
for i in `seq 1 10`; do
    ./lab2-list --threads=2 --yield=il --iterations=2 >> lab2_list.csv || true
done

echo "./lab2-list --threads=2 --yield=il --iterations=4"
(>&2 echo "./lab2-list --threads=2 --yield=il --iterations=4")
for i in `seq 1 10`; do
    ./lab2-list --threads=2 --yield=il --iterations=4 >> lab2_list.csv || true
done

echo "./lab2-list --threads=2 --yield=il --iterations=8"
(>&2 echo "./lab2-list --threads=2 --yield=il --iterations=8")
for i in `seq 1 10`; do
    ./lab2-list --threads=2 --yield=il --iterations=8 >> lab2_list.csv || true
done

echo "./lab2-list --threads=2 --yield=il --iterations=16"
(>&2 echo "./lab2-list --threads=2 --yield=il --iterations=16")
for i in `seq 1 10`; do
    ./lab2-list --threads=2 --yield=il --iterations=16 >> lab2_list.csv || true
done

echo "./lab2-list --threads=2 --yield=il --iterations=32"
(>&2 echo "./lab2-list --threads=2 --yield=il --iterations=32")
for i in `seq 1 10`; do
    ./lab2-list --threads=2 --yield=il --iterations=32 >> lab2_list.csv || true
done

echo "./lab2-list --threads=2 --yield=dl --iterations=2"
(>&2 echo "./lab2-list --threads=2 --yield=dl --iterations=2")
for i in `seq 1 10`; do
    ./lab2-list --threads=2 --yield=dl --iterations=2 >> lab2_list.csv || true
done

echo "./lab2-list --threads=2 --yield=dl --iterations=4"
(>&2 echo "./lab2-list --threads=2 --yield=dl --iterations=4")
for i in `seq 1 10`; do
    ./lab2-list --threads=2 --yield=dl --iterations=4 >> lab2_list.csv || true
done

echo "./lab2-list --threads=2 --yield=dl --iterations=8"
(>&2 echo "./lab2-list --threads=2 --yield=dl --iterations=8")
for i in `seq 1 10`; do
    ./lab2-list --threads=2 --yield=dl --iterations=8 >> lab2_list.csv || true
done

echo "./lab2-list --threads=2 --yield=dl --iterations=16"
(>&2 echo "./lab2-list --threads=2 --yield=dl --iterations=16")
for i in `seq 1 10`; do
    ./lab2-list --threads=2 --yield=dl --iterations=16 >> lab2_list.csv || true
done

echo "./lab2-list --threads=2 --yield=dl --iterations=32"
(>&2 echo "./lab2-list --threads=2 --yield=dl --iterations=32")
for i in `seq 1 10`; do
    ./lab2-list --threads=2 --yield=dl --iterations=32 >> lab2_list.csv || true
done

echo "./lab2-list --threads=2 --yield=i --iterations=2"
(>&2 echo "./lab2-list --threads=2 --yield=i --iterations=2")
for i in `seq 1 10`; do
    ./lab2-list --threads=2 --yield=i --iterations=2 >> lab2_list.csv || true
done
### threads = 4
echo "./lab2-list --threads=4 --yield=i --iterations=4"
(>&2 echo "./lab2-list --threads=4 --yield=i --iterations=4")
for i in `seq 1 10`; do
    ./lab2-list --threads=4 --yield=i --iterations=4 >> lab2_list.csv || true
done

echo "./lab2-list --threads=4 --yield=i --iterations=8"
(>&2 echo "./lab2-list --threads=4 --yield=i --iterations=8")
for i in `seq 1 10`; do
    ./lab2-list --threads=4 --yield=i --iterations=8 >> lab2_list.csv || true
done

echo "./lab2-list --threads=4 --yield=i --iterations=16"
(>&2 echo "./lab2-list --threads=4 --yield=i --iterations=16")
for i in `seq 1 10`; do
    ./lab2-list --threads=4 --yield=i --iterations=16 >> lab2_list.csv || true
done

echo "./lab2-list --threads=4 --yield=i --iterations=32"
(>&2 echo "./lab2-list --threads=4 --yield=i --iterations=32")
for i in `seq 1 10`; do
    ./lab2-list --threads=4 --yield=i --iterations=32 >> lab2_list.csv || true
done

echo "./lab2-list --threads=4 --yield=d --iterations=2"
(>&2 echo "./lab2-list --threads=4 --yield=d --iterations=2")
for i in `seq 1 10`; do
    ./lab2-list --threads=4 --yield=d --iterations=2 >> lab2_list.csv || true
done

echo "./lab2-list --threads=4 --yield=d --iterations=4"
(>&2 echo "./lab2-list --threads=4 --yield=d --iterations=4")
for i in `seq 1 10`; do
    ./lab2-list --threads=4 --yield=d --iterations=4 >> lab2_list.csv || true
done

echo "./lab2-list --threads=4 --yield=d --iterations=8"
(>&2 echo "./lab2-list --threads=4 --yield=d --iterations=8")
for i in `seq 1 10`; do
    ./lab2-list --threads=4 --yield=d --iterations=8 >> lab2_list.csv || true
done

echo "./lab2-list --threads=4 --yield=d --iterations=16"
(>&2 echo "./lab2-list --threads=4 --yield=d --iterations=16")
for i in `seq 1 10`; do
    ./lab2-list --threads=4 --yield=d --iterations=16 >> lab2_list.csv || true
done

echo "./lab2-list --threads=4 --yield=d --iterations=32"
(>&2 echo "./lab2-list --threads=4 --yield=d --iterations=32")
for i in `seq 1 10`; do
    ./lab2-list --threads=4 --yield=d --iterations=32 >> lab2_list.csv || true
done

echo "./lab2-list --threads=4 --yield=il --iterations=2"
(>&2 echo "./lab2-list --threads=4 --yield=il --iterations=2")
for i in `seq 1 10`; do
    ./lab2-list --threads=4 --yield=il --iterations=2 >> lab2_list.csv || true
done

echo "./lab2-list --threads=4 --yield=il --iterations=4"
(>&2 echo "./lab2-list --threads=4 --yield=il --iterations=4")
for i in `seq 1 10`; do
    ./lab2-list --threads=4 --yield=il --iterations=4 >> lab2_list.csv || true
done

echo "./lab2-list --threads=4 --yield=il --iterations=8"
(>&2 echo "./lab2-list --threads=4 --yield=il --iterations=8")
for i in `seq 1 10`; do
    ./lab2-list --threads=4 --yield=il --iterations=8 >> lab2_list.csv || true
done

echo "./lab2-list --threads=4 --yield=il --iterations=16"
(>&2 echo "./lab2-list --threads=4 --yield=il --iterations=16")
for i in `seq 1 10`; do
    ./lab2-list --threads=4 --yield=il --iterations=16 >> lab2_list.csv || true
done

echo "./lab2-list --threads=4 --yield=il --iterations=32"
(>&2 echo "./lab2-list --threads=4 --yield=il --iterations=32")
for i in `seq 1 10`; do
    ./lab2-list --threads=4 --yield=il --iterations=32 >> lab2_list.csv || true
done

echo "./lab2-list --threads=4 --yield=dl --iterations=2"
(>&2 echo "./lab2-list --threads=4 --yield=dl --iterations=2")
for i in `seq 1 10`; do
    ./lab2-list --threads=4 --yield=dl --iterations=2 >> lab2_list.csv || true
done

echo "./lab2-list --threads=4 --yield=dl --iterations=4"
(>&2 echo "./lab2-list --threads=4 --yield=dl --iterations=4")
for i in `seq 1 10`; do
    ./lab2-list --threads=4 --yield=dl --iterations=4 >> lab2_list.csv || true
done

echo "./lab2-list --threads=4 --yield=dl --iterations=8"
(>&2 echo "./lab2-list --threads=4 --yield=dl --iterations=8")
for i in `seq 1 10`; do
    ./lab2-list --threads=4 --yield=dl --iterations=8 >> lab2_list.csv || true
done

echo "./lab2-list --threads=4 --yield=dl --iterations=16"
(>&2 echo "./lab2-list --threads=4 --yield=dl --iterations=16")
for i in `seq 1 10`; do
    ./lab2-list --threads=4 --yield=dl --iterations=16 >> lab2_list.csv || true
done

echo "./lab2-list --threads=4 --yield=dl --iterations=32"
(>&2 echo "./lab2-list --threads=4 --yield=dl --iterations=32")
for i in `seq 1 10`; do
    ./lab2-list --threads=4 --yield=dl --iterations=32 >> lab2_list.csv || true
done

### threads = 8
echo "./lab2-list --threads=8 --yield=i --iterations=4"
(>&2 echo "./lab2-list --threads=8 --yield=i --iterations=4")
for i in `seq 1 10`; do
    ./lab2-list --threads=8 --yield=i --iterations=4 >> lab2_list.csv || true
done

echo "./lab2-list --threads=8 --yield=i --iterations=8"
(>&2 echo "./lab2-list --threads=8 --yield=i --iterations=8")
for i in `seq 1 10`; do
    ./lab2-list --threads=8 --yield=i --iterations=8 >> lab2_list.csv || true
done

echo "./lab2-list --threads=8 --yield=i --iterations=16"
(>&2 echo "./lab2-list --threads=8 --yield=i --iterations=16")
for i in `seq 1 10`; do
    ./lab2-list --threads=8 --yield=i --iterations=16 >> lab2_list.csv || true
done

echo "./lab2-list --threads=8 --yield=i --iterations=32"
(>&2 echo "./lab2-list --threads=8 --yield=i --iterations=32")
for i in `seq 1 10`; do
    ./lab2-list --threads=8 --yield=i --iterations=32 >> lab2_list.csv || true
done

echo "./lab2-list --threads=8 --yield=d --iterations=2"
(>&2 echo "./lab2-list --threads=8 --yield=d --iterations=2")
for i in `seq 1 10`; do
    ./lab2-list --threads=8 --yield=d --iterations=2 >> lab2_list.csv || true
done

echo "./lab2-list --threads=8 --yield=d --iterations=4"
(>&2 echo "./lab2-list --threads=8 --yield=d --iterations=4")
for i in `seq 1 10`; do
    ./lab2-list --threads=8 --yield=d --iterations=4 >> lab2_list.csv || true
done

echo "./lab2-list --threads=8 --yield=d --iterations=8"
(>&2 echo "./lab2-list --threads=8 --yield=d --iterations=8")
for i in `seq 1 10`; do
    ./lab2-list --threads=8 --yield=d --iterations=8 >> lab2_list.csv || true
done

echo "./lab2-list --threads=8 --yield=d --iterations=16"
(>&2 echo "./lab2-list --threads=8 --yield=d --iterations=16")
for i in `seq 1 10`; do
    ./lab2-list --threads=8 --yield=d --iterations=16 >> lab2_list.csv || true
done

echo "./lab2-list --threads=8 --yield=d --iterations=32"
(>&2 echo "./lab2-list --threads=8 --yield=d --iterations=32")
for i in `seq 1 10`; do
    ./lab2-list --threads=8 --yield=d --iterations=32 >> lab2_list.csv || true
done

echo "./lab2-list --threads=8 --yield=il --iterations=2"
(>&2 echo "./lab2-list --threads=8 --yield=il --iterations=2")
for i in `seq 1 10`; do
    ./lab2-list --threads=8 --yield=il --iterations=2 >> lab2_list.csv || true
done

echo "./lab2-list --threads=8 --yield=il --iterations=4"
(>&2 echo "./lab2-list --threads=8 --yield=il --iterations=4")
for i in `seq 1 10`; do
    ./lab2-list --threads=8 --yield=il --iterations=4 >> lab2_list.csv || true
done

echo "./lab2-list --threads=8 --yield=il --iterations=8"
(>&2 echo "./lab2-list --threads=8 --yield=il --iterations=8")
for i in `seq 1 10`; do
    ./lab2-list --threads=8 --yield=il --iterations=8 >> lab2_list.csv || true
done

echo "./lab2-list --threads=8 --yield=il --iterations=16"
(>&2 echo "./lab2-list --threads=8 --yield=il --iterations=16")
for i in `seq 1 10`; do
    ./lab2-list --threads=8 --yield=il --iterations=16 >> lab2_list.csv || true
done

echo "./lab2-list --threads=8 --yield=il --iterations=32"
(>&2 echo "./lab2-list --threads=8 --yield=il --iterations=32")
for i in `seq 1 10`; do
    ./lab2-list --threads=8 --yield=il --iterations=32 >> lab2_list.csv || true
done

echo "./lab2-list --threads=8 --yield=dl --iterations=2"
(>&2 echo "./lab2-list --threads=8 --yield=dl --iterations=2")
for i in `seq 1 10`; do
    ./lab2-list --threads=8 --yield=dl --iterations=2 >> lab2_list.csv || true
done

echo "./lab2-list --threads=8 --yield=dl --iterations=4"
(>&2 echo "./lab2-list --threads=8 --yield=dl --iterations=4")
for i in `seq 1 10`; do
    ./lab2-list --threads=8 --yield=dl --iterations=4 >> lab2_list.csv || true
done

echo "./lab2-list --threads=8 --yield=dl --iterations=8"
(>&2 echo "./lab2-list --threads=8 --yield=dl --iterations=8")
for i in `seq 1 10`; do
    ./lab2-list --threads=8 --yield=dl --iterations=8 >> lab2_list.csv || true
done

echo "./lab2-list --threads=8 --yield=dl --iterations=16"
(>&2 echo "./lab2-list --threads=8 --yield=dl --iterations=16")
for i in `seq 1 10`; do
    ./lab2-list --threads=8 --yield=dl --iterations=16 >> lab2_list.csv || true
done

echo "./lab2-list --threads=8 --yield=dl --iterations=32"
(>&2 echo "./lab2-list --threads=8 --yield=dl --iterations=32")
for i in `seq 1 10`; do
    ./lab2-list --threads=8 --yield=dl --iterations=32 >> lab2_list.csv || true
done

### threads = 12

echo "./lab2-list --threads=12 --yield=i --iterations=4"
(>&2 echo "./lab2-list --threads=12 --yield=i --iterations=4")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --yield=i --iterations=4 >> lab2_list.csv || true
done

echo "./lab2-list --threads=12 --yield=i --iterations=8"
(>&2 echo "./lab2-list --threads=12 --yield=i --iterations=8")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --yield=i --iterations=8 >> lab2_list.csv || true
done

echo "./lab2-list --threads=12 --yield=i --iterations=16"
(>&2 echo "./lab2-list --threads=12 --yield=i --iterations=16")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --yield=i --iterations=16 >> lab2_list.csv || true
done

echo "./lab2-list --threads=12 --yield=i --iterations=32"
(>&2 echo "./lab2-list --threads=12 --yield=i --iterations=32")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --yield=i --iterations=32 >> lab2_list.csv || true
done

echo "./lab2-list --threads=12 --yield=d --iterations=2"
(>&2 echo "./lab2-list --threads=12 --yield=d --iterations=2")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --yield=d --iterations=2 >> lab2_list.csv || true
done

echo "./lab2-list --threads=12 --yield=d --iterations=4"
(>&2 echo "./lab2-list --threads=12 --yield=d --iterations=4")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --yield=d --iterations=4 >> lab2_list.csv || true
done

echo "./lab2-list --threads=12 --yield=d --iterations=8"
(>&2 echo "./lab2-list --threads=12 --yield=d --iterations=8")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --yield=d --iterations=8 >> lab2_list.csv || true
done

echo "./lab2-list --threads=12 --yield=d --iterations=16"
(>&2 echo "./lab2-list --threads=12 --yield=d --iterations=16")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --yield=d --iterations=16 >> lab2_list.csv || true
done

echo "./lab2-list --threads=12 --yield=d --iterations=32"
(>&2 echo "./lab2-list --threads=12 --yield=d --iterations=32")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --yield=d --iterations=32 >> lab2_list.csv || true
done

echo "./lab2-list --threads=12 --yield=il --iterations=2"
(>&2 echo "./lab2-list --threads=12 --yield=il --iterations=2")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --yield=il --iterations=2 >> lab2_list.csv || true
done

echo "./lab2-list --threads=12 --yield=il --iterations=4"
(>&2 echo "./lab2-list --threads=12 --yield=il --iterations=4")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --yield=il --iterations=4 >> lab2_list.csv || true
done

echo "./lab2-list --threads=12 --yield=il --iterations=8"
(>&2 echo "./lab2-list --threads=12 --yield=il --iterations=8")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --yield=il --iterations=8 >> lab2_list.csv || true
done

echo "./lab2-list --threads=12 --yield=il --iterations=16"
(>&2 echo "./lab2-list --threads=12 --yield=il --iterations=16")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --yield=il --iterations=16 >> lab2_list.csv || true
done

echo "./lab2-list --threads=12 --yield=il --iterations=32"
(>&2 echo "./lab2-list --threads=12 --yield=il --iterations=32")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --yield=il --iterations=32 >> lab2_list.csv || true
done

echo "./lab2-list --threads=12 --yield=dl --iterations=2"
(>&2 echo "./lab2-list --threads=12 --yield=dl --iterations=2")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --yield=dl --iterations=2 >> lab2_list.csv || true
done

echo "./lab2-list --threads=12 --yield=dl --iterations=4"
(>&2 echo "./lab2-list --threads=12 --yield=dl --iterations=4")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --yield=dl --iterations=4 >> lab2_list.csv || true
done

echo "./lab2-list --threads=12 --yield=dl --iterations=8"
(>&2 echo "./lab2-list --threads=12 --yield=dl --iterations=8")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --yield=dl --iterations=8 >> lab2_list.csv || true
done

echo "./lab2-list --threads=12 --yield=dl --iterations=16"
(>&2 echo "./lab2-list --threads=12 --yield=dl --iterations=16")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --yield=dl --iterations=16 >> lab2_list.csv || true
done

echo "./lab2-list --threads=12 --yield=dl --iterations=32"
(>&2 echo "./lab2-list --threads=12 --yield=dl --iterations=32")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --yield=dl --iterations=32 >> lab2_list.csv || true
done

########## yield with protechtion ##########
### sync = m
echo "./lab2-list --threads=12 --sync=m --yield=i --iterations=32"
(>&2 echo "./lab2-list --threads=12 --sync=m --yield=i --iterations=32")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --sync=m --yield=i --iterations=32 >> lab2_list.csv || true
done

echo "./lab2-list --threads=12 --sync=m --yield=d --iterations=32"
(>&2 echo "./lab2-list --threads=12 --sync=m --yield=d --iterations=32")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --sync=m --yield=d --iterations=32 >> lab2_list.csv || true
done

echo "./lab2-list --threads=12 --sync=m --yield=il --iterations=32"
(>&2 echo "./lab2-list --threads=12 --sync=m --yield=il --iterations=32")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --sync=m --yield=il --iterations=32 >> lab2_list.csv || true
done

echo "./lab2-list --threads=12 --sync=m --yield=dl --iterations=32"
(>&2 echo "./lab2-list --threads=12 --sync=m --yield=dl --iterations=32")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --sync=m --yield=dl --iterations=32 >> lab2_list.csv || true
done

### sync = s
echo "./lab2-list --threads=12 --sync=m --yield=i --iterations=32"
(>&2 echo "./lab2-list --threads=12 --sync=m --yield=i --iterations=32")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --sync=s --yield=i --iterations=32 >> lab2_list.csv || true
done

echo "./lab2-list --threads=12 --sync=s --yield=d --iterations=32"
(>&2 echo "./lab2-list --threads=12 --sync=s --yield=d --iterations=32")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --sync=s --yield=d --iterations=32 >> lab2_list.csv || true
done

echo "./lab2-list --threads=12 --sync=s --yield=il --iterations=32"
(>&2 echo "./lab2-list --threads=12 --sync=s --yield=il --iterations=32")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --sync=s --yield=il --iterations=32 >> lab2_list.csv || true
done

echo "./lab2-list --threads=12 --sync=s --yield=dl --iterations=32"
(>&2 echo "./lab2-list --threads=12 --sync=s --yield=dl --iterations=32")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --sync=s --yield=dl --iterations=32 >> lab2_list.csv || true
done

########## protected without yield ##########

echo "./lab2-list --threads=1 --iterations=1000"
(>&2 echo "./lab2-list --threads=1 --iterations=1000")
for i in `seq 1 10`; do
    ./lab2-list --threads=1 --iterations=1000 >> lab2_list.csv || true
done

echo "./lab2-list --threads=1 --sync=m --iterations=1000"
(>&2 echo "./lab2-list --threads=1 --sync=m --iterations=1000")
for i in `seq 1 10`; do
    ./lab2-list --threads=1 --sync=m --iterations=1000 >> lab2_list.csv || true
done

echo "./lab2-list --threads=1 --sync=s --iterations=1000"
(>&2 echo "./lab2-list --threads=1 --sync=s --iterations=1000")
for i in `seq 1 10`; do
    ./lab2-list --threads=1 --sync=s --iterations=1000 >> lab2_list.csv || true
done

echo "./lab2-list --threads=2 --sync=m --iterations=1000"
(>&2 echo "./lab2-list --threads=2 --sync=m --iterations=1000")
for i in `seq 1 10`; do
    ./lab2-list --threads=2 --sync=m --iterations=1000 >> lab2_list.csv || true
done

echo "./lab2-list --threads=2 --sync=s --iterations=1000"
(>&2 echo "./lab2-list --threads=2 --sync=s --iterations=1000")
for i in `seq 1 10`; do
    ./lab2-list --threads=2 --sync=s --iterations=1000 >> lab2_list.csv || true
done

echo "./lab2-list --threads=4 --sync=m --iterations=1000"
(>&2 echo "./lab2-list --threads=4 --sync=m --iterations=1000")
for i in `seq 1 10`; do
    ./lab2-list --threads=4 --sync=m --iterations=1000 >> lab2_list.csv || true
done

echo "./lab2-list --threads=4 --sync=s --iterations=1000"
(>&2 echo "./lab2-list --threads=4 --sync=s --iterations=1000")
for i in `seq 1 10`; do
    ./lab2-list --threads=4 --sync=s --iterations=1000 >> lab2_list.csv || true
done

echo "./lab2-list --threads=8 --sync=m --iterations=1000"
(>&2 echo "./lab2-list --threads=8 --sync=m --iterations=1000")
for i in `seq 1 10`; do
    ./lab2-list --threads=8 --sync=m --iterations=1000 >> lab2_list.csv || true
done

echo "./lab2-list --threads=8 --sync=s --iterations=1000"
(>&2 echo "./lab2-list --threads=8 --sync=s --iterations=1000")
for i in `seq 1 10`; do
    ./lab2-list --threads=8 --sync=s --iterations=1000 >> lab2_list.csv || true
done

echo "./lab2-list --threads=12 --sync=m --iterations=1000"
(>&2 echo "./lab2-list --threads=12 --sync=m --iterations=1000")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --sync=m --iterations=1000 >> lab2_list.csv || true
done

echo "./lab2-list --threads=12 --sync=s --iterations=1000"
(>&2 echo "./lab2-list --threads=12 --sync=s --iterations=1000")
for i in `seq 1 10`; do
    ./lab2-list --threads=12 --sync=s --iterations=1000 >> lab2_list.csv || true
done

echo "./lab2-list --threads=16 --sync=m --iterations=1000"
(>&2 echo "./lab2-list --threads=16 --sync=m --iterations=1000")
for i in `seq 1 10`; do
    ./lab2-list --threads=16 --sync=m --iterations=1000 >> lab2_list.csv || true
done

echo "./lab2-list --threads=16 --sync=s --iterations=1000"
(>&2 echo "./lab2-list --threads=16 --sync=s --iterations=1000")
for i in `seq 1 10`; do
    ./lab2-list --threads=16 --sync=s --iterations=1000 >> lab2_list.csv || true
done

echo "./lab2-list --threads=24 --sync=m --iterations=1000"
(>&2 echo "./lab2-list --threads=24 --sync=m --iterations=1000")
for i in `seq 1 10`; do
    ./lab2-list --threads=24 --sync=m --iterations=1000 >> lab2_list.csv || true
done

echo "./lab2-list --threads=24 --sync=s --iterations=1000"
(>&2 echo "./lab2-list --threads=24 --sync=s --iterations=1000")
for i in `seq 1 10`; do
    ./lab2-list --threads=24 --sync=s --iterations=1000 >> lab2_list.csv || true
done