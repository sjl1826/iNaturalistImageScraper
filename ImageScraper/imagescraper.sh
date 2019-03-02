#!/bin/bash

IFS=$'\n'
set -f
url_file=$1
for line in $(cat $url_file) ; do
    wget --output-document="file.html" $line 2>/dev/null
    ggrep -Po '(?<=content=")https://static[^"]*' file.html > links.txt
    link=$(head -n 1 links.txt)
    link=$(echo $link | sed 's/?.*//g')
    title=$(ggrep "<title>" file.html | sed "s/<title>//g" | sed "s/ //g")
    wget --output-document=$title $link 2>/dev/null
    rm -f file.html links.txt
done