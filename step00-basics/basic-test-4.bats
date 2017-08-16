#!/usr/bin/env bats

## This test assumes that script under test lies in the same folder as the test

## a way to debug is to show the content of status, output and lines
## bats tests are silent when they pass
## however when a test fail, bats shows the stdout and stderr of the test function


@test "simple-script-with-multiple-lines should output foo - debug" {
  run $BATS_TEST_DIRNAME/simple-script-with-multiple-lines.sh
  [ "$status" -eq 0 ]
  echo "content of \${output} = ${output}"
  [ "${output}" = "foo" ]
  #[[ "${output}" =~ "foo" ]]  # correct test
}

@test "simple-script-with-multiple-lines should contain foo - debug" {
  run $BATS_TEST_DIRNAME/simple-script-with-multiple-lines.sh
  [ "$status" -eq 0 ]
  echo "expansion of \${lines[@]} = ${lines[@]}" >&2 
  [ "${lines[0]}" = "xxxx" ]
}

@test "simple-script-with-multiple-lines should contain foo - debug" {
  run $BATS_TEST_DIRNAME/simple-script-with-multiple-lines.sh
  [ "$status" -eq 0 ]
  echo "expansion of \${lines[@]} = ${lines[@]}"  > out.txt
  [ "${lines[0]}" = "foo" ]  # correct test
}
