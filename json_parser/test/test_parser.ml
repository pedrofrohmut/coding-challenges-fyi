open Json_parser
open Test_utils
open Printf

let test_parser_step1_valid () =
  let input = get_input_from_file "test/json_inputs/step1/valid.json" in
  (* printf "Input -> `%s`\n" input; *)

  let result = parse_input input in

  if result then () else (
    print_endline "✗ FAIL: Failed step1 valid";
    exit 1
  )

let test_parser_step1_invalid () =
  let input = get_input_from_file "test/json_inputs/step1/invalid.json" in
  (* printf "Input -> `%s`\n" input; *)

  let result = parse_input input in

  if not result then () else (
    print_endline "✗ FAIL: Failed step1 invalid";
    exit 1
  )

let test_parser_step2_valid () =
  let input = get_input_from_file "test/json_inputs/step2/valid.json" in
  (* printf "Input -> `%s`\n" input; *)

  let result = parse_input input in

  if result then () else (
    print_endline "✗ FAIL: Failed step2 valid";
    exit 1
  )

let test_parser_step2_valid2 () =
  let input = get_input_from_file "test/json_inputs/step2/valid2.json" in
  (* printf "Input -> `%s`\n" input; *)

  let result = parse_input input in

  if result then () else (
    print_endline "✗ FAIL: Failed step2 valid2";
    exit 1
  )

let test_parser_step2_valid2 () =
  let input = get_input_from_file "test/json_inputs/step2/valid3.json" in
  (* printf "Input -> `%s`\n" input; *)

  let result = parse_input input in

  if result then () else (
    print_endline "✗ FAIL: Failed step2 valid3";
    exit 1
  )

let run () =
  test_parser_step1_valid ();
  test_parser_step1_invalid ();
  test_parser_step2_valid ();
  test_parser_step2_valid2 ();
  print_endline "✓ SUCCESS: All Parser tests passed."
