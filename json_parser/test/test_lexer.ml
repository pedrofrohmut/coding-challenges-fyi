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

let test_lexer_step5_fail13 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail13.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBrace;
    Token_type.String;
    Token_type.Colon;
    Token_type.Number;
    Token_type.CloseBrace;
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 13";

  result

let test_lexer_step5_fail14 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail14.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBrace;
    Token_type.String;
    Token_type.Colon;
    Token_type.Number;
    Token_type.CloseBrace;
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 14";

  result

let test_lexer_step5_fail15 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail15.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBracket;
    Token_type.String;
    Token_type.CloseBracket;
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 15";

  result

let test_lexer_step5_fail16 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail16.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBracket;
    Token_type.Unknown;
    Token_type.CloseBracket;
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 16";

  result

let test_lexer_step5_fail17 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail17.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBracket;
    Token_type.String;
    Token_type.CloseBracket;
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 17";

  result

let test_lexer_step5_fail18 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail18.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBracket;  (* 1 *)
    Token_type.OpenBracket;  (* 2 *)
    Token_type.OpenBracket;  (* 3 *)
    Token_type.OpenBracket;  (* 4 *)
    Token_type.OpenBracket;  (* 5 *)
    Token_type.OpenBracket;  (* 6 *)
    Token_type.OpenBracket;  (* 7 *)
    Token_type.OpenBracket;  (* 8 *)
    Token_type.OpenBracket;  (* 9 *)
    Token_type.OpenBracket;  (* 10 *)
    Token_type.OpenBracket;  (* 11 *)
    Token_type.OpenBracket;  (* 12 *)
    Token_type.OpenBracket;  (* 13 *)
    Token_type.OpenBracket;  (* 14 *)
    Token_type.OpenBracket;  (* 15 *)
    Token_type.OpenBracket;  (* 16 *)
    Token_type.OpenBracket;  (* 17 *)
    Token_type.OpenBracket;  (* 18 *)
    Token_type.OpenBracket;  (* 19 *)
    Token_type.OpenBracket;  (* 20 *)
    Token_type.String;
    Token_type.CloseBracket; (* 1 *)
    Token_type.CloseBracket; (* 2 *)
    Token_type.CloseBracket; (* 3 *)
    Token_type.CloseBracket; (* 4 *)
    Token_type.CloseBracket; (* 5 *)
    Token_type.CloseBracket; (* 6 *)
    Token_type.CloseBracket; (* 7 *)
    Token_type.CloseBracket; (* 8 *)
    Token_type.CloseBracket; (* 9 *)
    Token_type.CloseBracket; (* 10 *)
    Token_type.CloseBracket; (* 11 *)
    Token_type.CloseBracket; (* 12 *)
    Token_type.CloseBracket; (* 13 *)
    Token_type.CloseBracket; (* 14 *)
    Token_type.CloseBracket; (* 15 *)
    Token_type.CloseBracket; (* 16 *)
    Token_type.CloseBracket; (* 17 *)
    Token_type.CloseBracket; (* 18 *)
    Token_type.CloseBracket; (* 19 *)
    Token_type.CloseBracket; (* 20 *)
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 18";

  result

let test_lexer_step5_fail19 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail19.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBrace;
    Token_type.String;
    Token_type.Null;
    Token_type.CloseBrace;
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 19";

  result

let test_lexer_step5_fail20 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail20.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBrace;
    Token_type.String;
    Token_type.Colon;
    Token_type.Colon;
    Token_type.Null;
    Token_type.CloseBrace;
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 20";

  result

let test_lexer_step5_fail21 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail21.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBrace;
    Token_type.String;
    Token_type.Comma;
    Token_type.Null;
    Token_type.CloseBrace;
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 21";

  result

let test_lexer_step5_fail22 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail22.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBracket;
    Token_type.String;
    Token_type.Colon;
    Token_type.Bool;
    Token_type.CloseBracket;
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 22";

  result

let test_lexer_step5_fail23 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail23.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBracket;
    Token_type.String;
    Token_type.Comma;
    Token_type.Unknown;
    Token_type.CloseBracket;
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 23";

  result

let test_lexer_step5_fail24 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail24.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBracket;
    Token_type.Unknown;
    Token_type.CloseBracket;
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 24";

  result

let test_lexer_step5_fail25 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail25.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBracket;
    Token_type.String;
    Token_type.CloseBracket;
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 25";

  result

let test_lexer_step5_fail26 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail26.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBracket;
    Token_type.String;
    Token_type.CloseBracket;
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 26";

  result

let test_lexer_step5_fail27 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail27.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBracket;
    Token_type.String;
    Token_type.CloseBracket;
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 27";

  result

let test_lexer_step5_fail28 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail28.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBracket;
    Token_type.String;
    Token_type.CloseBracket;
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 28";

  result

let test_lexer_step5_fail29 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail29.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBracket;
    Token_type.Unknown;
    Token_type.CloseBracket;
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 29";

  result

let test_lexer_step5_fail30 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail30.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBracket;
    Token_type.Unknown;
    Token_type.CloseBracket;
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 30";

  result

let test_lexer_step5_fail31 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail31.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBracket;
    Token_type.Unknown;
    Token_type.CloseBracket;
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 31";

  result

let test_lexer_step5_fail32 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail32.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBrace;
    Token_type.String;
    Token_type.Colon;
    Token_type.Bool;
    Token_type.Comma;
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 32";

  result

let test_lexer_step5_fail33 (): bool =
  let input = Utils_for_tests.get_input_from_file "test/json_inputs/step5/fail33.json" in
  let lex = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBracket;
    Token_type.String;
    Token_type.CloseBrace;
  ] in
  let result = Utils_for_tests.check_tokens expected_tokens lex in

  if not result then
    Utils_for_tests.test_lexer_failwith input "✗ FAIL: Lexer Failed at step 5 fail 33";

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
    test_lexer_step5_fail13;
    test_lexer_step5_fail14;
    test_lexer_step5_fail15;
    test_lexer_step5_fail16;
    test_lexer_step5_fail17;
    test_lexer_step5_fail18;
    test_lexer_step5_fail19;
    test_lexer_step5_fail20;
    test_lexer_step5_fail21;
    test_lexer_step5_fail22;
    test_lexer_step5_fail23;
    test_lexer_step5_fail24;
    test_lexer_step5_fail25;
    test_lexer_step5_fail26;
    test_lexer_step5_fail27;
    test_lexer_step5_fail28;
    test_lexer_step5_fail29;
    test_lexer_step5_fail30;
    test_lexer_step5_fail31;
    test_lexer_step5_fail32;
    test_lexer_step5_fail33;
  ] in

  let failed_tests = List.filter (fun test -> not (test ())) lexer_tests in

  if (List.length failed_tests) > 0 then (
    Printf.printf "Lexer failed in %d tests\n" (List.length failed_tests);
    false
  )

  else
    true
