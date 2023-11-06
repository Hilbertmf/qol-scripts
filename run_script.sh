#!/bin/bash

main() {
  # no input
  if (($# < 1)); then
    print_usage
    exit 1
  fi

  # get flags
  while getopts "h" flag; do
    case $flag in
      h)
        print_usage
        exit ;;
      *)
        print_usage
        exit 1 ;;
    esac
  done

  filename="$1"
  run_file $filename
}

run_file() {
  g++ $1 && ./a.out -fmax-errors=1 <in.txt >out.txt 
}

print_usage() {
  echo "Usage:
run cpp file: run_script.sh <filename>"
}

main "$@"; exit