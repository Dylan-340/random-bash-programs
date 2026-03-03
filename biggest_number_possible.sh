#!/bin/bash

for i in $(seq 1 100); do

 echo $i
 sleep 0.3
 if [ $i -eq 100 ]; then

  echo "this is the biggest number ever"
 
 fi

done 
