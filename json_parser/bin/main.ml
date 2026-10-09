(* let () = print_endline "Hello, World!" *)
open Json_parser

let () =
  let prefix = Sys.getcwd () in
  let full_path = prefix ^ "/test/json_inputs/step5/pass1_alt2.json" in

  if not (Sys.file_exists full_path) then (
    print_endline "File not found.";
    Printf.printf "Full_path: `%s`\n" full_path;
    exit 1
  )

  else
    let in_chan = open_in full_path in
    let file_str = In_channel.input_all in_chan in
    close_in in_chan;

    let input = file_str in
    let lex = Lexer.create input in
    let par = Parser.create lex in
    let parsed = Parser.run par in
    match parsed with
    | Ok output ->
        ignore output;
        print_endline "Ok";
        exit 0
    | Error msg ->
        print_endline "Error";
        print_endline msg;
        exit 1
