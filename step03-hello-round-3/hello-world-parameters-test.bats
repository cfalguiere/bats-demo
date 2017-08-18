#!/usr/bin/env bats

## This test assumes that the script under test lies in the same folder as the test
## $BATS_TEST_DIRNAME is one of the environment variables provided by Bats

test "When no name is provided should output name is mandatory and exit with 1" {
  run $BATS_TEST_DIRNAME/hello-world.sh
  cat /tmp/bats.26241.src
  echo "status=$status"
  echo "output=$output"
  [ "$status" -eq 1 ]
  [ "$output" = "No name provided. Name is mandatory!" ]
}

@test "When no parameter is provided should output the usage and exit with 1" {
  run $BATS_TEST_DIRNAME/hello-world.sh
  [ "$status" -eq 1 ]
  [ "$output" = "Usage: hello-world.sh <name>" ]
}


