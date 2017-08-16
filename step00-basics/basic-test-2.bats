#!/usr/bin/env bats

## This test assumes that script under test lies in the same folder as the test

## run collects the return code and output

@test "simple-script should pass" {
  run $BATS_TEST_DIRNAME/simple-script.sh  "foo" 0
  [ "$status" -eq 0 ]
  [ "$output" = "foo" ]
}

@test "simple-script should pass on exit 4 (lets say the purpose is to check for error detection)" {
  run $BATS_TEST_DIRNAME/simple-script.sh  "foo" 4
  [ "$status" -eq 4 ]
  [ "$output" = "foo" ]
}

@test "simple-script-with-error should fail on cat foo" {
  run $BATS_TEST_DIRNAME/simple-script-with-errors.sh
  [ "$status" -eq 0 ]
}

@test "simple-script-with-stderr should pass" {
  $BATS_TEST_DIRNAME/simple-script-with-stderr.sh
  [ "$status" -eq 0 ]
  [ "$output" = "bar" ]
}

