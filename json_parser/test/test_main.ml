open Json_parser

let () =
  Test_lexer.run ();
  Test_parser.run ();
  print_endline "✓ SUCCESS: All tests passed.";
  exit 0
