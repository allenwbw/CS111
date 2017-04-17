#!/bin/bash
echo "./lab2-list --threads=1 --iterations=1000 --sync=m"
(>&2 echo "./lab2-list --threads=1 --iterations=1000 --sync=m")
    ./lab2-list --threads=1 --iterations=1000 --sync=m >> lab_2b_list.csv || true


echo "./lab2-list --threads=2 --iterations=1000 --sync=m"
(>&2 echo "./lab2-list --threads=2 --iterations=1000 --sync=m")

    ./lab2-list --threads=2 --iterations=1000 --sync=m >> lab_2b_list.csv || true


echo "./lab2-list --threads=4 --iterations=1000 --sync=m"
(>&2 echo "./lab2-list --threads=4 --iterations=1000 --sync=m")

    ./lab2-list --threads=4 --iterations=1000 --sync=m >> lab_2b_list.csv || true


echo "./lab2-list --threads=8 --iterations=1000 --sync=m"
(>&2 echo "./lab2-list --threads=8 --iterations=1000 --sync=m")

    ./lab2-list --threads=8 --iterations=1000 --sync=m >> lab_2b_list.csv || true


echo "./lab2-list --threads=12 --iterations=1000 --sync=m"
(>&2 echo "./lab2-list --threads=12 --iterations=1000 --sync=m")

    ./lab2-list --threads=12 --iterations=1000 --sync=m >> lab_2b_list.csv || true


echo "./lab2-list --threads=16 --iterations=1000 --sync=m"
(>&2 echo "./lab2-list --threads=16 --iterations=1000 --sync=m")

    ./lab2-list --threads=16 --iterations=1000 --sync=m >> lab_2b_list.csv || true


echo "./lab2-list --threads=24 --iterations=1000 --sync=m"
(>&2 echo "./lab2-list --threads=24 --iterations=1000 --sync=m")

    ./lab2-list --threads=24 --iterations=1000 --sync=m >> lab_2b_list.csv || true





echo "./lab2_list --lists=4 --threads=1 --iterations=1 --yield=id"
(>&2 echo "./lab2_list --lists=4 --threads=1 --iterations=1 --yield=id")
    ./lab2_list --lists=4 --threads=1 --iterations=1 --yield=id >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=1 --iterations=2 --yield=id"
(>&2 echo "./lab2_list --lists=4 --threads=1 --iterations=2 --yield=id")
    ./lab2_list --lists=4 --threads=1 --iterations=2 --yield=id >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=1 --iterations=4 --yield=id"
(>&2 echo "./lab2_list --lists=4 --threads=1 --iterations=4 --yield=id")
    ./lab2_list --lists=4 --threads=1 --iterations=4 --yield=id >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=1 --iterations=8 --yield=id"
(>&2 echo "./lab2_list --lists=4 --threads=1 --iterations=8 --yield=id")
    ./lab2_list --lists=4 --threads=1 --iterations=8 --yield=id >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=1 --iterations=16 --yield=id"
(>&2 echo "./lab2_list --lists=4 --threads=1 --iterations=16 --yield=id")
    ./lab2_list --lists=4 --threads=1 --iterations=16 --yield=id >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=4 --iterations=1 --yield=id"
(>&2 echo "./lab2_list --lists=4 --threads=4 --iterations=1 --yield=id")
    ./lab2_list --lists=4 --threads=4 --iterations=1 --yield=id >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=4 --iterations=2 --yield=id"
(>&2 echo "./lab2_list --lists=4 --threads=4 --iterations=2 --yield=id")
    ./lab2_list --lists=4 --threads=4 --iterations=2 --yield=id >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=4 --iterations=4 --yield=id"
(>&2 echo "./lab2_list --lists=4 --threads=4 --iterations=4 --yield=id")
    ./lab2_list --lists=4 --threads=4 --iterations=4 --yield=id >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=4 --iterations=8 --yield=id"
(>&2 echo "./lab2_list --lists=4 --threads=4 --iterations=8 --yield=id")
    ./lab2_list --lists=4 --threads=4 --iterations=8 --yield=id >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=4 --iterations=16 --yield=id"
