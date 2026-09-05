open Json_parser
open Utils

let try_get_input args =
  let len = Array.length args in

  if len = 1 then (
    Printf.eprintf "Arguments not provided for parsing.\n";
    exit 1
  )

  else if args.(1) <> "-f" then (
    print_endline "Reading input from args directly...";
    args.(1)
  )

  else if len < 3 then (
    Printf.eprintf "Not file_path provided for the input\n";
    exit 1
  )

  else (
    print_endline "Reading input from file...";
    let input = Utils.get_input_from_file args.(2) in
    input
  )

let () =
  print_endline "Starting...";

  Array.iteri (fun i a -> Printf.printf "Args[%d]: `%s`\n" i a) Sys.argv;

  let args = Sys.argv in
  let input = try_get_input args in

  let lexer = Lexer.create input in
  let par = Parser.create lexer in
  let result = Parser.parse_input par in

  if not result then (
    Printf.eprintf "Parsing error. Input is not a valid json.\n";
    exit 1
  )

  else
    Printf.printf "Parsing successfull.\n";
    exit 0
