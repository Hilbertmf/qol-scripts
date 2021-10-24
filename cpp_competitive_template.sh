#!/bin/bash

main() {
  # no input
  if (($# < 1)); then
    print_usage
    exit 1
  fi

  # get flags
  contest_flag=0
  specific_flag=0
  num_problems=0
  while getopts "c:s:h" flag; do
    case $flag in
      c)
      num_problems=$OPTARG
      contest_flag=1 ;;
      s)
      problem_names=$OPTARG 
      specific_flag=1 ;;
      h)
      print_usage
      exit ;;
    esac
  done

  # num_problems not integer
  if ! [[ "$num_problems" =~ ^[0-9]+$ ]]; then
      echo "Error: expected integer"
      print_usage
      exit 1
  fi

  if (($contest_flag > 0)); then
    echo "creating contest problems..."
    problems=("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T")

    for ((i=0;i<$num_problems;i++));
    do
      echo "creating file ${problems[$i]}.cpp..."
      create_file ${problems[$i]}
    done
  elif (($specific_flag > 0)) ;then
    
    names=$(echo $problem_names | tr "," " ")
    for name in $names
    do
      echo "creating file $name.cpp..."
      create_file $name
    done
  else
    filename="$1"
    echo "creating file $filename.cpp..."
    create_file $filename
  fi

  create_io_files
  echo "Done!"
}

create_file() {
  local code="#include <bits/stdc++.h>
  \nusing namespace std;
  \n#define INF (int)1e9
  \n#define LONGINF (long)1e18
  \n#define MEM(a, b) memset(a, (b), sizeof(a))
  \n#define fastio ios_base::sync_with_stdio(0);cin.tie(0);cout.tie(0);
  \nconst int MOD = 1000000007; // 10^9 - 7
  \n
  \nvoid solve() {
  \n
  \n}
  \n
  \nint solve(int arg) {
  \n
  \n}
  \n
  \nint main() {
    \n\tfastio;
    \n\t//ifstream cin(\"in.txt\");
    \n\t//ofstream cout(\"out.txt\"); // cout to file
    \n\t//freopen(\"out.txt\",\"w\",stdout); // use this one for printf to file
    \n\n\tint n, ans;
    \n\tcin >> n;
    \n\t//int arr[n] = {0};
    \n\n\n\t//for(int i = 0; i < n; i++)
    \n\t\t//  cin >> arr[i];

    \n\n\n\tcout << ans << endl;
    \n\t//printf(\"%d\", ans);
    \n\treturn 0;
  \n}"

  echo -e $code > "$1.cpp"
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
create specific files: -s <file1>,<file2>,..."
}

main "$@"; exit