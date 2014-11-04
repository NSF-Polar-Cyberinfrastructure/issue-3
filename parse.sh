#!/bin/bash

mkdir -p $1
cd $1
[ ! "$(ls -A ./)" ] && wget -q -nd -r ftp://amrc.ssec.wisc.edu/pub/requests/DVPC/AWS_q3h_MAY_2014/\*
cd ..

echo "["

find $1 -type f -exec awk '
BEGIN { printf "{" }
{
	if (NR==1) {
		printf "\"year\": " $2 ", "
		printf "\"month\": " $4 ", "
		printf "\"name\": \"" $10 "\", "
		printf "\"id\": \"" $6 "\", "
		printf "\"argos\": " $8 ", "
	}
	else if (NR==2) {
		printf "\"lat\": \"" $2 "\"" ", "
		printf "\"lon\": \"" $4 "\"" ", "
		printf "\"elev\": \"" $6 "\"" ", "
		printf "\"data\": ["
	}
	else {
		if (NR > 3) printf ", "
		printf "{"
		printf "\"julian day\": " $2 ", "
		printf "\"day\": " $4 ", "
		printf "\"ten minute obs time\": " $5 ", "
		printf "\"temp\": " $6 ", "
		printf "\"pressure\": " $7 ", "
		printf "\"wind speed\": " $8 ", "
		printf "\"wind direction\": " $9 ", "
		printf "\"humidity\": " $10
		printf "}"
	}
}
END {print "]}"}' '{}' ';' | \
awk '{
	if (NR > 1) print ", "
	printf $0;
}'
echo
echo "]"