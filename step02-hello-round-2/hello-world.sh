#!/bin/bash
echo Hello $([ -z $1 ] && $1) !
