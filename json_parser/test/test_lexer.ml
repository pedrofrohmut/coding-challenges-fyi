open Json_parser
open Test_utils

let check_tokens expected_tokens lexer =
  let rec get_tokens lx =
    let lx, token = Lexer.next_token lx in
    match token with
    | None -> []
    | Some token -> token.token_type :: get_tokens lx
  in

  let rec match_tokens xs ys =
    (* xs lexer tokens and ys expected tokens *)
    match xs, ys with
    | [], [] -> true
    | [], _ | _, [] -> (
      prerr_endline "The number of tokens doesn't match";
      false
    )
    | x :: xt, y :: yt ->
       if x <> y then (
         let y = TokenType.to_string y in
         let x = TokenType.to_string x in
         Printf.printf "TokenTypes doesn't match. Expected `%s` but got `%s` instead.\n" y x;
         false
       )
       else
         match_tokens xt yt
  in

  let tokens = get_tokens lexer in
  match_tokens tokens expected_tokens

let test_lexer_step1_valid () =
  let input = get_input_from_file "test/json_inputs/step1/valid.json" in
  let lexer = Lexer.create input in

  let expected_tokens = [
      TokenType.OpenBrace;
      TokenType.CloseBrace;
    ] in

  let result = check_tokens expected_tokens lexer in

  if result then () else (
    (* Lexer.print_all_tokens lexer; *)
    print_endline "✗ FAIL: Lexer Failed step1 valid";
    exit 1
  )

let test_lexer_step1_invalid () =
  let input = get_input_from_file "test/json_inputs/step1/invalid.json" in
  let lexer = Lexer.create input in

  let expected_tokens = [] in

  let result = check_tokens expected_tokens lexer in

  if result then () else (
    (* Lexer.print_all_tokens lexer; *)
    print_endline "✗ FAIL: Lexer Failed step1 invalid";
    exit 1
  )

let test_lexer_step2_valid () =
  let input = get_input_from_file "test/json_inputs/step2/valid.json" in
  let lexer = Lexer.create input in

  let expected_tokens = [
      TokenType.OpenBrace;
      TokenType.String;
      TokenType.Colon;
      TokenType.String;
      TokenType.CloseBrace;
    ] in

  let result = check_tokens expected_tokens lexer in

  if result then () else (
    (* Lexer.print_all_tokens lexer; *)
    print_endline "✗ FAIL: Lexer Failed step2 valid";
    exit 1
  )

let test_lexer_step2_valid2 () =
  let input = get_input_from_file "test/json_inputs/step2/valid2.json" in
  let lexer = Lexer.create input in

  let expected_tokens = [
      TokenType.OpenBrace;
      TokenType.String;
      TokenType.Colon;
      TokenType.String;
      TokenType.Comma;
      TokenType.String;
      TokenType.Colon;
      TokenType.String;
      TokenType.CloseBrace;
    ] in

  let result = check_tokens expected_tokens lexer in

  if result then () else (
    (* Lexer.print_all_tokens lexer; *)
    print_endline "✗ FAIL: Lexer Failed step2 valid2";
    exit 1
  )

let test_lexer_step2_valid3 () =
  let input = get_input_from_file "test/json_inputs/step2/valid3.json" in
  let lexer = Lexer.create input in

  let expected_tokens = [
      TokenType.OpenBrace;

      TokenType.String;
      TokenType.Colon;
      TokenType.String;
      TokenType.Comma;

      TokenType.String;
      TokenType.Colon;
      TokenType.String;
      TokenType.Comma;

      TokenType.String;
      TokenType.Colon;
      TokenType.String;
      TokenType.Comma;

      TokenType.String;
      TokenType.Colon;
      TokenType.String;
      TokenType.Comma;

      TokenType.String;
      TokenType.Colon;
      TokenType.String;

      TokenType.CloseBrace;
    ] in

  let result = check_tokens expected_tokens lexer in

  if result then () else (
    (* Lexer.print_all_tokens lexer; *)
    print_endline "✗ FAIL: Lexer Failed step2 valid3";
    exit 1
  )

let test_lexer_step2_invalid () =
  let input = get_input_from_file "test/json_inputs/step2/invalid.json" in
  let lexer = Lexer.create input in

  let expected_tokens = [
      TokenType.OpenBrace;
      TokenType.String;
      TokenType.Colon;
      TokenType.String;
      TokenType.Comma;
      TokenType.CloseBrace;
    ] in

  let result = check_tokens expected_tokens lexer in

  if result then () else (
    (* Lexer.print_all_tokens lexer; *)
    print_endline "✗ FAIL: Lexer Failed step2 invalid";
    exit 1
  )

let test_lexer_step2_invalid2 () =
  let input = get_input_from_file "test/json_inputs/step2/invalid2.json" in
  let lexer = Lexer.create input in

  let expected_tokens = [
      TokenType.OpenBrace;
      TokenType.String;
      TokenType.Colon;
      TokenType.String;
      TokenType.Comma;
      TokenType.Unknown;
      TokenType.Colon;
      TokenType.String;
      TokenType.CloseBrace;
    ] in

  let result = check_tokens expected_tokens lexer in

  if result then () else (
    (* Lexer.print_all_tokens lexer; *)
    print_endline "✗ FAIL: Lexer Failed step2 invalid2";
    exit 1
  )

