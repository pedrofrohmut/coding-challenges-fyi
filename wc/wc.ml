let show_version () =
  print_endline {|wc (GNU coreutils) 9.11
Copyright (C) 2026 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by Paul Rubin and David MacKenzie.

|}
;;

let show_help () =
  print_endline {|Usage: wc [OPTION]... [FILE]...
  or:  wc [OPTION]... --files0-from=F
Print newline, word, and byte counts for each FILE, and a total line if
more than one FILE is specified.  A word is a nonempty sequence of non white
space delimited by white space characters or by start or end of input.

With no FILE, or when FILE is -, read standard input.

The options below may be used to select which counts are printed, always in
the following order: newline, word, character, byte, maximum line length.
  -c, --bytes
         print the byte counts
  -m, --chars
         print the character counts
  -l, --lines
         print the newline counts
      --debug
         indicate what line count acceleration is used
      --files0-from=F
         read input from the files specified by
         NUL-terminated names in file F;
         If F is -, read names from standard input
  -L, --max-line-length
         print the maximum display width
  -w, --words
         print the word counts
      --total=WHEN
         when to print a line with total counts;
         WHEN can be: auto, always, only, never
      --help
         display this help and exit
      --version
         output version information and exit

Report bugs to: bug-coreutils@gnu.org
GNU coreutils home page: <https://www.gnu.org/software/coreutils/>
General help using GNU software: <https://www.gnu.org/gethelp/>
Full documentation <https://www.gnu.org/software/coreutils/wc>
or available locally via: info '(coreutils) wc invocation'

|}
;;

let main () =
  let len = Array.length Sys.argv in
  let no_args = 1 in

  if len = no_args then
    failwith "Not implemented: no args";

  let help_found = Array.find_opt (fun x -> x = "-h" || x = "--help") Sys.argv in
  if Option.is_some help_found then
    show_help ()

  else
    let version_found = Array.find_opt (fun x -> x = "-v" || x = "--version") Sys.argv in
    if Option.is_some version_found then
      show_version ()

    else
      failwith "Not implemented: other args"
;;

let () =
  main ()
