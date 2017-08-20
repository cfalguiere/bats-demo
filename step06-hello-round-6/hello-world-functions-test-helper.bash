#!/bin/bash
source $BATS_TEST_DIRNAME/hello-world-logs-functions.sh
#TODO script path

function functions_test_helper() {
  echo $1
  echo $2
  eval $@
}
