# Unit testing Hello World with Bats - Round 2

Now it's OK, what additionnal tests do I need ?


<br>

## Question time

- Does it wotk for another name (just in case Alice were hardcoded) ?
- Does it wotk for composite names ?
- What do I expect when this script is called without parameter ?

I ended up with a new test file [here](hello-world-test.bats).


Let's run

```
$ bats step02-hello-round-2/hello-world-test.bats
 ✓ should output Hello Alice!
 ✓ should output Hello Jabberwock!
 ✗ should output Hello Cheshire Cat! when names has many words
   (in test file step02-hello-round-2/hello-world-test.bats, line 27)
     `[ "$output" = "Hello Cheshire Cat!" ]' failed
 ✗ should output Hello!
   (in test file step02-hello-round-2/hello-world-test.bats, line 45)
     `[ "$output" = "Hello!" ]' failed

4 tests, 2 failures
```

With a few extra traces, here what is happening

````
$ bats step02-hello-round-2/hello-world-test.bats
 ✓ should output Hello Alice!
 ✓ should output Hello Jabberwock!
 ✗ should output Hello Cheshire Cat! when names has many words
   (in test file step02-hello-round-2/hello-world-test.bats, line 28)
     `[ "$output" = "Hello Cheshire Cat!" ]' failed
   output=Hello Cheshire!
 ✗ should output Hello!
   (in test file step02-hello-round-2/hello-world-test.bats, line 47)
     `[ "$output" = "Hello!" ]' failed
   output=Hello !

```

Third test is a false negative. The test should call hello-world.sh  "Cheshire Cat" in order to pass only one parameter.

Fourth test is a true negative. As the variable is not checked, the space is always issued.
