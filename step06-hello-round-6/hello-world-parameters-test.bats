#!/usr/bin/env bats

## This test assumes that the script under test lies in the same folder as the test
## $BATS_TEST_DIRNAME is one of the environment variables provided by Bats

USAGE_MESSAGE=(
"Usages:"
"    hello-world.sh [-v] -n name : output Hello name!"
"    hello-world.sh -h : show the help"
" Parameters :"
"    -v : increase verbosity"
"    -n name : indicates the name of the person to say hello to"
"    -h : display the usage"
)


# check the usage for presence and check every line

@test "On -h should output the usage" {
  run $BATS_TEST_DIRNAME/hello-world.sh -h
  echo "output=${output}"
  [ "${#lines[@]}" -eq 7 ]
  for i in (0..7); do
    [ "${lines[$i]}" = "${USAGE_MESSAGE[$i]}" ]
  done
}

# check that -h does not exit with errors

@test "On -h should exit with 0" {
  run $BATS_TEST_DIRNAME/hello-world.sh -h
  [ "$status" -eq 1 ]
}


# only check the usage for presence

@test "When no parameter is provided output should contain the usage" {
  run $BATS_TEST_DIRNAME/hello-world.sh
  [[ "$output" =~ "${USAGE_MESSAGE[0]}"  ]]
}


@test "When no parameter is provided should output the usage on first line" {
  run $BATS_TEST_DIRNAME/hello-world.sh
  echo "line_0=${lines[0]}"
  [ "${lines[0]}" = "${USAGE_MESSAGE[0]}" ]
}

# When usage is triggered because no parameter were given, this is an error

@test "When no parameter is provided should exit with 1" {
  run $BATS_TEST_DIRNAME/hello-world.sh
  [ "$status" -eq 1 ]
}




