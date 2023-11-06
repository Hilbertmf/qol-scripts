#!/bin/bash

if (($# != 2)); then
	echo "Usage: pdf2csv.sh <file.pdf> <output_file_name>"
	exit 1
fi

echo "Converting pdf to txt..."

pdftotext -layout "$1" "$2.txt"

# After convert it to txt we have to parse through the lines and separate the fields by commas

echo "Converting txt to csv..."

# Let's add an space after the first field, replace the commas with dots and then separate them

awk '{ sub(/^[ \t]+/, ""); print}' "$2.txt" | sed 's/ /   /' | awk '{gsub(/,/,".")} 1' |
awk  -F'[[:space:]][[:space:]]+' 'BEGIN{OFS=",";} {print $1, $2, $3, $4, $5, $6, $7}' > "$2.csv"

rm "$2.txt"

echo "Done!"
