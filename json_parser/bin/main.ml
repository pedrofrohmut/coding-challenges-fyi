open Json_parser

let rec print_all_tokens lexer =
  let lexer, token = Lexer.next_token lexer in
  match token with
  | None -> ()
  | Some token -> (
    Token.print_token token;
    print_all_tokens lexer
  )

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

    print_all_tokens lexer;

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
