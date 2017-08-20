#!/bin/bash
source $BATS_TEST_DIRNAME/hello-world-logs-functions.sh
# change $BATS_TEST_DIRNAME if code under test is not in same folder as test

function functions_test_helper() {
  $@
}
