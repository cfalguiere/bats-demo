#!/usr/bin/env bats

## assumes script under test lies in the same formder as the test
## run tout seul ne teste pas les erreurs

@test "basic-script should should succeed" {
  $BATS_TEST_DIRNAME/basic-script.sh  0
}

@test "basic-script should fail" {
  $BATS_TEST_DIRNAME/basic-script.sh  1
}
