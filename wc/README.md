# WC in OCaml

All source code is located in `wc.ml` and the the end-to-end tests are in `test_runner.ml`.

Build with:

```sh
$ dune build
```

Run the tests with:

```sh
$ ./test_runner.ml
```

You can run the code with the symlink `my_wc`:

```sh
$ ./my_wc --lines test.txt
```

Run with Dune:

```sh
$ dune exec ./wc.exe -- --lines test.txt
```

This code follows the challenge in [Challenge WC](https://codingchallenges.fyi/challenges/challenge-wc/).

Note: all code was tested on Arch Linux, in Zsh, with Opam installed via pacman
(Arch package manager), and with `eval "$(opam env)"` in `.zshrc` (Zsh config file).
