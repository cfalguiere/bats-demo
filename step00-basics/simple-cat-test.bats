#!/usr/bin/env bats

@test "simple-cat should output the content of the file" {
  run simple-cat.sh foofile
  [ "$status" -eq 0 ]
  [ "$output" = "foo" ]
}

@test "simple-cat should output the content of the file" {
  run simple-cat.sh simple-echo-test.bats
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "#!/usr/bin/env bats" ]
}
