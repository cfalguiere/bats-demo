# Bats basics

Bats stands for Bash Automated Testing System.


From Bats project:

```
Bats is a TAP-compliant testing framework for Bash. It provides a simple way to verify that the UNIX programs you write behave as expected.

A Bats test file is a Bash script with special syntax for defining test cases. Under the hood, each test case is just a function with a description.
```

Bats project and man page

- [Bats project (github repository)](https://github.com/sstephenson/bats)
- [Bats prokect's Wiki](https://github.com/sstephenson/bats/wiki)

Some other useful resources:

- [Bats manual (Ubuntu version)](http://manpages.ubuntu.com/manpages/yakkety/man7/bats.7.html)
- https://blog.engineyard.com/2014/bats-test-command-line-tools
- https://medium.com/@pimterry/testing-your-shell-scripts-with-bats-abfca9bdc5b9
- http://blog.spike.cx/post/60548255435/testing-bash-scripts-with-bats

These resources are great. I've decided to make my own for two reasons

- gather all the resources I've found useful in one place
- document some use cases I've found difficult to understand, especially if you're not an skilled shell programmer.


So let's go!

# A very simple example of bats test

Here is a very simple bats test


file simple-echo-test.bats

````
@test "simple-echo should output foo" {
  run simple-echo.sh  "foo"
  [ "$status" -eq 0 ]
  [ "$output" = "foo" ]
}
```

## test code description

A bats test has the following structure

- @test: this keyword tells bats that there is a test here
- a description: for instance "simple-script should output foo"
- a function: whatever code lies within curly braes { }

Bats will report success or failuure depending on the result of this function. You might use any kind of code. If you simply call a script and it fails, bats will report a failure.

Bats provide some helpers to ease testing. A typical bats test use the following pattern

- run: a wrapper used to collect the output of the function or program under test
- a function or program under test: for instance simple-script.sh  "foo"
- some checks

Checks are call to the [test bash command](http://manpages.ubuntu.com/manpages/xenial/man1/test.1.html).
You may use whatever kind of check for instance [ -z "$varname" ] or [ -f "$filename" ] to check whether a var is empty or whether a file exists.

Bats provide 3 variables holding the results of the function or program under test.

- status: the exit code
- output: the outputt of the functio or program. it collects stdout and stderr
- lines: an array consisting of each line of the output


## Run the bats test

Run this file and bats outputs a pretty test report

```
$ bats simple-echo-test.bats
 ✓ simple-echo should output foo

1 tests, 0 failures
```

This might tricky to analyse when running in an automated tool or CI tool. Bats provide a --tap option to produce a machine-readable report.

```
$ bats --tap simple-echo-test.bats
1..1
ok 1 simple-echo should output foo
```

- the first line shows the range of test numbers (for instance 1..4 when the file contains 4 tests)
- each lines shows ok or not ok, the test number, the test description


## Tests failuures

When a test fail, bats show the output of the program and the error report.


file simple-cat-test.bats

```
@test "simple-cat should output the content of the file" {
  run simple-cat.sh foofile
  [ "$status" -eq 0 ]
  [ "$output" = "foo" ]
}

```


```
$ bats  test.bats
 ✗ simple-cat should output the content of the file
   (in test file simple-cat-test.bats, line 4)
     `simple-cat.sh  foofile'  failed
   cat: foo: No such file or directory

1 tests, 1 failures
```


Bats run with TAP option which is easier to use in a program
```
$ /bats --tap  simple-cat-test.bats
1..1
not ok 1 simple-cat should output the content of the file
# (in test file simple-cat-test.bats, line 4)
#   `simple-cat.sh foofile' failed
# cat: foo: No such file or directory
```


# Advances use

## Run bats

This section shows basis use of bats.

Example tests and scripts lies in  [basic-test-1.bats](basic-test-1.bats)

The bats test run 3 sample scripts

- simple-script: echoes the first parameter and exits with the second parameter
- simple-script-with-errors: makes an attempt to use a non existant file
- simple-script-with-stderr: prints bar on stderr
- simple-script-with-multiple-lines: print two lines consisting of foo and bar

Bats run with human-readable option

```
$ bats  step00-basics/basic-test.bats
 ✓ simple-script should pass
 ✗ simple-script should fail on exit 1
   (in test file step00-basics/simple-test.bats, line 13)
     `$BATS_TEST_DIRNAME/simple-script.sh  "foo" 1' failed
   foo
 ✗ simple-script-with-error should fail on cat foo
   (in test file step00-basics/simple-test.bats, line 17)
     `$BATS_TEST_DIRNAME/simple-script-with-errors.sh' failed
   cat: foo: No such file or directory
 ✓ simple-script-with-stderr should pass

4 tests, 2 failures
```

Bats run with TAP option which is easier to use in a program
```
$ /bats --tap  step00-basics/basic-test.bats
1..4
ok 1 simple-script should pass
not ok 2 simple-script should fail on exit 1
# (in test file step00-basics/simple-test.bats, line 13)
#   `$BATS_TEST_DIRNAME/simple-script.sh  "foo" 1' failed
# foo
not ok 3 simple-script-with-error should fail on cat foo
# (in test file step00-basics/simple-test.bats, line 17)
#   `$BATS_TEST_DIRNAME/simple-script-with-errors.sh' failed
# cat: foo: No such file or directory
ok 4 simple-script-with-stderr should pass
```

## Check exit code and output

In this section, you will learn how to check the exit code and output.

Example tests and scripts lies in  [basic-test-2.bats](basic-test-2.bats)

```
$ bats step00-basics/basic-test-2.bats
 ✓ simple-script should pass
 ✗ simple-script will fail because exit code is not as expected
   (in test file step00-basics/basic-test-2.bats, line 18)
     `[ "$status" -eq 0 ]' failed
 ✗ simple-script-with-error will fail on cat foo
   (in test file step00-basics/basic-test-2.bats, line 27)
     `[ "$status" -eq 0 ]' failed
 ✓ simple-script should pass on exit 4
 ✓ simple-script-with-stderr should pass
 ✗ simple-script-with-multiple-lines will fail
   (in test file step00-basics/basic-test-2.bats, line 52)
     `[ "$status" -eq 0 ]' failed

6 tests, 3 failures
```

## Advanced checks (multiple lines, patterns, ...)

This section shows more advanced tests


```
$ bats step00-basics/basic-test-3.bats
 ✓ simple-script output should start with fo
 ✓ simple-script-with-multiple-lines output should contain foo
 ✓ simple-script-with-multiple-lines should output foo then bar
 ✗ simple-script-with-multiple-lines should output foo - will fail
   (in test file step00-basics/basic-test-3.bats, line 41)
     `[ "${lines[@]}" = "foo" ]' failed with status 2
   /tmp/bats.4468.src: line 41: [: too many arguments
 ✓ simple-script-with-multiple-lines should output foo - will pass
 ✓ simple-script-with-multiple-lines should output 2 lines
 ✓ simple-script-with-multiple-lines should output lines consisting of 3 letters
 ✓ simple-script-with-multiple-lines should output lines consisting of 3 letters - loop

8 tests, 1 failure
```

## Debug and troubleshooting

This section shows different techniques to feature out whats happen in the test


```
$ bats  step00-basics/basic-test-4.bats
 ✗ simple-script-with-multiple-lines should output foo - debug
   (in test file step00-basics/basic-test-4.bats, line 15)
     `[ "${output}" = "foo" ]' failed
   content of ${output} = foo
   bar
   expansion of ${lines[@]} = foo bar
 ✓ simple-script-with-multiple-lines should contain foo - output file
 ✓ same name - first should fail, second should pass
 ✓ same name - first should fail, second should pass

5 tests, 2 failures
```
