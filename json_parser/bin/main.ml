open Json_parser

let () =
  let args = Sys.argv in
  let len = Array.length args in

  if len = 1 then
    begin
      Printf.eprintf "Arguments not provided for parsing.\n";
      exit 1
    end

  else
    let input = args.(1) in

    let lexer = Lexer.create input in

    Lexer.print_all_tokens lexer;

    try
      let parser = Parser.create lexer in
      let result = Parser.parse_input parser in

      if result then (
        print_endline "Everything is okay.";
        exit 0
      )

      else (
        print_endline "Error: error found parsing the input.";
        exit 1
      )
    with
      Failure msg -> Printf.printf "Some Error: `%s`\n" msg; exit 1
