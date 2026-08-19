let get_file_path (args: string array): string option =
  let arr = Array.sub args 1 (Array.length args - 1) in
  Array.find_opt (fun arg -> not (String.starts_with ~prefix:"-" arg)) arr
;;

let get_string_from_file (file_path: string): string =
  let in_chan = In_channel.open_bin file_path in
  let file_str = In_channel.input_all in_chan in
  close_in in_chan;
  file_str
;;

let rec read_stdin () =
  try
    let line = read_line () in
    line :: read_stdin ()
  with
    End_of_file -> []
;;

let get_string_from_stdin (): string =
  let has_no_stdin = Unix.isatty Unix.stdin in
  if has_no_stdin then
    failwith "Error: No input provided"
  else
    let lines = read_stdin () in
    (String.concat "\n" lines) ^ "\n" (* Concat wont add the ending \n *)
;;

let count_bytes_from_string (source: string): int =
  (* In ocaml String.length count the bytes. Using Bytes.length would need convertion first *)
  String.length source
;;


let show_count_bytes (file_path: string option) (file_str: string): unit =
  let count = count_bytes_from_string file_str in
  let path =  (Option.value ~default:"" file_path) in

  Printf.printf "%d %s\n" count path
;;

let count_lines_from_string (source: string): int =
  let char_list = List.init (String.length source) (fun i -> String.get source i) in
  List.fold_left (fun acc ch ->
      if ch = '\n' then (acc + 1) else acc
    ) 0 char_list
;;


let show_count_lines (file_path: string option) (file_str: string): unit =
  let count = count_lines_from_string file_str in
  let path =  (Option.value ~default:"" file_path) in

  Printf.printf "%d %s\n" count path
;;

let string_to_list (source: string): char list =
  List.init (String.length source) (fun i -> String.get source i)
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

let count_words_from_string (source: string): int =
  let words = get_words_list source in
  List.length words
;;

let show_count_words (file_path: string option) (file_str: string): unit =
  let count = count_words_from_string file_str in
  let path =  (Option.value ~default:"" file_path) in

  Printf.printf "%d %s\n" count path
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

let show_count_chars (file_path: string option) (file_str: string): unit =
  let count = count_chars_from_string file_str in
  let path =  (Option.value ~default:"" file_path) in

  Printf.printf "%d %s\n" count path
;;

let show_count_lines_words_and_bytes (file_path: string option) (file_str: string): unit =
  let lines_count = count_lines_from_string file_str in
  let words_count = count_words_from_string file_str in
  let bytes_count = count_bytes_from_string file_str in
  let path =  (Option.value ~default:"" file_path) in

  Printf.printf "  %d  %d %d %s\n" lines_count words_count bytes_count path
;;

let procress_args_flags (file_path: string option) (file_str: string) (args: string array): unit =
  let rec loop i args file_str =
    if i = Array.length args then
      (* Only get here if no valid flags provided *)
      show_count_lines_words_and_bytes file_path file_str

    else
      match args.(i) with
      | "-c" | "--bytes" -> show_count_bytes file_path file_str
      | "-l" | "--lines" -> show_count_lines file_path file_str
      | "-w" | "--words" -> show_count_words file_path file_str
      | "-m" | "--chars" -> show_count_chars file_path file_str
      | _ -> loop (i + 1) args file_str
  in

  loop 1 args file_str
;;

let (): unit =
  let file_path = get_file_path Sys.argv in

  try
    let file_str =
      match file_path with
      | Some path -> get_string_from_file path
      | None -> get_string_from_stdin ()
    in

    procress_args_flags file_path file_str Sys.argv

  with
    Failure msg -> prerr_endline msg; exit 1
;;
