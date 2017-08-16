# Bats basics

## Run bats

Les exemples sont dans [basic-test.bats](basic-test.bats)

Bats run with human-readable option

```
$ ../bats/bin/bats  step00-basics/basic-test.bats
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
```

Bats run with TAP option which is easier to use in a program
```
$ ../bats/bin/bats --tap  step00-basics/basic-test.bats
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

Les exemples sont dans [basic-test-2.bats](basic-test-2.bats)

