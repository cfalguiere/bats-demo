# Unit testing Hello World with Bats - Round 3

After the demo, user were happy with Hello World and new specificxations arose.

Users find it weird

<br>

## Specifications for Round 3

Exiting specifications


- The script must output Hello x! where x stand for the name given as a parameter


Additional specifications

- When no name is provided the script should result in errors
- Whenever the script is called without parameters or wrong parameters, it should state why the program failed and print the usage

<br>

## New test file

I will not change the arguments for now. Additional error management will be added.


As this specification are more about how to deal with parameters, I've started a new test file named [hello-world-parameters-test.bat](hello-world-parameters-test.bat). Old test file has also been renamed.


```
# file hello-world-parameters-test.bat
#!/usr/bin/env bats

@test "When no name is provided should output name is mandatory and exit with 1" {
  run $BATS_TEST_DIRNAME/hello-world.sh
  [ "$status" -eq 0 ]
  [ "$output" = "No name provided. Name is mandatory!" ]
}

@test "When no parameter is provided should output the usage and exit with 1" {
  run $BATS_TEST_DIRNAME/hello-world.sh
  [ "$status" -eq 1 ]
  [ "$output" = "Usage: hello-world.sh <name>" ]
}
```

Both tests failed. But the first one does not failed where expected. Can you see why ?

The first test shoud fail on status check instead on output.

There is often useful to check that everything fails before fixing the test. One of the issues with tests is that they might be written in such a way that they always pass.

```
$ bats step03-hello-round-3/hello-world-parameters-test.bats
 ✗ When no name is provided should output name is mandatory and exit with 1
   (in test file step03-hello-round-3/hello-world-parameters-test.bats, line 15)
     `[ "$output" = "No name provided. Name is mandatory!" ]' failed
 ✗ When no parameter is provided should output the usage and exit with 1
   (in test file step03-hello-round-3/hello-world-parameters-test.bats, line 8)
     `[ "$status" -eq 1 ]' failed

2 tests, 2 failures
```

Now the test is fixed for checking for exit 1 in both case. Let's fix the code to pass the test.

I changed the script for the code below

```
#!/bin/bash
name=$1
[[ -z $name ]] && { echo "No name provided. Name is mandatory!"; exit 1 }
echo "Hello $name!"
```

cfalguiere@ip-172-31-30-150:~/projects/batsTest/bats-demo$ ../bats/bin/bats step03-hello-round-3/hello-world-parameters-test.bats
/tmp/bats.26241.src: line 6: test: When no name is provided should output name is mandatory and exit with 1: unary operator expected
cf

<br>

## What we have learned

- the need to ensure that a test is not always passing
- how to test script error management
- how to test multiple lines
- how to organize tests in different files
- how to run a test suite by listing the files or running the test folder
