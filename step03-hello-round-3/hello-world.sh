#!/bin/bash
name=$1
#[[ -z $name ]] && { echo "No name provided. Name is mandatory!"; exit 1 }
#[[ -z $name ]] && { echo "No name provided. Name is mandatory!"; exit 1; }

errors=()
[[ -z $name ]] && errors+="No name provided. Name is mandatory!"
[[ $# -ne 1 ]] && errors+="Usage: $0 <name>"
echo "errors=${errors[@]}"
[[ -z ${errors[@]} ]] || { echo "${errors[@]}"; exit 1; }

echo "Hello $name!"
