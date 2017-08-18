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

```
cfalguiere@ip-172-31-30-150:~/projects/batsTest/bats-demo$ ../bats/bin/bats step03-hello-round-3/hello-world-parameters-test.bats
/tmp/bats.26241.src: line 6: test: When no name is provided should output name is mandatory and exit with 1: unary operator expected
cf
````

What is this /tmp/bats.26241.src ?

Bats generates a script for each bats file. This file is located in /tmp/bats.an_id.src.src


Here is a trick to print out this script.

```
@test "inspect bats src" {
  ls  /tmp/bats.*.src | xargs -I{} cat {}
  [ 1 -eq 0 ]
}
```

An an example of this script

```
 ✗ inspect bats src
   (in test file step03-hello-round-3/hello-world-parameters-test.bats, line 22)
     `[ 1 -eq 0 ]' failed
   #!/usr/bin/env bats

   ## This test assumes that the script under test lies in the same folder as the test
   ## $BATS_TEST_DIRNAME is one of the environment variables provided by Bats


   test_When_no_name_is_provided_should_output_name_is_mandatory_and_exit_with_1() { bats_test_begin "When no name is provided should output name is mandatory and exit with 1" 7;
     run $BATS_TEST_DIRNAME/hello-world.sh
     [ "$status" -eq 1 ]
     [ "$output" = "No name provided. Name is mandatory!" ]
   }

   test_When_no_parameter_is_provided_should_output_the_usage_and_exit_with_1() { bats_test_begin "When no parameter is provided should output the usage and exit with 1" 13;
     run $BATS_TEST_DIRNAME/hello-world.sh
     [ "$status" -eq 1 ]
     [ "$output" = "Usage: hello-world.sh <name>" ]
   }


   test_inspect_bats_src() { bats_test_begin "inspect bats src" 20;
     ls  /tmp/bats.*.src | xargs -I{} cat {}
     [ 1 -eq 0 ]
   }


   bats_test_function test_When_no_name_is_provided_should_output_name_is_mandatory_and_exit_with_1
   bats_test_function test_When_no_parameter_is_provided_should_output_the_usage_and_exit_with_1
   bats_test_function test_inspect_bats_src
````

The problem was that the first @ was unintentionaly removed.
When the @ in @test were missing the generated file was wrong and resulted in errors.


By the way, Bats also sets

   BATS_CWD=/home/cfalguiere/projects/batsTest/bats-demo
   BATS_PREFIX=/home/cfalguiere/projects/batsTest/bats


I will skip the inspect test later on.

````
@test "inspect bats src" {
  skip
  ls  /tmp/bats.*.src | xargs -I{} cat {}
  [ 1 -eq 0 ]
}
```

But the test still fail.

```
$ bats step03-hello-round-3/hello-world-parameters-test.bats
 ✗ When no name is provided should output name is mandatory and exit with 1
   (in test file step03-hello-round-3/hello-world-parameters-test.bats, line 9)
     `[ "$status" -eq 1 ]' failed
 ✗ When no parameter is provided should output the usage and exit with 1
   (in test file step03-hello-round-3/hello-world-parameters-test.bats, line 15)
     `[ "$status" -eq 1 ]' failed
 - inspect bats src (skipped)
````

After some checks in the documentation, the script need be changed as shown below.
```
#!/bin/bash
name=$1
#[[ -z $name ]] && { echo "No name provided. Name is mandatory!"; exit 1 }
[[ -z $name ]] && { echo "No name provided. Name is mandatory!"; exit 1; }
echo "Hello $name!"
````

It fixes the first test.

```
$ bats step03-hello-round-3/hello-world-parameters-test.bats
 ✓ When no name is provided should output name is mandatory and exit with 1
 ✗ When no parameter is provided should output the usage and exit with 1
   (in test file step03-hello-round-3/hello-world-parameters-test.bats, line 16)
     `[ "$output" = "Usage: hello-world.sh <name>" ]' failed
 - inspect bats src (skipped)

3 tests, 1 failure, 1 skipped
````

Now let's implement the usage.


<br>

## What we have learned

- the need to ensure that a test is not always passing
- how to test script error management
- how to test multiple lines
- how to organize tests in different files
- how to run a test suite by listing the files or running the test folder