(>&2 echo "./lab2_list --lists=4 --threads=4 --iterations=16 --yield=id")
    ./lab2_list --lists=4 --threads=4 --iterations=16 --yield=id >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=8 --iterations=1 --yield=id"
(>&2 echo "./lab2_list --lists=4 --threads=8 --iterations=1 --yield=id")
    ./lab2_list --lists=4 --threads=8 --iterations=1 --yield=id >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=8 --iterations=2 --yield=id"
(>&2 echo "./lab2_list --lists=4 --threads=8 --iterations=2 --yield=id")
    ./lab2_list --lists=4 --threads=8 --iterations=2 --yield=id >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=8 --iterations=4 --yield=id"
(>&2 echo "./lab2_list --lists=4 --threads=8 --iterations=4 --yield=id")
    ./lab2_list --lists=4 --threads=8 --iterations=4 --yield=id >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=8 --iterations=8 --yield=id"
(>&2 echo "./lab2_list --lists=4 --threads=8 --iterations=8 --yield=id")
    ./lab2_list --lists=4 --threads=8 --iterations=8 --yield=id >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=8 --iterations=16 --yield=id"
(>&2 echo "./lab2_list --lists=4 --threads=8 --iterations=16 --yield=id")
    ./lab2_list --lists=4 --threads=8 --iterations=16 --yield=id >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=12 --iterations=1 --yield=id"
(>&2 echo "./lab2_list --lists=4 --threads=12 --iterations=1 --yield=id")
    ./lab2_list --lists=4 --threads=12 --iterations=1 --yield=id >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=12 --iterations=2 --yield=id"
(>&2 echo "./lab2_list --lists=4 --threads=12 --iterations=2 --yield=id")
    ./lab2_list --lists=4 --threads=12 --iterations=2 --yield=id >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=12 --iterations=4 --yield=id"
(>&2 echo "./lab2_list --lists=4 --threads=12 --iterations=4 --yield=id")
    ./lab2_list --lists=4 --threads=12 --iterations=4 --yield=id >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=12 --iterations=8 --yield=id"
(>&2 echo "./lab2_list --lists=4 --threads=12 --iterations=8 --yield=id")
    ./lab2_list --lists=4 --threads=12 --iterations=8 --yield=id >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=12 --iterations=16 --yield=id"
(>&2 echo "./lab2_list --lists=4 --threads=12 --iterations=16 --yield=id")
    ./lab2_list --lists=4 --threads=12 --iterations=16 --yield=id >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=16 --iterations=1 --yield=id"
(>&2 echo "./lab2_list --lists=4 --threads=16 --iterations=1 --yield=id")
    ./lab2_list --lists=4 --threads=16 --iterations=1 --yield=id >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=16 --iterations=2 --yield=id"
(>&2 echo "./lab2_list --lists=4 --threads=16 --iterations=2 --yield=id")
    ./lab2_list --lists=4 --threads=16 --iterations=2 --yield=id >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=16 --iterations=4 --yield=id"
(>&2 echo "./lab2_list --lists=4 --threads=16 --iterations=4 --yield=id")
    ./lab2_list --lists=4 --threads=16 --iterations=4 --yield=id >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=16 --iterations=8 --yield=id"
(>&2 echo "./lab2_list --lists=4 --threads=16 --iterations=8 --yield=id")
    ./lab2_list --lists=4 --threads=16 --iterations=8 --yield=id >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=16 --iterations=16 --yield=id"
(>&2 echo "./lab2_list --lists=4 --threads=16 --iterations=16 --yield=id")
    ./lab2_list --lists=4 --threads=16 --iterations=16 --yield=id >> lab_2b_list.csv || true

##############################################

echo "./lab2_list --lists=4 --threads=1 --iterations=10 --yield=id --sync=m"
(>&2 echo "./lab2_list --lists=4 --threads=1 --iterations=10 --yield=id --sync=m")
    ./lab2_list --lists=4 --threads=1 --iterations=10 --yield=id --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=1 --iterations=20 --yield=id --sync=m"
