#!/usr/bin/env bats

## This test assumes that the script under test lies in the same folder as the test
## $BATS_TEST_DIRNAME is one of the environment variables provided by Bats

# let's try with a simple name

load hello-world-functions-test-helper

@test "logs info should start with INFO and show the message" {
  run functions_test_helper msg="this is a test" log_info
  echo "output=$output"
  [[ "$output" = "INFO - this is a test"  ]]
}

