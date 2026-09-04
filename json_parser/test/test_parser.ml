open Json_parser
open Test_utils
open Printf

let test_parser_step1_valid () =
  let input = get_input_from_file "test/json_inputs/step1/valid.json" in

  let result = parse_input input in

  if result then () else (
    print_endline "✗ FAIL: Parser Failed step1 valid";
    exit 1
  )

let test_parser_step1_invalid () =
  let input = get_input_from_file "test/json_inputs/step1/invalid.json" in

  let result = parse_input input in

  if not result then () else (
    print_endline "✗ FAIL: Parser Failed step1 invalid";
    exit 1
  )

let test_parser_step2_valid () =
  let input = get_input_from_file "test/json_inputs/step2/valid.json" in

  let result = parse_input input in

  if result then () else (
    print_endline "✗ FAIL: Parser Failed step2 valid";
    exit 1
  )

let test_parser_step2_valid2 () =
  let input = get_input_from_file "test/json_inputs/step2/valid2.json" in

  let result = parse_input input in

  if result then () else (
    print_endline "✗ FAIL: Parser Failed step2 valid2";
    exit 1
  )

let test_parser_step2_valid3 () =
  let input = get_input_from_file "test/json_inputs/step2/valid3.json" in

  let result = parse_input input in

  if result then () else (
    print_endline "✗ FAIL: Parser Failed step2 valid3";
    exit 1
  )

let test_parser_step2_invalid () =
  let input = get_input_from_file "test/json_inputs/step2/invalid.json" in

  let result = parse_input input in

  if not result then () else (
    print_endline "✗ FAIL: Parser Failed step2 invalid";
    exit 1
  )

let test_parser_step2_invalid2 () =
  let input = get_input_from_file "test/json_inputs/step2/invalid2.json" in

  let result = parse_input input in

  if not result then () else (
    print_endline "✗ FAIL: Parser Failed step2 invalid2";
    exit 1
  )

let test_parser_step3_valid () =
  let input = get_input_from_file "test/json_inputs/step3/valid.json" in

  let result = parse_input input in

  if result then () else (
    print_endline "✗ FAIL: Parser Failed step3 valid";
    exit 1
  )

let test_parser_step3_invalid () =
  let input = get_input_from_file "test/json_inputs/step3/invalid.json" in

  let result = parse_input input in

  if not result then () else (
    print_endline "✗ FAIL: Parser Failed step3 invalid";
    exit 1
  )

let run () =
  test_parser_step1_valid ();
  test_parser_step1_invalid ();

  test_parser_step2_valid ();
  test_parser_step2_valid2 ();
  test_parser_step2_valid3 ();
  test_parser_step2_invalid ();
  test_parser_step2_invalid2 ();

  test_parser_step3_valid ();
  test_parser_step3_invalid ();

  print_endline "✓ SUCCESS: All Parser tests passed."