(>&2 echo "./lab2_list --lists=4 --threads=1 --iterations=20 --yield=id --sync=m")
    ./lab2_list --lists=4 --threads=1 --iterations=20 --yield=id --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=1 --iterations=40 --yield=id --sync=m"
(>&2 echo "./lab2_list --lists=4 --threads=1 --iterations=40 --yield=id --sync=m")
    ./lab2_list --lists=4 --threads=1 --iterations=40 --yield=id --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=1 --iterations=80 --yield=id --sync=m"
(>&2 echo "./lab2_list --lists=4 --threads=1 --iterations=80 --yield=id --sync=m")
    ./lab2_list --lists=4 --threads=1 --iterations=80 --yield=id --sync=m >> lab_2b_list.csv || true


echo "./lab2_list --lists=4 --threads=4 --iterations=10 --yield=id --sync=m"
(>&2 echo "./lab2_list --lists=4 --threads=4 --iterations=10 --yield=id --sync=m")
    ./lab2_list --lists=4 --threads=4 --iterations=10 --yield=id --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=4 --iterations=20 --yield=id --sync=m"
(>&2 echo "./lab2_list --lists=4 --threads=4 --iterations=20 --yield=id --sync=m")
    ./lab2_list --lists=4 --threads=4 --iterations=20 --yield=id --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=4 --iterations=40 --yield=id --sync=m"
(>&2 echo "./lab2_list --lists=4 --threads=4 --iterations=40 --yield=id --sync=m")
    ./lab2_list --lists=4 --threads=4 --iterations=40 --yield=id --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=4 --iterations=80 --yield=id --sync=m"
(>&2 echo "./lab2_list --lists=4 --threads=4 --iterations=80 --yield=id --sync=m")
    ./lab2_list --lists=4 --threads=4 --iterations=80 --yield=id --sync=m >> lab_2b_list.csv || true


echo "./lab2_list --lists=4 --threads=8 --iterations=10 --yield=id --sync=m"
(>&2 echo "./lab2_list --lists=4 --threads=8 --iterations=10 --yield=id --sync=m")
    ./lab2_list --lists=4 --threads=8 --iterations=10 --yield=id --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=8 --iterations=20 --yield=id --sync=m"
(>&2 echo "./lab2_list --lists=4 --threads=8 --iterations=20 --yield=id --sync=m")
    ./lab2_list --lists=4 --threads=8 --iterations=20 --yield=id --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=8 --iterations=40 --yield=id --sync=m"
(>&2 echo "./lab2_list --lists=4 --threads=8 --iterations=40 --yield=id --sync=m")
    ./lab2_list --lists=4 --threads=8 --iterations=40 --yield=id --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=8 --iterations=80 --yield=id --sync=m"
(>&2 echo "./lab2_list --lists=4 --threads=8 --iterations=80 --yield=id --sync=m")
    ./lab2_list --lists=4 --threads=8 --iterations=80 --yield=id --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=12 --iterations=10 --yield=id --sync=m"
(>&2 echo "./lab2_list --lists=4 --threads=12 --iterations=10 --yield=id --sync=m")
    ./lab2_list --lists=4 --threads=12 --iterations=10 --yield=id --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=12 --iterations=20 --yield=id --sync=m"
(>&2 echo "./lab2_list --lists=4 --threads=12 --iterations=20 --yield=id --sync=m")
    ./lab2_list --lists=4 --threads=12 --iterations=20 --yield=id --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=12 --iterations=40 --yield=id --sync=m"
(>&2 echo "./lab2_list --lists=4 --threads=12 --iterations=40 --yield=id --sync=m")
    ./lab2_list --lists=4 --threads=12 --iterations=40 --yield=id --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=12 --iterations=80 --yield=id --sync=m"
(>&2 echo "./lab2_list --lists=4 --threads=12 --iterations=80 --yield=id --sync=m")
    ./lab2_list --lists=4 --threads=12 --iterations=80 --yield=id --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=16 --iterations=10 --yield=id --sync=m"
