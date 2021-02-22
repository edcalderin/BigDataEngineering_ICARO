#!/bin/bash

echo "Bucle For"

for i in 1 2 3; do
  echo $i
done

echo "--------------------"
echo "Bucle While (1)"
counter=0

while [ $counter -lt 3 ]; do
  let counter+=1
  echo $counter
done

echo "--------------------"
echo "Bucle While (2)"
counter=3

while [ $counter -gt 0 ]; do
  let counter-=1
  echo $counter
done
