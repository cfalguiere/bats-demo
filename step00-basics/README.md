


```
$ ../bats/bin/bats  step00-basics/basic-test.bats
 ✗ basic-script-with-error should should fail
   (in test file step00-basics/basic-test.bats, line 8)
     `$BATS_TEST_DIRNAME/basic-script-with-errors.sh' failed
   cat: foo: No such file or directory
 ✓ basic-script should succeed
 ✗ basic-script should fail
   (in test file step00-basics/basic-test.bats, line 16)
     `$BATS_TEST_DIRNAME/basic-script.sh  "foo" 1' failed
   foo
```
