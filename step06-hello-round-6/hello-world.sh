#!/bin/bash

script_dir=$(readlink -f $0 | xargs dirname)
script_name=$(readlink -f $0 | xargs basename)

source $script_dir/hello-world-functions.bash

errors=()
#[[ $# -eq 0 ]] && errors+=("Usage: $script_name [-v] -n name")
[[ $# -eq 0 ]] && usage

# read arguments
#
#name=$1
name=
verbosity=0
while getopts "vhn:" opt; do
  case $opt in
    v)
      let verbosity++
      echo "verbose mode is on"
      ;;
    h)
      usage
      exit
      ;;
    n)
      name=$OPTARG
      [[ $verbosity -ge 1 ]] && echo "input parameter name = '""$name""'"
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