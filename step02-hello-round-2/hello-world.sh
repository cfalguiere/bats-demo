#!/bin/bash
echo Hello$([ -z $1 ] || echo " $1")!
