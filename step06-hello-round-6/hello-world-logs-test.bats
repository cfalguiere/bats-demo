#!/usr/bin/env bats

## This test assumes that the script under test lies in the same folder as the test
## $BATS_TEST_DIRNAME is one of the environment variables provided by Bats

# let's try with a simple name

load hello-world-functions-test-helper

@test "severity info should start with INFO and show the message" {
  run functions_test_helper log_info "this is a test"
  echo "output=$output"
  [[ "$output" = "INFO - this is a test"  ]]
}

@test "severity info should start with INFO and show the message - alt" {
  run log_info_test_helper "this is a test"
  echo "output=$output"
  [[ "$output" = "INFO - this is a test"  ]]
}

@test "severity error should start with ERROR and show the message" {
  run functions_test_helper log_error "this is a test"
  echo "output=$output"
  [[ "$output" = "ERROR - this is a test"  ]]
}

@test "severity error should start with ERROR and show the message - alt" {
  run log_error_test_helper "this is a test"
  echo "output=$output"
  [[ "$output" = "ERROR - this is a test"  ]]
}


# in order to test whether INFO goes on stderr, stdout is redirect nowhere
# output now only contains the content of stderr

@test "info should go on stderr" {
  run $BATS_TEST_DIRNAME/hello-world.sh -v -n Alice 1>/dev/null
  echo "output=$output"
  [[ "$output" = "INFO - this is a test"  ]]
}

