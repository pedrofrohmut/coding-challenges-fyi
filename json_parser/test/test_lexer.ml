open Json_parser

let test_lexer_step1_valid (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step1/valid.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBrace;
    Token_type.CloseBrace;
  ] in

  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    print_endline "✗ FAIL: Lexer Failed at step 1 valid";

  result

let test_lexer_step1_invalid (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step1/invalid.json" in
  let lex = Lexer.create input in

  let expected_tokens = [] in

  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    print_endline "✗ FAIL: Lexer Failed at step 1 invalid";

  result

let test_lexer_step2_valid1 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step2/valid.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBrace;
    Token_type.String;
    Token_type.Colon;
    Token_type.String;
    Token_type.CloseBrace;
  ] in

  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    print_endline "✗ FAIL: Lexer Failed at step 2 valid 1";

  result

let test_lexer_step2_valid2 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step2/valid2.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBrace;
    Token_type.String; Token_type.Colon; Token_type.String; Token_type.Comma;
    Token_type.String; Token_type.Colon; Token_type.String;
    Token_type.CloseBrace;
  ] in

  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    print_endline "✗ FAIL: Lexer Failed at step 2 valid 2";

  result

let test_lexer_step2_valid3 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step2/valid3.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBrace;
    Token_type.String; Token_type.Colon; Token_type.String; Token_type.Comma;
    Token_type.String; Token_type.Colon; Token_type.String; Token_type.Comma;
    Token_type.String; Token_type.Colon; Token_type.String; Token_type.Comma;
    Token_type.String; Token_type.Colon; Token_type.String; Token_type.Comma;
    Token_type.String; Token_type.Colon; Token_type.String;
    Token_type.CloseBrace;
  ] in

  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    print_endline "✗ FAIL: Lexer Failed at step 2 valid 3";

  (* Lexer.print_all_tokens input; *)
  result

let test_lexer_step2_invalid1 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step2/invalid.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBrace;
    Token_type.String; Token_type.Colon; Token_type.String; Token_type.Comma;
    Token_type.CloseBrace;
  ] in

  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    print_endline "✗ FAIL: Lexer Failed at step 2 invalid";

  result

let test_lexer_step2_invalid2 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step2/invalid2.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBrace;
    Token_type.String; Token_type.Colon; Token_type.String; Token_type.Comma;
    Token_type.Unknown; Token_type.Colon; Token_type.String;
    Token_type.CloseBrace;
  ] in

  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    print_endline "✗ FAIL: Lexer Failed at step 2 invalid 2";

  result

let run (): bool =
  let lexer_tests = [
      test_lexer_step1_valid;
      test_lexer_step1_invalid;
      test_lexer_step2_valid1;
      test_lexer_step2_valid2;
      test_lexer_step2_valid3;
      test_lexer_step2_invalid1;
      test_lexer_step2_invalid2;
  ] in

  let failed_tests = List.filter (fun test -> not (test ())) lexer_tests in

  if (List.length failed_tests) > 0 then (
    Printf.printf "Lexer failed in %d tests\n" (List.length failed_tests);
    false
  )

  else
    true
