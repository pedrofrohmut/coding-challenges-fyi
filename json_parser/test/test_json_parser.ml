let () =
  let lex_ok = Test_lexer.run () in
  if not lex_ok then
    print_endline "✗ FAIL: Lexer test(s) failed."
  else
    print_endline "✓ SUCCESS: Lexer test(s) passed.";

  let parser_ok = Test_parser.run () in
  if not parser_ok then
    print_endline "✗ FAIL: Parser test(s) failed."
  else
    print_endline "✓ SUCCESS: Parser test(s) passed.";

  if not lex_ok || not parser_ok then
    exit 1

  else (
    print_endline "✓ SUCCESS: All tests passed.";
    exit 0
  )
