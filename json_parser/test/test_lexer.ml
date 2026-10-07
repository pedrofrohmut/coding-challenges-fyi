open Json_parser

let test_lexer_step1_valid1 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step1/valid.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBrace;
    Token_type.CloseBrace;
  ] in

  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 1 valid";

  result

let test_lexer_step1_invalid1 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step1/invalid.json" in
  let lex = Lexer.create input in

  let expected_tokens = [] in

  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 1 invalid";

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
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 2 valid 1";

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
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 2 valid 2";

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
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 2 valid 3";

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
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 2 invalid";

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
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 2 invalid 2";

  result

let test_lexer_step3_valid1 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step3/valid.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBrace;
    Token_type.String; Token_type.Colon; Token_type.Bool; Token_type.Comma;
    Token_type.String; Token_type.Colon; Token_type.Bool; Token_type.Comma;
    Token_type.String; Token_type.Colon; Token_type.Null; Token_type.Comma;
    Token_type.String; Token_type.Colon; Token_type.String; Token_type.Comma;
    Token_type.String; Token_type.Colon; Token_type.Number;
    Token_type.CloseBrace;
  ] in

  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 3 valid 1";

  result

let test_lexer_step3_invalid1 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step3/invalid.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBrace;
    Token_type.String; Token_type.Colon; Token_type.Bool; Token_type.Comma;
    Token_type.String; Token_type.Colon; Token_type.Unknown; Token_type.Comma;
    Token_type.String; Token_type.Colon; Token_type.Null; Token_type.Comma;
    Token_type.String; Token_type.Colon; Token_type.String; Token_type.Comma;
    Token_type.String; Token_type.Colon; Token_type.Number;
    Token_type.CloseBrace;
  ] in

  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 3 invalid 1";

  result

let test_lexer_step3_invalid2 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step3/invalid2.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBrace;
    Token_type.String; Token_type.Colon; Token_type.Bool; Token_type.Comma;
    Token_type.String; Token_type.Colon; Token_type.Unknown; Token_type.Comma;
    Token_type.String; Token_type.Colon; Token_type.Null; Token_type.Comma;
    Token_type.String; Token_type.Colon; Token_type.String; Token_type.Comma;
    Token_type.String; Token_type.Colon; Token_type.Number;
    Token_type.CloseBrace;
  ] in

  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 3 invalid 2";

  result

let test_lexer_step4_valid1 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step4/valid.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBrace;
    Token_type.String; Token_type.Colon; Token_type.String; Token_type.Comma;
    Token_type.String; Token_type.Colon; Token_type.Number; Token_type.Comma;
    Token_type.String; Token_type.Colon; Token_type.OpenBrace; Token_type.CloseBrace; Token_type.Comma;
    Token_type.String; Token_type.Colon; Token_type.OpenBracket; Token_type.CloseBracket;
    Token_type.CloseBrace;
  ] in

  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 4 valid 1";

  result

let test_lexer_step4_valid2 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step4/valid2.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBrace;
    Token_type.String; Token_type.Colon; Token_type.String; Token_type.Comma;
    Token_type.String; Token_type.Colon; Token_type.Number; Token_type.Comma;

    Token_type.String; Token_type.Colon; Token_type.OpenBrace;
    Token_type.String; Token_type.Colon; Token_type.String;
    Token_type.CloseBrace; Token_type.Comma;

    Token_type.String; Token_type.Colon; Token_type.OpenBracket; Token_type.String; Token_type.CloseBracket;

    Token_type.CloseBrace;
  ] in

  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 4 valid 2";

  result

let test_lexer_step4_invalid1 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step4/invalid.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBrace;
    Token_type.String; Token_type.Colon; Token_type.String; Token_type.Comma;
    Token_type.String; Token_type.Colon; Token_type.Number; Token_type.Comma;

    Token_type.String; Token_type.Colon; Token_type.OpenBrace;
    Token_type.String; Token_type.Colon; Token_type.String;
    Token_type.CloseBrace; Token_type.Comma;

    Token_type.String; Token_type.Colon; Token_type.OpenBracket; Token_type.Unknown; Token_type.CloseBracket;

    Token_type.CloseBrace;
  ] in

  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 4 invalid 1";

  result

let test_lexer_step5_pass1 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/pass1.json" in
  let lex = Lexer.create input in

  let expected_tokens = Expected_tokens.pass1_tokens in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 pass 1";

  result

let test_lexer_step5_pass2 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/pass2.json" in
  let lex = Lexer.create input in

  let expected_tokens = Expected_tokens.pass2_tokens in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 pass 2";

  result

let test_lexer_step5_pass3 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/pass3.json" in
  let lex = Lexer.create input in

  let expected_tokens = Expected_tokens.pass3_tokens in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 pass 3";

  result

let run (): bool =
  let lexer_tests = [
    test_lexer_step1_valid1;
    test_lexer_step1_invalid1;

    test_lexer_step2_valid1;
    test_lexer_step2_valid2;
    test_lexer_step2_valid3;
    test_lexer_step2_invalid1;
    test_lexer_step2_invalid2;

    test_lexer_step3_valid1;
    test_lexer_step3_invalid1;
    test_lexer_step3_invalid2;

    test_lexer_step4_valid1;
    test_lexer_step4_valid2;
    test_lexer_step4_invalid1;

    test_lexer_step5_pass1;
    test_lexer_step5_pass2;
    test_lexer_step5_pass3;
  ] in

  let failed_tests = List.filter (fun test -> not (test ())) lexer_tests in

  if (List.length failed_tests) > 0 then (
    Printf.printf "Lexer failed in %d tests\n" (List.length failed_tests);
    false
  )

  else
    true
