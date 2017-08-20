#!/bin/bash
script_dir=$(readlink -f $0 | xargs dirname)
source $script_dir/hello-world-functions.sh

function log_info_test() {
  msg="this is a test" \
  log_info()
}
