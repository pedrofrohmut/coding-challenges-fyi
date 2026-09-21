open Json_parser

let prefix_path file_path =
  let cwd = Sys.getcwd () in
  let res = Utils.split_string "_build" cwd in

  if Option.is_none res then (
    prerr_endline "ERROR: Invalid cwd. Cwd does not contain the _build folder. This function won't know where to split the path.";
    failwith "Invalid cwd"
  )

  else
    let prefix, _ = Option.get res in
    prefix ^ file_path

let get_input_from_file file_path =
  if String.starts_with ~prefix:"/" file_path then (
    prerr_endline "ERROR: Invalid file path. File path must not start with a slash";
    failwith "Invalid file path"
  );

  if String.starts_with ~prefix:"." file_path then (
    prerr_endline "ERROR: Invalid file path. Relative paths are not supported";
    failwith "Invalid file path"
  );

  let full_path = prefix_path file_path in
  (* Printf.printf "Full path -> `%s`\n" full_path; *)

  if not (Sys.file_exists full_path) then (
    prerr_endline "ERROR: File not found. File path will be prefixed with the `<project root>/`. Make sure to follow this pattern";
    failwith "Input file not found"
  );

  let in_chan = open_in full_path in
  let file_str = In_channel.input_all in_chan in
  close_in in_chan;

  file_str

let check_tokens expected_tokens lexer =
  let rec get_tokens lx =
    let lx, token = Lexer.next_token lx in
    match token with
    | None -> []
    | Some token -> token.token_type :: get_tokens lx
  in

  let rec match_tokens xs ys =
    (* xs lexer tokens and ys expected tokens *)
    match xs, ys with
    | [], [] -> true
    | [], _ | _, [] -> (
      prerr_endline "The number of tokens doesn't match";
      false
    )
    | x :: xt, y :: yt ->
       if x <> y then (
         let y = Token_type.to_string y in
         let x = Token_type.to_string x in
         Printf.printf "Token_types doesn't match. Expected `%s` but got `%s` instead.\n" y x;
         false
       )
       else
         match_tokens xt yt
  in

  let tokens = get_tokens lexer in
  match_tokens tokens expected_tokens
