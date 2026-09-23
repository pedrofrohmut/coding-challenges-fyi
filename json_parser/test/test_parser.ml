open Json_parser

let test_parser_step1_valid =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step1/valid.json" in
  let lex = Lexer.create input in
  let par = Parser.create lex in
  let parsed = Parser.run par in

  let expected = Ok (Parser.Output.Object []) in

  let result = Utils_for_tests.check_parsed expected parsed in

  if not result then
    print_endline "✗ FAIL: Parser Failed at step 1 valid";

  result

let test_parser_step1_invalid =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step1/invalid.json" in
  ignore input;
  (* TODO: not implemented *)
  true

let run (): bool =
  let parser_tests = [] in

  let failed_tests = List.filter (fun test -> not (test())) parser_tests in

  (List.length failed_tests) = 0
