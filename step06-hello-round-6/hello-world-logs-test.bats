#!/usr/bin/env bats

## This test assumes that the script under test lies in the same folder as the test
## $BATS_TEST_DIRNAME is one of the environment variables provided by Bats

# let's try with a simple name

load hello-world-functions-tests-helper

@test "logs info should start with INFO and show the message" {
  run log_info_test
  [[ "$output" = "this is a test"  ]]
}

