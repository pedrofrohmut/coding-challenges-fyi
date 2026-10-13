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

  (* Lexer.print_all_tokens input; *)

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

let test_lexer_step5_fail1 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail1.json" in
  let lex = Lexer.create input in

  (* let expected_tokens = Expected_tokens.pass3_tokens in *)
  let expected_tokens = [ Token_type.String ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 1";

  result

let test_lexer_step5_fail2 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail2.json" in
  let lex = Lexer.create input in

  let expected_tokens = [ Token_type.OpenBracket; Token_type.String ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 2";

  result

let test_lexer_step5_fail3 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail3.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBrace;
    Token_type.Unknown; Token_type.Colon; Token_type.String;
    Token_type.CloseBrace;
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 3";

  result

let test_lexer_step5_fail4 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail4.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBracket;
    Token_type.String; Token_type.Comma;
    Token_type.CloseBracket;
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 4";

  result

let test_lexer_step5_fail5 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail5.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBracket;
    Token_type.String; Token_type.Comma; Token_type.Comma;
    Token_type.CloseBracket;
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 5";

  result

let test_lexer_step5_fail6 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail6.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBracket;
    Token_type.Comma;
    Token_type.String;
    Token_type.CloseBracket;
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 6";

  result

let test_lexer_step5_fail7 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail7.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBracket;
    Token_type.String;
    Token_type.CloseBracket;
    Token_type.Comma;
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 7";

  result

let test_lexer_step5_fail8 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail8.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBracket;
    Token_type.String;
    Token_type.CloseBracket;
    Token_type.CloseBracket;
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 8";

  result

let test_lexer_step5_fail9 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail9.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBrace;
    Token_type.String;
    Token_type.Colon;
    Token_type.Bool;
    Token_type.Comma;
    Token_type.CloseBrace;
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 9";

  result

let test_lexer_step5_fail10 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail10.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBrace;
    Token_type.String;
    Token_type.Colon;
    Token_type.Bool;
    Token_type.CloseBrace;
    Token_type.String;
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 10";

  result

let test_lexer_step5_fail11 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail11.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBrace;
    Token_type.String;
    Token_type.Colon;
    Token_type.Unknown;
    Token_type.CloseBrace;
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 11";

  result

let test_lexer_step5_fail12 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail12.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBrace;
    Token_type.String;
    Token_type.Colon;
    Token_type.Unknown;
    Token_type.CloseBrace;
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 12";

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

    test_lexer_step5_fail1;
    test_lexer_step5_fail2;
    test_lexer_step5_fail3;
    test_lexer_step5_fail4;
    test_lexer_step5_fail5;
    test_lexer_step5_fail6;
    test_lexer_step5_fail7;
    test_lexer_step5_fail8;
    test_lexer_step5_fail9;
    test_lexer_step5_fail10;
    test_lexer_step5_fail11;
    test_lexer_step5_fail12;
  ] in

  let failed_tests = List.filter (fun test -> not (test ())) lexer_tests in

  if (List.length failed_tests) > 0 then (
    Printf.printf "Lexer failed in %d tests\n" (List.length failed_tests);
    false
  )

  else
    true
