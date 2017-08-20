# Unit testing Hello World with Bats - Round 5

Now the script is used on a daily basis, users feel the need for improvements.

They sometimes have trouble debugging or remembreing options. They would like to have a more verbosity and a help. We have also decided to introduc switches.

> **focus of this section**
>
> - refactoring of tests
> - adding new tests


## Specifications for Round 5

Existing specifications


- The script must output Hello x! where x stand for the name given as a parameter
- When no name is provided the script should result in errors
- Whenever the script is called without parameters or wrong parameters, it should state why the program failed and print the usage


Additional specifications

- The script must provide a way to output the usage
- The script must provide a way to print input parameters in order to debug


## New usage

Hello World now has the following parameters :

 - -v : increase verbosity. in verbose mode  parameters' values will show up
 - -n name : indicates the name of the person to say hello to
 - -h : display the usage

This is a major refactoring and unit tests will be a great help.

There are many changes to be done from a technical standpoint.

- most of the calls to the program will be altered due to the addition of the -n switch
- need some code to manage the command line options
- new tests are required for -v and -h


TODO output hello sur la premiere ligne sauf si verbose et pas d'autres choses


## Adding -n switch

We will focus on the following tasks

> - most of the calls to the program will be altered due to the addition of the -n switch
> - need some code to manage the command line options


Each test is adapted to fit the -n switch. For instance :

```
@test "should output Hello Alice!" {
  run $BATS_TEST_DIRNAME/hello-world.sh -n Alice
  [ "$status" -eq 0 ]
  [ "$output" = "Hello Alice!" ]
}
```

All tests now fail, excepted the test for no arguments. Let's fix the code.

````
name=$1
`````

is replaced with

```name=
while getopts "n:" opt; do
  case $opt in
    n)
      name=$OPTARG
      ;;
  esac
done
```

Well ... Test for errors are OK, while tests that souuld output the name still fail.

```
 ✗ should output Hello Alice!
   (in test file step05-hello-round-5/hello-world-names-test.bats, line 10)
     `[ "$status" -eq 0 ]' failed
```

Adding the trace of the output should help.

```
@test "should output Hello Alice!" {
  run $BATS_TEST_DIRNAME/hello-world.sh -n Alice
  echo "output=$output"
  [ "$status" -eq 0 ]
  [ "$output" = "Hello Alice!" ]
}
```

We now know what is wrong. The output contains the usage instead of the name.

```
✗ should output Hello Alice!
   (in test file step05-hello-round-5/hello-world-names-test.bats, line 11)
     `[ "$status" -eq 0 ]' failed
   output=Usage: hello-world.sh <name>
```

It is uncleat to me why. We want to add some verbose option and trace. Thus it's time to do this step. Debugging will become easier.

## Adding -v switch

We will focus on the following tasks

> - new tests are required for -v
> - new tests are required for -n to ensure that it works nicely with -v

Let's add a new test file named [hello-world-verbosity-test.bats](hello-world-verbosity-test.bats).

