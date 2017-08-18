# Unit testing Hello World with Bats - Round 4

After the demo, user were happy. They feel the need for a usage of this beautiful program.

> **focus of this section**
> checking multiple line output
> organizing tests in multiple files
> run a test suite


## Specifications for Round 4

Existing specifications


- The script must output Hello x! where x stand for the name given as a parameter
- When no name is provided the script should result in errors


Additional specifications

- Whenever the script is called without parameters or wrong parameters, it should state why the program failed and print the usage



## New test file

I will not change the arguments for now.


As this specification is more about how to deal with parameters, I've started a new test file named [hello-world-parameters-test.bat](hello-world-parameters-test.bat). Old test file has also been renamed.


The new test file contains the lines below

```
# file hello-world-parameters-test.bat
#!/usr/bin/env bats

@test "When no parameter is provided should exit with 1" {
  run $BATS_TEST_DIRNAME/hello-world.sh
  [ "$status" -eq 1 ]
}

@test "When no parameter is provided should output the usage" {
  run $BATS_TEST_DIRNAME/hello-world.sh
  [ "$output" = "Usage: hello-world.sh <name>" ]
}
```

The first test is fine but it fails the second check because the code has not been fixed yet.

```
$ bats step04-hello-round-4/hello-world-parameters-test.bats
 ✓ When no parameter is provided should exit with 1
 ✗ When no parameter is provided should output the usage
   (in test file step04-hello-round-4/hello-world-parameters-test.bats, line 13)
     `[ "$output" = "Usage: hello-world.sh <name>" ]' failed

2 tests, 1 failures
```

Here is the script rewritten to allow multiple checks.

````
#!/bin/bash
errors=()
[[ $# -ne 1 ]] && errors+="Usage: $0 <name>"

name=$1
[[ -z $name ]] && errors+="No name provided. Name is mandatory!"

[[ -z ${errors[@]} ]] || { for i in ${errors[@]}; do echo "$i"; done; exit 1; }

echo "Hello $name!"
`````



Now the test is fixed for checking for exit 1 in both case. Let's fix the code to pass the test.

Now the test is fixed for checking for exit 1 in both case. Let's fix the code to pass the test.

I changed the script for the code below

```
#!/bin/bash
name=$1
[[ -z $name ]] && { echo "No name provided. Name is mandatory!"; exit 1 }
echo "Hello $name!"
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

The code now use a table and add error message for each test. If there are error messages it show all the errors

````
#!/bin/bash
name=$1
errors=()
[[ -z $name ]] && errors+="No name provided. Name is mandatory!"
[[ $# -ne 1 ]] && errors+="Usage: $0 <name>"
[[ -z ${errors[@]} ]] || { for i in ${errors[@]}; do echo $i; done; exit 1; }

echo "Hello $name!"
````

```
cfalguiere@ip-172-31-30-150:~/projects/batsTest/bats-demo$ ../bats/bin/bats step03-hello-round-3/hello-world-parameters-test.bats
 ✗ When no name is provided should output name is mandatory and exit with 1
   (in test file step03-hello-round-3/hello-world-parameters-test.bats, line 11)
     `[ "$output" = "No name provided. Name is mandatory!" ]' failed
   output=No
   name
   provided.
   Name
   is
   mandatory!Usage:
   /home/cfalguiere/projects/batsTest/bats-demo/step03-hello-round-3/hello-world.sh
   <name>
 ✗ When no parameter is provided should output the usage and exit with 1
   (in test file step03-hello-round-3/hello-world-parameters-test.bats, line 17)
     `[ "$output" = "Usage: hello-world.sh <name>" ]' failed
 - inspect bats src (skipped)

3 tests, 2 failures, 1 skipped
```

Fixed into
````
#!/bin/bash
name=$1
errors=()
[[ -z $name ]] && errors+="No name provided. Name is mandatory!"
[[ $# -ne 1 ]] && errors+="Usage: $0 <name>"
[[ -z ${errors[@]} ]] || { for i in "${errors[@]}"; do echo $i; done; exit 1; }

echo "Hello $name!"
````

The text is no more splitted by words but both messages are on the same line.


```
cfalguiere@ip-172-31-30-150:~/projects/batsTest/bats-demo$ ../bats/bin/bats step03-hello-round-3/hello-world-parameters-test.bats
 ✗ When no name is provided should output name is mandatory and exit with 1
   (in test file step03-hello-round-3/hello-world-parameters-test.bats, line 11)
     `[ "$output" = "No name provided. Name is mandatory!" ]' failed
   output=No name provided. Name is mandatory!Usage: /home/cfalguiere/projects/batsTest/bats-demo/step03-hello-round-3/hello-world.sh <name>
 ✗ When no parameter is provided should output the usage and exit with 1
   (in test file step03-hello-round-3/hello-world-parameters-test.bats, line 17)
     `[ "$output" = "Usage: hello-world.sh <name>" ]' failed
 - inspect bats src (skipped)

3 tests, 2 failures, 1 skipped
```

Fixed into
````
#!/bin/bash
name=$1
errors=()
[[ -z $name ]] && errors+=("No name provided. Name is mandatory!")
[[ $# -ne 1 ]] && errors+=("Usage: $0 <name>")
[[ -z ${errors[@]} ]] || { for i in "${errors[@]}"; do echo $i; done; exit 1; }

echo "Hello $name!"
````

Now it works as expected.

````
$ ./step03-hello-round-3/hello-world.sh
No name provided. Name is mandatory!
Usage: ./step03-hello-round-3/hello-world.sh <name>
````

But the test don't pass.

```
cfalguiere@ip-172-31-30-150:~/projects/batsTest/bats-demo$ ../bats/bin/bats step03-hello-round-3/hello-world-parameters-test.bats
 ✗ When no name is provided should output name is mandatory and exit with 1
   (in test file step03-hello-round-3/hello-world-parameters-test.bats, line 11)
     `[ "$output" = "No name provided. Name is mandatory!" ]' failed
   output=No name provided. Name is mandatory!
   Usage: /home/cfalguiere/projects/batsTest/bats-demo/step03-hello-round-3/hello-world.sh <name>
 ✗ When no parameter is provided should output the usage and exit with 1
   (in test file step03-hello-round-3/hello-world-parameters-test.bats, line 17)
     `[ "$output" = "Usage: hello-world.sh <name>" ]' failed
 - inspect bats src (skipped)

3 tests, 2 failures, 1 skipped
```

The reason is that output contains 2 lines and does not match either message.

The test need be rewritten with one or the other of  these techniques

- check that output contains the message instead of equals
- check each line separately

In order to check for the name is mandatory message, here are the two tests

```
@test "When no name is provided should output name is mandatory and exit with 1" {
  run $BATS_TEST_DIRNAME/hello-world.sh
  echo "output=$output"
  [ "$status" -eq 1 ]
  [[ "$output" =~ "No name provided. Name is mandatory!" ]]
}

@test "When no name is provided should output name is mandatory on first line" {
  run $BATS_TEST_DIRNAME/hello-world.sh
  echo "output=$output"
  [ "$status" -eq 1 ]
  [ "${lines[0]}" = "No name provided. Name is mandatory!" ]
}
```



<br>

## What we have learned

- how to test multiple lines output
- how to organize tests in different files
- how to run a test suite by listing the files or running the test folder
