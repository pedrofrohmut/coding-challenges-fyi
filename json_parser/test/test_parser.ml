open Json_parser

let test_parser_step1_valid (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step1/valid.json" in
  let lex = Lexer.create input in
  let par = Parser.create lex in
  let parsed = Parser.run par in

  let expected = Ok (Parser.Output.Object []) in

  let result = Utils_for_tests.check_parsed expected parsed in

  if not result then
    print_endline "✗ FAIL: Parser Failed at step 1 valid";

  result

let test_parser_step1_invalid (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step1/invalid.json" in
  let lex = Lexer.create input in
  let par = Parser.create lex in
  let parsed = Parser.run par in

  let expected = Error "Empty json" in

  let result = Utils_for_tests.check_parsed expected parsed in

  if not result then
    print_endline "✗ FAIL: Parser Failed at step 1 invalid";

  result

let run (): bool =
  let parser_tests = [
    test_parser_step1_valid;
    test_parser_step1_invalid;
  ] in

  let failed_tests = List.filter (fun test -> not (test())) parser_tests in

  if (List.length failed_tests) > 0 then (
    Printf.printf "Parser failed in %d tests\n" (List.length failed_tests);
    false
  )

  else
    true
