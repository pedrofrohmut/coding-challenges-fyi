open Json_parser

let parse_input input =
  let lexer = Lexer.create input in
  let parser = Parser.create lexer in
  Parser.parse_input parser

let prefix_path file_path =
  let cwd = Sys.getcwd () in
  let res = String.split_first ~sep:"_build" cwd in

  if Option.is_none res then (
    prerr_endline "Cwd does not contain the _build folder. This function won't know where to split the path.";
    failwith "Invalid cwd"
  )

  else
    let prefix, _ = Option.get res in
    prefix ^ file_path

let get_input_from_file file_path =
  if String.starts_with ~prefix:"/" file_path then (
    prerr_endline "ERROR: File path must not start with a slash";
    failwith "Invalid file path"
  );

  let full_path = prefix_path file_path in

  if not (Sys.file_exists full_path) then (
    prerr_endline "ERROR: File path will be prefixed with the `<project root>/`. Make sure to follow this pattern";
    failwith "Input file not found"
  );

  let in_chan = open_in full_path in
  let file_str = In_channel.input_all in_chan in
  close_in in_chan;

  file_str

let test_step1_valid () =
  let input = get_input_from_file "test/json_inputs/step1/valid.json" in

  let result = parse_input input in

  if result then () else (
    print_endline "ERROR: Failed step1 valid";
    exit 1
  )

let test_step1_invalid () =
  let input = get_input_from_file "test/json_inputs/step1/invalid.json" in

  let result = parse_input input in

  if not result then () else (
    print_endline "ERROR: Failed step1 invalid";
    exit 1
  )

let test_step2_valid () =
  let input = get_input_from_file "test/json_inputs/step2/valid.json" in

  let result = parse_input input in

  if result then () else (
    print_endline "Error: Failed step2 valid";
    exit 1
  )

let () =
  test_step1_valid ();
  test_step1_invalid ();
  test_step2_valid ();
  exit 0
