#!/bin/bash
source $BATS_TEST_DIRNAME/hello-world-functions.sh
#TODO script path

function functions_test_helper() {
  eval "$@"
}
