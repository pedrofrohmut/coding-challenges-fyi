open Json_parser
open Printf

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

let check_tokens expected_tokens lex =
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

  let tokens = get_tokens lex in
  match_tokens tokens expected_tokens

let check_parsed (expected: (Parser.Output.t, string) result) (parsed: (Parser.Output.t, string) result): bool =
  match expected, parsed with
  | Error _, Ok _ | Ok _, Error _ -> false
  | Ok exp_ok, Ok par_ok -> exp_ok = par_ok
  | Error exp_err, Error par_err ->
     if exp_err <> par_err then (* Different messages is just an warn not a faling test. *)
       printf "WARN: The error messages don't match. Expected err: `%s` and parser err: `%s`\n" exp_err par_err;
     true

let rec string_of_output = function
  | Parser.Output.Null -> "null"
  | Parser.Output.Bool b -> string_of_bool b
  | Parser.Output.Number n -> string_of_float n
  | Parser.Output.String s -> Printf.sprintf "%S" s
  | Parser.Output.Array xs ->
      "[ " ^ String.concat "," (List.map string_of_output xs) ^ " ]"
  | Parser.Output.Object kvs ->
      let pair (Parser.Output.Key k, v) =
        Printf.sprintf "%S: %s" k (string_of_output v)
      in
      "{ " ^ String.concat ", " (List.map pair kvs) ^ " }"

let print_parsed = function
  | Error msg -> printf "Parsed is 'Error `%s`'\n" msg
  | Ok output -> printf "Parsed is 'Ok `%s`'\n" (string_of_output output)

let test_parser_failwith (parsed: (Parser.Output.t, string) result) (msg: string): unit =
  print_endline msg;
  print_parsed parsed

let test_lexer_failwith (input: string) (msg: string): unit =
  Lexer.print_all_tokens input;
  print_endline msg
