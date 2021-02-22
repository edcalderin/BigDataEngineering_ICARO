#!/bin/bash

string_a="LINUX"
string_b="GENIAL"

echo "Son $string_a y $string_b del mismo tipo?"
[ $string_a = $string_b ]
echo $?

num_a=100
num_b=100
echo ""
echo "---------------------"
echo ""
echo "Es $num_a igual a $num_b?"

[ $num_a -eq $num_b ]
echo $?
