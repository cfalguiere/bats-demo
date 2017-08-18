#!/usr/bin/env bats

# let's try with a simple name

@test "should output Hello Alice!" {
  run hello-world.sh  "Alice"
  [ "$status" -eq 0 ]
  [ "$output" = "Hello Alice!" ]
}

# let's try with a another name in case Alice is hardcoded

@test "should output Hello Jabberwock!" {
  run hello-world.sh  "Jabberwock"
  [ "$status" -eq 0 ]
  [ "$output" = "Hello Jabberwock!" ]
}

# does it still wotk for composite names ?

@test "should output Hello Cheshire-Cat! when names has many words" {
  run hello-world.sh  "Cheshire-Cat"
  [ "$status" -eq 0 ]
  [ "$output" = "Hello Cheshire-Cat!" ]
}

# what if no name is provided  ?
# what do I expect in that case ? this test requires some specification clarifications
# Let's assume for a while it just skip the name

@test "should output Hello Cheshire-Cat! when names has many words" {
  run hello-world.sh
  [ "$status" -eq 0 ]
  [ "$output" = "Hello!" ]
}