(>&2 echo "./lab2_list --lists=4 --threads=16 --iterations=10 --yield=id --sync=m")
    ./lab2_list --lists=4 --threads=16 --iterations=10 --yield=id --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=16 --iterations=20 --yield=id --sync=m"
(>&2 echo "./lab2_list --lists=4 --threads=16 --iterations=20 --yield=id --sync=m")
    ./lab2_list --lists=4 --threads=16 --iterations=20 --yield=id --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=16 --iterations=40 --yield=id --sync=m"
(>&2 echo "./lab2_list --lists=4 --threads=16 --iterations=40 --yield=id --sync=m")
    ./lab2_list --lists=4 --threads=16 --iterations=40 --yield=id --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=16 --iterations=80 --yield=id --sync=m"
(>&2 echo "./lab2_list --lists=4 --threads=16 --iterations=80 --yield=id --sync=m")
    ./lab2_list --lists=4 --threads=16 --iterations=80 --yield=id --sync=m >> lab_2b_list.csv || true

######################################

echo "./lab2_list --lists=4 --threads=1 --iterations=10 --yield=id --sync=s"
(>&2 echo "./lab2_list --lists=4 --threads=1 --iterations=10 --yield=id --sync=s")
    ./lab2_list --lists=4 --threads=1 --iterations=10 --yield=id --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=1 --iterations=20 --yield=id --sync=s"
(>&2 echo "./lab2_list --lists=4 --threads=1 --iterations=20 --yield=id --sync=s")
    ./lab2_list --lists=4 --threads=1 --iterations=20 --yield=id --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=1 --iterations=40 --yield=id --sync=s"
(>&2 echo "./lab2_list --lists=4 --threads=1 --iterations=40 --yield=id --sync=s")
    ./lab2_list --lists=4 --threads=1 --iterations=40 --yield=id --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=1 --iterations=80 --yield=id --sync=s"
(>&2 echo "./lab2_list --lists=4 --threads=1 --iterations=80 --yield=id --sync=s")
    ./lab2_list --lists=4 --threads=1 --iterations=80 --yield=id --sync=s >> lab_2b_list.csv || true


echo "./lab2_list --lists=4 --threads=4 --iterations=10 --yield=id --sync=s"
(>&2 echo "./lab2_list --lists=4 --threads=4 --iterations=10 --yield=id --sync=s")
    ./lab2_list --lists=4 --threads=4 --iterations=10 --yield=id --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=4 --iterations=20 --yield=id --sync=s"
(>&2 echo "./lab2_list --lists=4 --threads=4 --iterations=20 --yield=id --sync=s")
    ./lab2_list --lists=4 --threads=4 --iterations=20 --yield=id --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=4 --iterations=40 --yield=id --sync=s"
(>&2 echo "./lab2_list --lists=4 --threads=4 --iterations=40 --yield=id --sync=s")
    ./lab2_list --lists=4 --threads=4 --iterations=40 --yield=id --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=4 --iterations=80 --yield=id --sync=s"
(>&2 echo "./lab2_list --lists=4 --threads=4 --iterations=80 --yield=id --sync=s")
    ./lab2_list --lists=4 --threads=4 --iterations=80 --yield=id --sync=s >> lab_2b_list.csv || true


echo "./lab2_list --lists=4 --threads=8 --iterations=10 --yield=id --sync=s"
(>&2 echo "./lab2_list --lists=4 --threads=8 --iterations=10 --yield=id --sync=s")
    ./lab2_list --lists=4 --threads=8 --iterations=10 --yield=id --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=8 --iterations=20 --yield=id --sync=s"
(>&2 echo "./lab2_list --lists=4 --threads=8 --iterations=20 --yield=id --sync=s")
    ./lab2_list --lists=4 --threads=8 --iterations=20 --yield=id --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=8 --iterations=40 --yield=id --sync=s"
(>&2 echo "./lab2_list --lists=4 --threads=8 --iterations=40 --yield=id --sync=s")
    ./lab2_list --lists=4 --threads=8 --iterations=40 --yield=id --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=8 --iterations=80 --yield=id --sync=s"
