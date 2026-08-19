# WC in ocaml

all the source code is in `wc.ml` and the the tests in the `test_runner.ml`.

You can run the tests with:

```sh
$ dune build && ./test_runner.ml
```

All you can run the code with the symlink `my_wc`

```sh
$ ./my_wc --lines test.txt
```

Or with dune with

```sh
$ dune exec ./wc.exe -- --lines test.txt
```

This code follows the challenge in (Challenge WC)[https://codingchallenges.fyi/challenges/challenge-wc/].
