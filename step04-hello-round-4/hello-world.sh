#!/bin/bash
name=$1
[[ -z $name ]] && { echo "No name provided. Name is mandatory!"; exit 1; }

#errors=()
#[[ $# -ne 1 ]] && errors+="Usage: $0 <name>"
#[[ $# -ne 1 ]] && errors+=("Usage: $0 <name>")

#name=$1
#[[ -z $name ]] && errors+="No name provided. Name is mandatory!"
#[[ -z $name ]] && errors+=("No name provided. Name is mandatory!")

#[[ -z ${errors[@]} ]] || { for i in ${errors[@]}; do echo "$i"; done; exit 1; }
#[[ -z ${errors[@]} ]] || { for i in "${errors[@]}"; do echo $i; done; exit 1; }

echo "Hello $name!"