(>&2 echo "./lab2_list --lists=4 --threads=8 --iterations=80 --yield=id --sync=s")
    ./lab2_list --lists=4 --threads=8 --iterations=80 --yield=id --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=12 --iterations=10 --yield=id --sync=s"
(>&2 echo "./lab2_list --lists=4 --threads=12 --iterations=10 --yield=id --sync=s")
    ./lab2_list --lists=4 --threads=12 --iterations=10 --yield=id --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=12 --iterations=20 --yield=id --sync=s"
(>&2 echo "./lab2_list --lists=4 --threads=12 --iterations=20 --yield=id --sync=s")
    ./lab2_list --lists=4 --threads=12 --iterations=20 --yield=id --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=12 --iterations=40 --yield=id --sync=s"
(>&2 echo "./lab2_list --lists=4 --threads=12 --iterations=40 --yield=id --sync=s")
    ./lab2_list --lists=4 --threads=12 --iterations=40 --yield=id --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=12 --iterations=80 --yield=id --sync=s"
(>&2 echo "./lab2_list --lists=4 --threads=12 --iterations=80 --yield=id --sync=s")
    ./lab2_list --lists=4 --threads=12 --iterations=80 --yield=id --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=16 --iterations=10 --yield=id --sync=s"
(>&2 echo "./lab2_list --lists=4 --threads=16 --iterations=10 --yield=id --sync=s")
    ./lab2_list --lists=4 --threads=16 --iterations=10 --yield=id --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=16 --iterations=20 --yield=id --sync=s"
(>&2 echo "./lab2_list --lists=4 --threads=16 --iterations=20 --yield=id --sync=s")
    ./lab2_list --lists=4 --threads=16 --iterations=20 --yield=id --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=16 --iterations=40 --yield=id --sync=s"
(>&2 echo "./lab2_list --lists=4 --threads=16 --iterations=40 --yield=id --sync=s")
    ./lab2_list --lists=4 --threads=16 --iterations=40 --yield=id --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=16 --iterations=80 --yield=id --sync=s"
(>&2 echo "./lab2_list --lists=4 --threads=16 --iterations=80 --yield=id --sync=s")
    ./lab2_list --lists=4 --threads=16 --iterations=80 --yield=id --sync=s >> lab_2b_list.csv || true

##################################

echo "./lab2_list --lists=1 --threads=1 --iterations=1000 --sync=s"
(>&2 echo "./lab2_list --lists=1 --threads=1 --iterations=1000 --sync=s")
    ./lab2_list --lists=1 --threads=1 --iterations=1000 --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=1 --threads=2 --iterations=1000 --sync=s"
(>&2 echo "./lab2_list --lists=1 --threads=2 --iterations=1000 --sync=s")
    ./lab2_list --lists=1 --threads=2 --iterations=1000 --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=1 --threads=4 --iterations=1000 --sync=s"
(>&2 echo "./lab2_list --lists=1 --threads=4 --iterations=1000 --sync=s")
    ./lab2_list --lists=1 --threads=4 --iterations=1000 --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=1 --threads=8 --iterations=1000 --sync=s"
(>&2 echo "./lab2_list --lists=1 --threads=8 --iterations=1000 --sync=s")
    ./lab2_list --lists=1 --threads=8 --iterations=1000 --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=1 --threads=12 --iterations=1000 --sync=s"
(>&2 echo "./lab2_list --lists=1 --threads=12 --iterations=1000 --sync=s")
    ./lab2_list --lists=1 --threads=12 --iterations=1000 --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=1 --iterations=1000 --sync=s"
(>&2 echo "./lab2_list --lists=4 --threads=1 --iterations=1000 --sync=s")
    ./lab2_list --lists=4 --threads=1 --iterations=1000 --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=2 --iterations=1000 --sync=s"
(>&2 echo "./lab2_list --lists=4 --threads=2 --iterations=1000 --sync=s")
    ./lab2_list --lists=4 --threads=2 --iterations=1000 --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=4 --iterations=1000 --sync=s"
