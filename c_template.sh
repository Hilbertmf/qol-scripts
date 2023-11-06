#!/bin/bash

if (($# != 1)); then
	echo "Usage: c_template.sh <filename>"
	exit 1
fi

filename="$1"

cat << EOF > "$filename.c"
#include <stdio.h>
#include <stdlib.h>

int main()
{
\tint aux;
\tscanf("%d", &aux);
\tprintf("%d", aux);
\treturn 0;
}
EOF

echo "Done!"
