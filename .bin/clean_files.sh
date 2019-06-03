#!/bin/bash

# Replaces spaces in filenames with underscores and converts filenames to lowercase
# Run within a directory to convert all files

ls | while read -r FILE
do
    mv -v "$FILE" `echo $FILE | tr ' ' '_' | tr -d '[{}(),\!]' | tr -d "\'" | tr '[A-Z]' '[a-z]' | sed 's/_-_/_/g'`
done
