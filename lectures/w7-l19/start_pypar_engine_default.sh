#! /bin/bash

num_procs=$1

ipcluster start -n $num_procs --profile=default &
