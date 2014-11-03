#!/bin/bash

mkdir -p $1
cd $1
rm -rf ./*
wget -q -nd -r ftp://amrc.ssec.wisc.edu/pub/requests/DVPC/AWS_q3h_MAY_2014/\*
cd ..

echo "["
find $1 -exec awk '
{
	if (NR==1) 
		printf "\t{\"name\":\"" $10 "\", "; 
	if (NR==2) 
		print "\"lat\": \"" $2 "\", \"lon\": \"" $4 "\", \"elev\": \"" $6 "\"}"
}' '{}' ';' | \
awk -v NLINES="$(ls data | wc -l)" '{
	printf $0;
	if (NR < NLINES) print ",";
	else print " "
}'
echo "]"
