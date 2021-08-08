#!/bin/bash

if (($# != 1)); then
	echo "Usage: c_template.sh <filename>"
	exit 1
fi

filename="$1"

str="#include <stdio.h>\n\nint main()\n{\n\tint aux;\n\n\tprintf(\"%d\", aux);\n\n\treturn 0;\n}"

echo -e $str > "$filename.c"
echo "Done!"