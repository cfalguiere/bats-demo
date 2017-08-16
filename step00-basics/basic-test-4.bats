#!/usr/bin/env bats

## This test assumes that script under test lies in the same folder as the test

## a way to debug is to show the content of status, output and lines before entering the test

@test "simple-script-with-multiple-lines should output foo" {
  run $BATS_TEST_DIRNAME/simple-script-with-multiple-lines.sh
  [ "$status" -eq 0 ]
  echo "content of \${output} = ${output}"
  [[ "${output}" =~ "foo" ]]
}

@test "simple-script-with-multiple-lines should output foo" {
  run $BATS_TEST_DIRNAME/simple-script-with-multiple-lines.sh
  [ "$status" -eq 0 ]
  echo "expansion of \${lines[@]} = ${lines[@]}"
  [ "${lines[0]}" = "foo" ]
}
