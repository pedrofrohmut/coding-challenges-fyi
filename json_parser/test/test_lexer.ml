open Json_parser
open Utils_for_tests

let test_lexer_step1_valid (): bool =
  let input = get_input_from_file "test/json_inputs/step1/valid.json" in
  let lexer = Lexer.create input in

  let expected_tokens = [
    Token_type.OpenBrace;
    Token_type.CloseBrace;
  ] in

  let result = check_tokens expected_tokens lexer in

  if not result then
    print_endline "✗ FAIL: Lexer Failed at step 1 valid";

  result

let test_lexer_step1_invalid (): bool =
  let input = get_input_from_file "test/json_inputs/step1/invalid.json" in
  let lexer = Lexer.create input in

  let expected_tokens = [] in

  let result = check_tokens expected_tokens lexer in

  if not result then
    print_endline "✗ FAIL: Lexer Failed at step 1 invalid";

  result

let run (): bool =
  let lexer_tests = [
      test_lexer_step1_valid;
      test_lexer_step1_invalid;
  ] in

  let failed_tests = List.filter (fun test -> not (test ())) lexer_tests in

  List.length failed_tests = 0
