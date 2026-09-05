let is_whitespace = function
  | ' ' | '\r' | '\t' | '\n' -> true
  | _ -> false

let is_closing_char = function
  | ':' | ',' | ']' | '}' | '\n' -> true
  | _ -> false

let is_number_char = function
  | '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' | '.' | ',' -> true
  | _ -> false

let is_number src =
  not (String.exists (fun ch -> not (is_number_char ch)) src)

let split_string sep src =
  let sep_len = String.length sep in
  let src_len = String.length src in
  let limit = src_len - sep_len in
  let sep_first = String.get sep 0 in

  let rec loop i =
    if i = limit then
      None
    else
      let curr = String.get src i in
      if curr <> sep_first then
        loop (i + 1)
    else
      let start = i in
      let count = sep_len in
      let src_sub = String.sub src start count in
      if src_sub <> sep then
        loop (i + 1)
      else
        let before = String.sub src 0 start in
        let rest = String.sub src start (src_len - start) in
        Some (before, rest)
  in
  loop 0

let get_input_from_file file_path =
  if String.starts_with ~prefix:"/" file_path then (
    prerr_endline "ERROR: File path must not start with a slash";
    failwith "Invalid file path"
  );

  if String.starts_with ~prefix:"." file_path then (
    prerr_endline "ERROR: relative paths are not supported";
    failwith "Invalid file path"
  );

  let prefix = Sys.getcwd () in (* Project root *)
  let full_path = prefix ^ "/" ^ file_path in

  if not (Sys.file_exists full_path) then (
    prerr_endline "ERROR: File path will be prefixed with the `<project root>/`. Make sure to follow this pattern";
    failwith "Input file not found"
  );

  let in_chan = open_in full_path in
  let file_str = In_channel.input_all in_chan in
  close_in in_chan;

  file_str