let test_lexer_step3_valid () =
  let input = get_input_from_file "test/json_inputs/step3/valid.json" in
  let lexer = Lexer.create input in

  let expected_tokens = [
    TokenType.OpenBrace;
    TokenType.String; TokenType.Colon; TokenType.Bool;   TokenType.Comma;
    TokenType.String; TokenType.Colon; TokenType.Bool;   TokenType.Comma;
    TokenType.String; TokenType.Colon; TokenType.Null;   TokenType.Comma;
    TokenType.String; TokenType.Colon; TokenType.String; TokenType.Comma;
    TokenType.String; TokenType.Colon; TokenType.Number;
    TokenType.CloseBrace;
  ] in

  let result = check_tokens expected_tokens lexer in

  if result then () else (
    (* Lexer.print_all_tokens lexer; *)
    print_endline "✗ FAIL: Lexer Failed step3 valid";
    exit 1
  )

let test_lexer_step3_invalid () =
  let input = get_input_from_file "test/json_inputs/step3/invalid.json" in
  let lexer = Lexer.create input in

  let expected_tokens = [
    TokenType.OpenBrace;
    TokenType.String; TokenType.Colon; TokenType.Bool;    TokenType.Comma;
    TokenType.String; TokenType.Colon; TokenType.Unknown; TokenType.Comma;
    TokenType.String; TokenType.Colon; TokenType.Null;    TokenType.Comma;
    TokenType.String; TokenType.Colon; TokenType.String;  TokenType.Comma;
    TokenType.String; TokenType.Colon; TokenType.Number;
    TokenType.CloseBrace;
  ] in

  let result = check_tokens expected_tokens lexer in

  if result then () else (
    (* Lexer.print_all_tokens lexer; *)
    print_endline "✗ FAIL: Lexer Failed step3 invalid";
    exit 1
  )

let test_lexer_step4_valid () =
  let input = get_input_from_file "test/json_inputs/step4/valid.json" in
  let lexer = Lexer.create input in

  let expected_tokens = [
    TokenType.OpenBrace;
    TokenType.String; TokenType.Colon; TokenType.String;      TokenType.Comma;
    TokenType.String; TokenType.Colon; TokenType.Number;      TokenType.Comma;
    TokenType.String; TokenType.Colon; TokenType.OpenBrace;   TokenType.CloseBrace; TokenType.Comma;
    TokenType.String; TokenType.Colon; TokenType.OpenBracket; TokenType.CloseBracket;
    TokenType.CloseBrace;
  ] in

  let result = check_tokens expected_tokens lexer in

  if result then () else (
    (* Lexer.print_all_tokens lexer; *)
    print_endline "✗ FAIL: Lexer Failed step4 valid";
    exit 1
  )


let test_lexer_step4_valid2 () =
  let input = get_input_from_file "test/json_inputs/step4/valid2.json" in
  let lexer = Lexer.create input in

  let expected_tokens = [
    TokenType.OpenBrace;

    TokenType.String;     TokenType.Colon; TokenType.String; TokenType.Comma;
    TokenType.String;     TokenType.Colon; TokenType.Number; TokenType.Comma;

    TokenType.String;     TokenType.Colon; TokenType.OpenBrace;
    TokenType.String;     TokenType.Colon; TokenType.String;
    TokenType.CloseBrace; TokenType.Comma;

    TokenType.String;     TokenType.Colon; TokenType.OpenBracket;
    TokenType.String;
    TokenType.CloseBracket;

    TokenType.CloseBrace;
  ] in

  let result = check_tokens expected_tokens lexer in

  if result then () else (
    (* Lexer.print_all_tokens lexer; *)
    print_endline "✗ FAIL: Lexer Failed step4 valid2";
    exit 1
  )

let test_lexer_step4_invalid () =
  let input = get_input_from_file "test/json_inputs/step4/invalid.json" in
  let lexer = Lexer.create input in

  let expected_tokens = [
    TokenType.OpenBrace;

    TokenType.String;     TokenType.Colon; TokenType.String; TokenType.Comma;
    TokenType.String;     TokenType.Colon; TokenType.Number; TokenType.Comma;

    TokenType.String;     TokenType.Colon; TokenType.OpenBrace;
    TokenType.String;     TokenType.Colon; TokenType.String;
    TokenType.CloseBrace; TokenType.Comma;

    TokenType.String;     TokenType.Colon; TokenType.OpenBracket;
    TokenType.Unknown;
    TokenType.CloseBracket;

    TokenType.CloseBrace;
  ] in

  let result = check_tokens expected_tokens lexer in

  if result then () else (
    (* Lexer.print_all_tokens lexer; *)
    print_endline "✗ FAIL: Lexer Failed step4 invalid";
    exit 1
  )

let run () =
  test_lexer_step1_valid ();
  test_lexer_step1_invalid ();

  test_lexer_step2_valid ();
  test_lexer_step2_valid2 ();
  test_lexer_step2_valid3 ();
  test_lexer_step2_invalid ();
  test_lexer_step2_invalid2 ();

  (* TODO: invalid2 1-length unknown token *)
  test_lexer_step3_valid ();
  test_lexer_step3_invalid ();

  test_lexer_step4_valid ();
  test_lexer_step4_valid2 ();
  test_lexer_step4_invalid ();

  print_endline "✓ SUCCESS: All lexer tests passed."
