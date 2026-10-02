open Json_parser

module Out = Parser.Output

let test_parser_step1_valid1 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step1/valid.json" in
  let lex = Lexer.create input in
  let par = Parser.create lex in
  let parsed = Parser.run par in

  let expected = Ok (Parser.Output.Object []) in

  let result = Utils_for_tests.check_parsed expected parsed in

  if not result then
    Utils_for_tests.test_parser_failwith parsed "✗ FAIL: Parser Failed at step 1 valid";

  result

let test_parser_step1_invalid1 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step1/invalid.json" in
  let lex = Lexer.create input in
  let par = Parser.create lex in
  let parsed = Parser.run par in

  let expected = Error "Empty json" in

  let result = Utils_for_tests.check_parsed expected parsed in

  if not result then
    Utils_for_tests.test_parser_failwith parsed "✗ FAIL: Parser Failed at step 1 invalid";

  result

let test_parser_step2_valid1 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step2/valid.json" in
  let lex = Lexer.create input in
  let par = Parser.create lex in
  let parsed = Parser.run par in

  let output = Parser.Output.Object [ Parser.Output.Key "key", Parser.Output.String "value" ] in
  let expected = Ok output  in

  let result = Utils_for_tests.check_parsed expected parsed in

  if not result then
    Utils_for_tests.test_parser_failwith parsed "✗ FAIL: Parser Failed at step 2 valid 1";

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
    Utils_for_tests.test_parser_failwith parsed "✗ FAIL: Parser Failed at step 2 valid 2";

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
    Utils_for_tests.test_parser_failwith parsed "✗ FAIL: Parser Failed at step 2 valid 3";

  result

let test_parser_step2_invalid1 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step2/invalid.json" in
  let lex = Lexer.create input in
  let par = Parser.create lex in
  let parsed = Parser.run par in

  let expected = Error "Expected String token for the object key but got `CloseBrace` instead." in

  let result = Utils_for_tests.check_parsed expected parsed in

  if not result then
    Utils_for_tests.test_parser_failwith parsed "✗ FAIL: Parser Failed at step 2 invalid 1";

  result

let test_parser_step2_invalid2 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step2/invalid2.json" in
  let lex = Lexer.create input in
  let par = Parser.create lex in
  let parsed = Parser.run par in

  let expected = Error "Expected String token for the object key but got `Unknown` instead." in

  let result = Utils_for_tests.check_parsed expected parsed in

  if not result then
    Utils_for_tests.test_parser_failwith parsed "✗ FAIL: Parser Failed at step 2 invalid 2";

  result

let test_parser_step3_valid1 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step3/valid.json" in
  let lex = Lexer.create input in
  let par = Parser.create lex in
  let parsed = Parser.run par in

  let output = Out.Object [
    Out.Key "key1", Out.Bool true;
    Out.Key "key2", Out.Bool false;
    Out.Key "key3", Out.Null;
    Out.Key "key4", Out.String "value";
    Out.Key "key5", Out.Number 101.0;
  ] in
  let expected = Ok output in

  let result = Utils_for_tests.check_parsed expected parsed in

  if not result then
    Utils_for_tests.test_parser_failwith parsed "✗ FAIL: Parser Failed at step 3 valid 1";

  result

let test_parser_step3_invalid1 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step3/invalid.json" in
  let lex = Lexer.create input in
  let par = Parser.create lex in
  let parsed = Parser.run par in

  let expected = Error "Unsupported or invalid token type for object value. Got a token of `Unknown` with value `False` while trying to parse a value." in

  let result = Utils_for_tests.check_parsed expected parsed in

  if not result then
    Utils_for_tests.test_parser_failwith parsed "✗ FAIL: Parser Failed at step 3 invalid 1";

  result

let test_parser_step3_invalid2 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step3/invalid2.json" in
  let lex = Lexer.create input in
  let par = Parser.create lex in
  let parsed = Parser.run par in

  let expected = Error "Unsupported or invalid token type for object value. Got a token of `Unknown` with value `T` while trying to parse a value." in

  let result = Utils_for_tests.check_parsed expected parsed in

  if not result then
    Utils_for_tests.test_parser_failwith parsed "✗ FAIL: Parser Failed at step 3 invalid 2";

  result

let run (): bool =
  let parser_tests = [
    test_parser_step1_valid1;
    test_parser_step1_invalid1;

    test_parser_step2_valid1;
    test_parser_step2_valid2;
    test_parser_step2_valid3;
    test_parser_step2_invalid1;
    test_parser_step2_invalid2;

    test_parser_step3_valid1;
    test_parser_step3_invalid1;
    test_parser_step3_invalid2;
  ] in

  let failed_tests = List.filter (fun test -> not (test())) parser_tests in

  if (List.length failed_tests) > 0 then (
    Printf.printf "Parser failed in %d tests\n" (List.length failed_tests);
    false
  )

  else
    true
