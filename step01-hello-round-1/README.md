# Unit testing Hello World with Bats

Let's start with a very common scenario and build it with an Agile process

## Specification Round 1

- The script must output Hello x! where x stand for the name given as a parameter


### **_Let's write the test_**

A test transcription of the specification might be

````
# file hello-world-test.bats
#!/usr/bin/env bats
@test "should output Hello Alice!" {
  run $BATS_TEST_DIRNAME/hello-world.sh  Alice
  [ "$status" -eq 0 ]
  [ "$output" = "Hello Alice!" ]
}
````


First thinks first, whats is $BATS_TEST_DIRNAME ?

$BATS_TEST_DIRNAME is one of the environment variables provided by Bats

As I run the test from the home of the project, the script is not in the current directory.
I need to provide the path to the script under test. As the script and the test lies in the same folder, I can use the path of the test directory as the path to the script.


Whenever the test is not in the same directory as the test (for instance you run some integration tests that lies somewhere else) you may either hardcode the path or set an environment variable before the test call.

For instance, use a variable SUT_DIRNAME

````
# file hello-world-test.bats
#!/usr/bin/env bats
@test "should output Hello Alice!" {
  run $SUT_DIRNAME/hello-world.sh  Alice
  ...
}
````

and set it before the test is called

````
$ export SUT_DIRNAME=...
$ bats  step01-hello-round-1/hello-world-test.bats
````


### **_Running the test_**

Now check what happen

````
$ bats  step01-hello-round-1/hello-world-test.bats
 ✗ should output Hello Alice!
   (in test file step01-hello-round-1/hello-world-test.bats, line 10)
     `[ "$status" -eq 0 ]' failed

1 test, 1 failure
````


### **_What's wrong with the test ?_**

This is a pretty common situation.

Bats is great when it comes to run a test suite again and again. However, debugging is not so easy.

Here are some stategies that helps debugging

### %%_add traces_**

Add prints of the output to the test

```
@test "should output Hello Alice!" {
  run $BATS_TEST_DIRNAME/hello-world.sh  Alice
  echo "status=$status"
  echo "output=$output"
  [ "$status" -eq 0 ]
  [ "$output" = "Hello Alice!" ]
}
```

For whatever reason Bats sometimes does not output errors

````
$ bats step01-hello-round-1/hello-world-test.bats
 ✗ should output Hello Alice!
   (in test file step01-hello-round-1/hello-world-test.bats, line 18)
     `[ "$status" -eq 0 ]' failed
   status=127
   output=/home/cfalguiere/projects/batsTest/bats/libexec/bats-exec-test: line 58: /home/cfalguiere/projects/batsTest/bats-demo/step01-hello-round-1/hello-world.sh: No such file or directory

1 test, 1 failure
````


