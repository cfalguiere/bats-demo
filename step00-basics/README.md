# Bats basics

## Run bats

This section shows basis use of bats.

Example tests and scripts lies in  [basic-test.bats](basic-test.bats)

The bats test run 3 sample scripts

- simple-script echoes the first parameter and exits with the second parameter
- simple-script-with-errors makes an attempt to use a non existant file
- simple-script-with-stderr prints bar on stderr
- simple-script-with-multiple-lines print two lines consisting of foo and bar

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

4 tests, 2 failures
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

In this section, you will learn how to check the exit code and output.

Example tests and scripts lies in  [basic-test-2.bats](basic-test-2.bats)

````
$ ../bats/bin/bats step00-basics/basic-test-2.bats
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
