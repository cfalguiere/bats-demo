#!/bin/bash
errors=()
script_name=$(readlink -f $0 | xargs basename)
[[ $# -ne 1 ]] && errors+=("Usage: $script_name <name>")

# read arguments
#
name=
while getopts "n:" opt; do
  case $opt in
    n)
      name=$OPTARG
      ;;
  esac
done

# check arguments
#
[[ -z $name ]] && errors+=("No name provided. Name is mandatory!")

[[ -z ${errors[@]} ]] || { for i in "${errors[@]}"; do echo $i; done; exit 1; }

# do the task
#
echo "Hello $name!"
