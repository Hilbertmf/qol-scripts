#!/bin/bash

main() {
  # no input
  if (($# < 1)); then
    print_usage
    exit 1
  fi

  # get flags
  contest_flag=0
  specify_flag=0
  num_problems=0
  while getopts "c:s:h" flag; do
    case $flag in
      c)
        num_problems=$OPTARG
        contest_flag=1 ;;
      s)
        problem_names=$OPTARG
        specify_flag=1 ;;
      h)
        print_usage
        exit ;;
      *)
        print_usage
        exit 1 ;;
    esac
  done

  # num_problems not integer
  if ! [[ "$num_problems" =~ ^[0-9]+$ ]]; then
      echo "Error: expected integer"
      print_usage
      exit 1
  fi

  if ((contest_flag > 0)); then
    echo "creating contest problems..."
    problems=("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T")

    for ((i=0;i<num_problems;i++));
    do
      echo "creating file ${problems[$i]}.cpp..."
      create_file "${problems[$i]}"
    done
  elif ((specify_flag > 0)) ;then
    
    names=$(echo "$problem_names" | tr "," " ")
    for name in $names
    do
      echo "creating file $name.cpp..."
      create_file "$name"
    done
  else
    filename="$1"
    echo "creating file $filename.cpp..."
    create_file "$filename"
  fi

  create_io_files
  echo "Done!"
}

create_file() {
  cat << EOF > "$1.cpp"
#include <bits/stdc++.h>
using namespace std;
#define DEBUG(x) cout << #x << " >>>> " << x << endl
#define MID(l, r) (l + (r - l) / 2)
#define CEILDIVISION(x, y) ((x + y - 1) / y)
#define INF (int)1e9
#define LONGINF (long long)1e18
#define MEM(arr, val) memset(arr, (val), sizeof(arr))
#define FASTIO ios_base::sync_with_stdio(0);cin.tie(0);cout.tie(0);
const int MOD = 1000000007; // 10^9 - 7

int main() {
\tFASTIO;


\treturn 0;
}
EOF
}

create_io_files() {
  input=in.txt
  output=out.txt
  if ! test -f "$input"; then
    echo "creating $input..."
    touch "in.txt"
  fi

  if ! test -f "$output"; then
    echo "creating $output..."
    touch "out.txt"
  fi
}

print_usage() {
  echo "Usage:
create single file: cpp_competitive_template.sh <filename>
start a contest: -c <num_problems>
specify file names: -s <file1>,<file2>,..."
}

main "$@"; exit