(>&2 echo "./lab2_list --lists=4 --threads=4 --iterations=1000 --sync=s")
    ./lab2_list --lists=4 --threads=4 --iterations=1000 --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=8 --iterations=1000 --sync=s"
(>&2 echo "./lab2_list --lists=4 --threads=8 --iterations=1000 --sync=s")
    ./lab2_list --lists=4 --threads=8 --iterations=1000 --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=12 --iterations=1000 --sync=s"
(>&2 echo "./lab2_list --lists=4 --threads=12 --iterations=1000 --sync=s")
    ./lab2_list --lists=4 --threads=12 --iterations=1000 --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=8 --threads=1 --iterations=1000 --sync=s"
(>&2 echo "./lab2_list --lists=8 --threads=1 --iterations=1000 --sync=s")
    ./lab2_list --lists=8 --threads=1 --iterations=1000 --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=8 --threads=2 --iterations=1000 --sync=s"
(>&2 echo "./lab2_list --lists=8 --threads=2 --iterations=1000 --sync=s")
    ./lab2_list --lists=8 --threads=2 --iterations=1000 --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=8 --threads=4 --iterations=1000 --sync=s"
(>&2 echo "./lab2_list --lists=8 --threads=4 --iterations=1000 --sync=s")
    ./lab2_list --lists=8 --threads=4 --iterations=1000 --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=8 --threads=8 --iterations=1000 --sync=s"
(>&2 echo "./lab2_list --lists=8 --threads=8 --iterations=1000 --sync=s")
    ./lab2_list --lists=8 --threads=8 --iterations=1000 --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=8 --threads=12 --iterations=1000 --sync=s"
(>&2 echo "./lab2_list --lists=8 --threads=12 --iterations=1000 --sync=s")
    ./lab2_list --lists=8 --threads=12 --iterations=1000 --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=16 --threads=1 --iterations=1000 --sync=s"
(>&2 echo "./lab2_list --lists=16 --threads=1 --iterations=1000 --sync=s")
    ./lab2_list --lists=16 --threads=1 --iterations=1000 --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=16 --threads=2 --iterations=1000 --sync=s"
(>&2 echo "./lab2_list --lists=16 --threads=2 --iterations=1000 --sync=s")
    ./lab2_list --lists=16 --threads=2 --iterations=1000 --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=16 --threads=4 --iterations=1000 --sync=s"
(>&2 echo "./lab2_list --lists=16 --threads=4 --iterations=1000 --sync=s")
    ./lab2_list --lists=16 --threads=4 --iterations=1000 --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=16 --threads=8 --iterations=1000 --sync=s"
(>&2 echo "./lab2_list --lists=16 --threads=8 --iterations=1000 --sync=s")
    ./lab2_list --lists=16 --threads=8 --iterations=1000 --sync=s >> lab_2b_list.csv || true

echo "./lab2_list --lists=16 --threads=12 --iterations=1000 --sync=s"
(>&2 echo "./lab2_list --lists=16 --threads=12 --iterations=1000 --sync=s")
    ./lab2_list --lists=16 --threads=12 --iterations=1000 --sync=s >> lab_2b_list.csv || true

#######################


echo "./lab2_list --lists=1 --threads=1 --iterations=1000 --sync=m"
(>&2 echo "./lab2_list --lists=1 --threads=1 --iterations=1000 --sync=m")
    ./lab2_list --lists=1 --threads=1 --iterations=1000 --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=1 --threads=2 --iterations=1000 --sync=m"
(>&2 echo "./lab2_list --lists=1 --threads=2 --iterations=1000 --sync=m")
    ./lab2_list --lists=1 --threads=2 --iterations=1000 --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=1 --threads=4 --iterations=1000 --sync=m"
(>&2 echo "./lab2_list --lists=1 --threads=4 --iterations=1000 --sync=m")
    ./lab2_list --lists=1 --threads=4 --iterations=1000 --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=1 --threads=8 --iterations=1000 --sync=m"
