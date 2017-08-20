#!/bin/bash
source $BATS_TEST_DIRNAME/hello-world-logs-functions.sh
#TODO script path

function functions_test_helper()
  CMD=$@
  echo $CMD
  eval $( $CMD )
}
