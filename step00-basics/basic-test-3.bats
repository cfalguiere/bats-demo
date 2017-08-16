#!/usr/bin/env bats

## This test assumes that script under test lies in the same folder as the test

## [ ] are regular bash tests

## regex applies. please note that the =~ operator is only defined for test2, thus it requires double []

@test "simple-script output should start with fo" {
  run $BATS_TEST_DIRNAME/simple-script.sh  "foo" 0
  [ "$status" -eq 0 ]
  [[ "$output" =~ ^fo.*$ ]]
}

## this is also an handy way to check for a text on multiple lines

@test "simple-script-with-multiple-lines output should contain foo" {
  run $BATS_TEST_DIRNAME/simple-script-with-multiple-lines.sh
  [ "$status" -eq 0 ]
  [[ "$output" =~ foo ]]
}


## another option for multiple lines is to check the array provided by bats

@test "simple-script-with-multiple-lines should output foo then bar" {
  run $BATS_TEST_DIRNAME/simple-script-with-multiple-lines.sh
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "foo" ]
  [ "${lines[1]}" = "bar" ]
}

## check whether one of the lines match the pattern
## this one will fail
## you should be aware of what ${lines[@]} actually does. it shows the list of itmes on one row

@test "simple-script-with-multiple-lines should output foo - will fail" {
  run $BATS_TEST_DIRNAME/simple-script-with-multiple-lines.sh
  [ "$status" -eq 0 ]
  #echo "expansion of \${lines[@]} = ${lines[@]}" >&2
  [ "${lines[@]}" = "foo" ]
}

## check whether one of the lines match the pattern - pass but might not be what you want

@test "simple-script-with-multiple-lines should output foo - will pass" {
  run $BATS_TEST_DIRNAME/simple-script-with-multiple-lines.sh
  [ "$status" -eq 0 ]
  [[ "${lines[@]}" =~ "foo" ]]
}

## regexp also applies on lines

@test "simple-script-with-multiple-lines should output lines consisting of 3 letters" {
  run $BATS_TEST_DIRNAME/simple-script-with-multiple-lines.sh
  [ "$status" -eq 0 ]
  [ "${lines[0]}" =~ ^...$ ]
}

## check for the number of lines

@test "simple-script-with-multiple-lines should output 2 lines" {
  run $BATS_TEST_DIRNAME/simple-script-with-multiple-lines.sh
  [ "$status" -eq 0 ]
  [ "${#lines[@]}" -eq 2 ]
}
