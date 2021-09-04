#!/bin/bash

if (($# != 1)); then
	echo "Usage: cpp_template.sh <filename>"
	exit 1
fi

filename="$1"

str="#include <iostream>
\n#include <bits/stdc++.h>\n
\nusing namespace std;\n
\nint main()
\n{
  \n\tint aux;\n
  \n\tscanf(\"%d\", &aux);\n
  \n\tprintf(\"%d\", aux);\n
  \n\treturn 0;
\n}"

echo -e $str > "$filename.cpp"
echo "Done!"