let show_version () =
  print_endline {|wc (GNU coreutils) 9.11
Copyright (C) 2026 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by Paul Rubin and David MacKenzie.|}
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
or available locally via: info '(coreutils) wc invocation'|}
;;

let count_bytes (file_path: string): unit =
  let in_chan = In_channel.open_bin file_path in

  let str_file = In_channel.input_all in_chan in
  close_in in_chan;

  let num_bytes = Bytes.length (Bytes.of_string str_file) in

  Printf.printf "%d %s\n" num_bytes file_path
;;

let count_lines (file_path: string): unit =
  let in_chan = In_channel.open_bin file_path in

  let lines = In_channel.input_lines in_chan in
  close_in in_chan;

  Printf.printf "%d %s\n" (List.length lines) file_path
;;

let string_to_list (source: string): char list =
  List.init (String.length source) (String.get source)
;;

let list_to_string (xs: char list): string =
  String.of_seq (List.to_seq xs)
;;

let get_words_list (source: string): string list =

  let is_separator (ch: char): bool = Char.Ascii.is_white ch in

  let acc_to_string (acc: char list): string = acc |> List.rev |> List.to_seq |> String.of_seq in

  let rec loop (acc: char list) (xs: char list): string list =
    match xs with
    | [] -> []
    | x :: [] ->
       begin
         match is_separator x, acc with
         | true, [] -> []
         | true, _ -> acc_to_string acc :: []
         | false, _ -> acc_to_string (x :: acc) :: []
       end
    | x :: xt ->
       match is_separator x, acc with
       | true, [] -> loop acc xt
       | true, _ -> acc_to_string acc :: loop [] xt
       | false, _ -> loop (x :: acc) xt
  in

  let src = string_to_list source in
  loop [] src
;;

let count_words (file_path: string): unit =
  let in_chan = In_channel.open_bin file_path in

  let str_file = In_channel.input_all in_chan in
  close_in in_chan;

  let words = get_words_list str_file in
  let count = List.length words in

  Printf.printf "%d %s\n" count file_path
;;

(**
  Character Length  |  Valid First Byte Range (hex)  |  Reason / Constraint
  -------------------------------------------------------------------------------------------------------------------------------
  1-byte (ASCII)    | 0x00 - 0x7F                    |   Standard ASCII compatibility.
  2-byte            | 0xC2 - 0xDF                    |   0xC0 and 0xC1 are invalid (overlong encoding).
  3-byte            | 0xE0 - 0xEF                    |   Followed by 0xA0-BF if 0xE0; 0x80-9F if 0xED (surrogate avoidance).
  4-byte            | 0xF0 - 0xF4                    |   0xF5 and above are invalid; 0xF0 requires 0x90-BF; 0xF4 requires 0x80-8F.
*)
let count_chars_from_string (source: string): int =
  let min_2bytes = 0xC2 in
  let min_3bytes = 0xE0 in
  let min_4bytes = 0xF0 in

  let rec loop i len src =
    if i = len then
      0
    else
      (* String.get wont return all the bytes of non-ascii characters with more than 1 byte.
         only the first byte of these characters. *)
      let code = Char.code (String.get src i) in

      (* Ajust the increment based in character length *)
      let increment =
        if code < min_2bytes then
          1
        else if code < min_3bytes then
          2
        else if code < min_4bytes then
          3
        else
          4
      in

      1 + loop (i + increment) len src
  in

  loop 0 (String.length source) source
;;

let count_chars (file_path: string): unit =
  let in_chan = In_channel.open_text file_path in

  let str_file = In_channel.input_all in_chan in
  close_in in_chan;

  let count = count_chars_from_string str_file in

  Printf.printf "%d %s\n" count file_path
;;

let count_lines_from_string (source: string): int =
  let char_list = List.init (String.length source) (fun i -> String.get source i) in
  List.fold_left (fun acc ch -> if ch = '\n' then (acc + 1) else acc) 0 char_list
;;

let count_words_from_string (source: string): int =
  List.length @@ get_words_list source
;;

let count_bytes_from_string (source: string): int =
  String.length source
;;

let count_lines_words_and_bytes (file_path: string): unit =
  let in_chan = In_channel.open_bin file_path in

  let str_file = In_channel.input_all in_chan in
  close_in in_chan;

  let lines_count = count_lines_from_string str_file in
  let words_count = count_words_from_string str_file in
  let bytes_count = count_bytes_from_string str_file in

  Printf.printf "  %d  %d %d %s\n" lines_count words_count bytes_count file_path
;;

let get_file_path (args: string array): string option =
  let arr = Array.sub args 1 (Array.length args - 1) in
  Array.find_opt (fun arg -> not (String.starts_with ~prefix:"-" arg)) arr
;;

let process_other_args (args: string array): unit =
  let rec loop i args file_path =
    let len = Array.length args in
    if i = len then
      count_lines_words_and_bytes file_path
    else
      match args.(i) with
      | "-c" | "--bytes" -> count_bytes file_path
      | "-l" | "--lines" -> count_lines file_path
      | "-w" | "--words" -> count_words file_path
      | "-m" | "--chars" -> count_chars file_path
      | _ -> loop (i + 1) args file_path
  in

  let file_path = get_file_path Sys.argv in
  if Option.is_none file_path then
    failwith "File path not provided."
  else
    loop 1 Sys.argv (Option.get file_path)
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
      process_other_args Sys.argv
;;

let () =
  main ()
