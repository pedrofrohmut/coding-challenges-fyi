open Json_parser
open Printf

module Out = Parser.Output

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
    (* | Some token -> token.token_type :: get_tokens lx *)
    | Some token -> token :: get_tokens lx
  in

  let rec match_tokens (xs: Token.t list) (ys: Token_type.t list): bool =
    (* xs lexer tokens and ys expected tokens *)
    match xs, ys with
    | [], [] -> true
    | [], _ | _, [] -> (
      prerr_endline "The number of tokens doesn't match";
      false
    )
    | x :: xt, y :: yt ->
       if x.token_type <> y then (
         let y_type = Token_type.to_string y in
         let x_type = Token_type.to_string x.token_type in
         print_endline "\n################################################################################\n";
         print_endline "Match tokens error:\n";
         printf "Token_types doesn't match. Expected `%s` but got `%s` instead.\n\n" y_type x_type;
         Token.print_token x;
         print_endline "\n################################################################################\n";
         false
       )

       else
         match_tokens xt yt
  in

  let tokens = get_tokens lex in
  match_tokens tokens expected_tokens

let rec string_of_output = function
  | Parser.Output.Null -> "null"
  | Parser.Output.Bool b -> string_of_bool b
  | Parser.Output.Number n -> string_of_float n
  | Parser.Output.String s -> Printf.sprintf "`%s`" s
  | Parser.Output.Array xs ->
      "[ " ^ String.concat "," (List.map string_of_output xs) ^ " ]"
  | Parser.Output.Object kvs ->
      let pair (Parser.Output.Key k, v) =
        Printf.sprintf "%s: %s" k (string_of_output v)
      in
      "{ " ^ String.concat ", " (List.map pair kvs) ^ " }"

let rec check_parsed (expected: (Parser.Output.t, string) result) (parsed: (Parser.Output.t, string) result): bool =
  match expected, parsed with
  | Error msg, Ok _ -> print_endline "Expected parsed to be an Error but got a valid output instead."; false
  | Ok _, Error _ -> print_endline "Expected parsed to be a valid output but got a Error instead."; false
  | Error exp_err, Error par_err ->
     if exp_err <> par_err then
       (* Different messages is just an warn not a faling test. *)
       printf "WARN: The error messages don't match. Expected err: `%s` and parser err: `%s`\n" exp_err par_err; true
  | Ok exp_out, Ok par_out ->
     if exp_out = par_out then true else (
       print_string "Output doesn't match. ";
       match exp_out, par_out with
       | Array exps, Array pars -> List.iter2 match_values exps pars; false
       | Object exps, Object pars -> List.iter2 match_pairs exps pars; false
       | _ -> failwith "Invalid output to match. Only support arrays and objects."
     )

and match_values (exp_val: Parser.Output.t) (par_val: Parser.Output.t): unit =
  if exp_val = par_val then () else (
    let par_str = string_of_output par_val in
    match exp_val, par_val with
    | Out.Null, _ -> printf "Expected `Output.Null` but got `%s` instead.\n" par_str
    | Out.Bool b, Out.Bool _ -> printf "Expected `Output.Bool %s` but got `Output.Bool %s` instead.\n" (string_of_bool b) par_str
    | Out.Number n, Out.Number _ -> printf "Expected `Output.Number %s` but got `Output.Number %s` instead.\n" (string_of_float n) par_str
    | Out.String s, Out.String s2 -> printf "Expected `Output.String \"%s\"` but got `Output.String \"%s\"` instead.\n" s s2
    | Out.Array exps, Out.Array pars -> List.iter2 match_values exps pars
    | Out.Object exps, Out.Object pars -> List.iter2 match_pairs exps pars
    | _ -> printf "Expected output kind of `%s` but got `%s` instead.\n" (Out.kind exp_val) (Out.kind par_val)
  )

and match_pairs (exp_pair: Parser.Output.key * Parser.Output.t) (par_pair: Parser.Output.key * Parser.Output.t): unit =
  if exp_pair = par_pair then () else (
    let exp_key, exp_val = exp_pair in
    let par_key, par_val = par_pair in
    if exp_key <> par_key then
      printf "Expected object key to be `%s` but got `%s` instead.\n"
        (Parser.Output.string_of_key exp_key) (Parser.Output.string_of_key par_key);

    if exp_val = par_val then () else
      match_values exp_val par_val
  )

let print_parsed = function
  | Error msg -> printf "Parsed is 'Error `%s`'\n" msg
  | Ok output -> printf "Parsed is 'Ok `%s`'\n" (string_of_output output)

let test_parser_failwith (parsed: (Parser.Output.t, string) result) (msg: string): unit =
  print_endline msg;
  print_parsed parsed

let test_lexer_failwith (input: string) (msg: string): unit =
  Lexer.print_all_tokens input;
  print_endline msg
