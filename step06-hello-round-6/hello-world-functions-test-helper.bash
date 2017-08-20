#!/bin/bash
source $BATS_TEST_DIRNAME/hello-world-functions.sh
#TODO script path

function log_info_test() {
  msg="this is a test" \
  log_info()
}
