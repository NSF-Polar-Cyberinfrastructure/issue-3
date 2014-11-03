issue-3
=======

 Antarctic Meteorology Research Center (AMRC) datasets


Crawl the station names, locations, and data collected into a JSON file by running 
`./parse.sh [directory name]`.
This will `wget` data files from the AMRC FTP server and parse them into a single (large!) JSON 
file sent to standard out. If the directory given is not empty, it will be assumed to contain 
_only_ the crawled data files.
