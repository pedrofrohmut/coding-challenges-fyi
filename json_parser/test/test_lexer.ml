open Utils_for_tests

let test_lexer_step1_valid (): bool =
  let input = get_input_from_file "test/json_inputs/step1/valid.json" in
  ignore input;
  true

let test_lexer_step1_invalid (): bool =
  let input = get_input_from_file "test/json_inputs/step1/invalid.json" in
  ignore input;
  true

let run (): bool =
  let lexer_tests = [
      test_lexer_step1_valid;
      test_lexer_step1_invalid;
  ] in

  let failed_tests = List.filter (fun test -> not (test ())) lexer_tests in

  List.length failed_tests = 0
