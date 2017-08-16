#!/usr/bin/env bats

## This test assumes that script under test lies in the same folder as the test

## The simpliest way ti use bats it to call the script

@test "basic-script-with-error should should fail" {
  $BATS_TEST_DIRNAME/basic-script-with-error.sh
}

@test "basic-script should succeed" {
  $BATS_TEST_DIRNAME/basic-script.sh  "foo" 1
}

@test "basic-script should fail" {
  $BATS_TEST_DIRNAME/basic-script.sh  "foo" 1
}
