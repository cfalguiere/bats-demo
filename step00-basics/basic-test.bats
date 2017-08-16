#!/usr/bin/env bats

## This test assumes that script under test lies in the same folder as the test

## The simpliest way to use bats it to call the script
## Bats will catch exit with a non zero code whether they are forced (test 2) or caused by a script failure (test 3)

@test "basic-script should pass" {
  $BATS_TEST_DIRNAME/basic-script.sh  "foo" 0
}

@test "basic-script should fail on exit 1" {
  $BATS_TEST_DIRNAME/basic-script.sh  "foo" 1
}

@test "basic-script-with-error should fail on cat foo" {
  $BATS_TEST_DIRNAME/basic-script-with-errors.sh
}

@test "basic-script-with-stderr should pass" {
  $BATS_TEST_DIRNAME/basic-script-with-stderr.sh
}

