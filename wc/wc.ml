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
    String.concat "\n" lines
;;

let procress_args_flags (file_str: string) (args: string array): unit =
  let rec loop i args file_str =
    if i = Array.length args then
      failwith "TODO: show_count_lines_words_and_bytes file_str"
    else
      match args.(i) with
      | "-c" | "--bytes" -> failwith "TODO: show_count_bytes file_str"
      | "-l" | "--lines" -> failwith "TODO: show_count_lines file_str"
      | "-w" | "--words" -> failwith "TODO: show_count_words file_str"
      | "-m" | "--chars" -> failwith "TODO: show_count_chars file_str"
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

    print_endline file_str

  with
    Failure msg -> prerr_endline msg; exit 1

  (* procress_args_flags file_str Sys.argv *)