(>&2 echo "./lab2_list --lists=1 --threads=8 --iterations=1000 --sync=m")
    ./lab2_list --lists=1 --threads=8 --iterations=1000 --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=1 --threads=12 --iterations=1000 --sync=m"
(>&2 echo "./lab2_list --lists=1 --threads=12 --iterations=1000 --sync=m")
    ./lab2_list --lists=1 --threads=12 --iterations=1000 --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=1 --iterations=1000 --sync=m"
(>&2 echo "./lab2_list --lists=4 --threads=1 --iterations=1000 --sync=m")
    ./lab2_list --lists=4 --threads=1 --iterations=1000 --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=2 --iterations=1000 --sync=m"
(>&2 echo "./lab2_list --lists=4 --threads=2 --iterations=1000 --sync=m")
    ./lab2_list --lists=4 --threads=2 --iterations=1000 --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=4 --iterations=1000 --sync=m"
(>&2 echo "./lab2_list --lists=4 --threads=4 --iterations=1000 --sync=m")
    ./lab2_list --lists=4 --threads=4 --iterations=1000 --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=8 --iterations=1000 --sync=m"
(>&2 echo "./lab2_list --lists=4 --threads=8 --iterations=1000 --sync=m")
    ./lab2_list --lists=4 --threads=8 --iterations=1000 --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=4 --threads=12 --iterations=1000 --sync=m"
(>&2 echo "./lab2_list --lists=4 --threads=12 --iterations=1000 --sync=m")
    ./lab2_list --lists=4 --threads=12 --iterations=1000 --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=8 --threads=1 --iterations=1000 --sync=m"
(>&2 echo "./lab2_list --lists=8 --threads=1 --iterations=1000 --sync=m")
    ./lab2_list --lists=8 --threads=1 --iterations=1000 --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=8 --threads=2 --iterations=1000 --sync=m"
(>&2 echo "./lab2_list --lists=8 --threads=2 --iterations=1000 --sync=m")
    ./lab2_list --lists=8 --threads=2 --iterations=1000 --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=8 --threads=4 --iterations=1000 --sync=m"
(>&2 echo "./lab2_list --lists=8 --threads=4 --iterations=1000 --sync=m")
    ./lab2_list --lists=8 --threads=4 --iterations=1000 --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=8 --threads=8 --iterations=1000 --sync=m"
(>&2 echo "./lab2_list --lists=8 --threads=8 --iterations=1000 --sync=m")
    ./lab2_list --lists=8 --threads=8 --iterations=1000 --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=8 --threads=12 --iterations=1000 --sync=m"
(>&2 echo "./lab2_list --lists=8 --threads=12 --iterations=1000 --sync=m")
    ./lab2_list --lists=8 --threads=12 --iterations=1000 --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=16 --threads=1 --iterations=1000 --sync=m"
(>&2 echo "./lab2_list --lists=16 --threads=1 --iterations=1000 --sync=m")
    ./lab2_list --lists=16 --threads=1 --iterations=1000 --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=16 --threads=2 --iterations=1000 --sync=m"
(>&2 echo "./lab2_list --lists=16 --threads=2 --iterations=1000 --sync=m")
    ./lab2_list --lists=16 --threads=2 --iterations=1000 --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=16 --threads=4 --iterations=1000 --sync=m"
(>&2 echo "./lab2_list --lists=16 --threads=4 --iterations=1000 --sync=m")
    ./lab2_list --lists=16 --threads=4 --iterations=1000 --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=16 --threads=8 --iterations=1000 --sync=m"
(>&2 echo "./lab2_list --lists=16 --threads=8 --iterations=1000 --sync=m")
    ./lab2_list --lists=16 --threads=8 --iterations=1000 --sync=m >> lab_2b_list.csv || true

echo "./lab2_list --lists=16 --threads=12 --iterations=1000 --sync=m"
(>&2 echo "./lab2_list --lists=16 --threads=12 --iterations=1000 --sync=m")
    ./lab2_list --lists=16 --threads=12 --iterations=1000 --sync=m >> lab_2b_list.csv || true













