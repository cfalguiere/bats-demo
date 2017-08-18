#!/bin/bash
name=$1
[[ -z $name ]] && echo "No name provided. Name is mandatory!"
[[ -z $name ]] && exit 1 }
echo "Hello $name!"
