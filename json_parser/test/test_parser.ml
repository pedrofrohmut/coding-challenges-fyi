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

let test_parser_step2_valid (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step2/valid.json" in
  let lex = Lexer.create input in
  let par = Parser.create lex in
  let parsed = Parser.run par in

  let output = Parser.Output.Object [ Parser.Output.Key "key", Parser.Output.String "value" ] in
  let expected = Ok output  in

  let result = Utils_for_tests.check_parsed expected parsed in

  if not result then
    print_endline "✗ FAIL: Parser Failed at step 2 valid 1";

  result

let test_parser_step2_valid2 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step2/valid2.json" in
  let lex = Lexer.create input in
  let par = Parser.create lex in
  let parsed = Parser.run par in

  let output = Parser.Output.Object [
    Parser.Output.Key "key", Parser.Output.String "value";
    Parser.Output.Key "key2", Parser.Output.String "value";
  ] in
  let expected = Ok output  in

  let result = Utils_for_tests.check_parsed expected parsed in

  if not result then
    print_endline "✗ FAIL: Parser Failed at step 2 valid 2";

  result

let test_parser_step2_valid3 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step2/valid3.json" in
  let lex = Lexer.create input in
  let par = Parser.create lex in
  let parsed = Parser.run par in

  let output = Parser.Output.Object [
    Parser.Output.Key "key", Parser.Output.String "value";
    Parser.Output.Key "key2", Parser.Output.String "value";
    Parser.Output.Key "key3", Parser.Output.String "value";
    Parser.Output.Key "key4", Parser.Output.String "value";
    Parser.Output.Key "key5", Parser.Output.String "value";
  ] in
  let expected = Ok output  in

  let result = Utils_for_tests.check_parsed expected parsed in

  if not result then
    print_endline "✗ FAIL: Parser Failed at step 2 valid 3";

  result

let test_parser_step2_invalid (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step2/invalid.json" in
  let lex = Lexer.create input in
  let par = Parser.create lex in
  let parsed = Parser.run par in

  let expected = Error "Expected String token for the object key but got `CloseBrace` instead." in

  let result = Utils_for_tests.check_parsed expected parsed in

  if not result then
    print_endline "✗ FAIL: Parser Failed at step 2 invalid 1";

  result

let test_parser_step2_invalid2 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step2/invalid2.json" in
  let lex = Lexer.create input in
  let par = Parser.create lex in
  let parsed = Parser.run par in

  let expected = Error "Expected String token for the object key but got `Unknown` instead." in

  let result = Utils_for_tests.check_parsed expected parsed in

  if not result then
    print_endline "✗ FAIL: Parser Failed at step 2 invalid 2";

  result

let run (): bool =
  let parser_tests = [
    test_parser_step1_valid;
    test_parser_step1_invalid;
    test_parser_step2_valid;
    test_parser_step2_valid2;
    test_parser_step2_valid3;
    test_parser_step2_invalid;
    test_parser_step2_invalid2;
  ] in

  let failed_tests = List.filter (fun test -> not (test())) parser_tests in

  if (List.length failed_tests) > 0 then (
    Printf.printf "Parser failed in %d tests\n" (List.length failed_tests);
    false
  )

  else
    true
