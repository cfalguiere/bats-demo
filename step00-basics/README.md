# Bats basics

Bats stands for Bash Automated Testing System.


> Bats is a TAP-compliant testing framework for Bash. It provides a simple way to verify that the UNIX programs you write behave as expected.
>
>A Bats test file is a Bash script with special syntax for defining test cases. Under the hood, each test case is just a function with a description.
>
>-- Bats project

Bats is a github project which can be found here  [Bats project (github repository)](https://github.com/sstephenson/bats)

I've found interessing resources listed at the end of this page. I've decided to make my own for two reasons

- gather all the resources I've found useful in one place
- document some use cases I've found difficult to understand, especially if you're not an skilled shell programmer.


So let's go!

# A very simple example of bats test

Here is a very simple bats test


file simple-echo-test.bats

```
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


# Bats resouurces

Bats project
- [Bats project (github repository)](https://github.com/sstephenson/bats)
- [Bats prokect's Wiki](https://github.com/sstephenson/bats/wiki)

Some other useful resources:

- [Bats manual (Ubuntu version)](http://manpages.ubuntu.com/manpages/yakkety/man7/bats.7.html)
- https://blog.engineyard.com/2014/bats-test-command-line-tools
- https://medium.com/@pimterry/testing-your-shell-scripts-with-bats-abfca9bdc5b9
- http://blog.spike.cx/post/60548255435/testing-bash-scripts-with-bats

Thanks to authors of all these posts where I found useful examples and explanations.


