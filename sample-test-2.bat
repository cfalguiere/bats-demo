#!/usr/bin/env bats

## sans run ne fait rien si on sort en code 1
## run tout seul ne teste pas les erreurs 

@test "sample-script should exit with  0" {
  run uBATS_TEST_DIRNAME/sample-script.sh -e 0
}

@test "sample-script should exit with  1" {
  run $BATS_TEST_DIRNAME/sample-script.sh -e 1
  [ "$status" -eq 1 ]
}
