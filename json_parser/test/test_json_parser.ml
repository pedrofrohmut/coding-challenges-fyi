open Json_parser

let parse_input input =
  let lexer = Lexer.create input in
  let parser = Parser.create lexer in
  Parser.parse_input parser

let test_step1_valid () =
  let input = "{}" in

  let lexer = Lexer.create input in
  let parser = Parser.create lexer in
  let result = Parser.parse_input parser in

  if result then () else (
    print_endline "Error: Failed step1 valid";
    exit 1
  )

let test_step1_invalid () =
  let input = "" in

  let lexer = Lexer.create input in
  let parser = Parser.create lexer in
  let result = Parser.parse_input parser in

  if not result then () else (
    print_endline "Error: Failed step1 invalid";
    exit 1
  )

let test_step2_valid () =
  let input = "{\"key\":\"value\"}" in

  let result = parse_input input in

  if result then () else (
    print_endline "Error: Failed step2 valid";
    exit 1
  )

let () =
  test_step1_valid ();
  test_step1_invalid ();
  test_step2_valid ();
  exit 0
