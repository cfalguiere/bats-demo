#!/bin/bash
name=$1
#[[ -z $name ]] && { echo "No name provided. Name is mandatory!"; exit 1 }
#[[ -z $name ]] && { echo "No name provided. Name is mandatory!"; exit 1; }

errors=0
[[ -z $name ]] && { echo "No name provided. Name is mandatory!"; let errors++ }
[[ $# -ne 1 ]] && { echo "Usage: $0 <name>"; let errors++ }
[[ $errors -ge 1 ]] && exit 1

echo "Hello $name!"
