type t = {
    cursor: int;
    input: string;
  }

let create input =
  { cursor = 0; input }

let incr_cursor lexer =
  { cursor = lexer.cursor + 1; input = lexer.input }

let cursor_to n lexer =
  { cursor = n; input = lexer.input }

let has_next lexer =
  let input_len = String.length lexer.input in
  let next_pos = lexer.cursor + 1 in
  next_pos < input_len

let get_ch lexer =
  let input_len = String.length lexer.input in
  if lexer.cursor < input_len then
    Some (String.get lexer.input lexer.cursor)
  else
    None

let get_ch_at position lexer =
  let input_len = String.length lexer.input in
  if position < input_len then
    Some (String.get lexer.input position)
  else
    None

let print_lexer lexer =
  let ch_str =
    match get_ch lexer with
    | None -> "EOF"
    | Some v -> Char.escaped v
  in
  Printf.printf "Lexer => { cursor = %d; char_at = `%s` }\n" lexer.cursor ch_str

let read_string lexer =
  let rec loop i lx =
    let ch = get_ch_at i lx in
    match ch with
    | None -> failwith "Lexer - read_string: Unexpected end of input"
    | Some '"' -> i
    | Some _ -> loop (i + 1) lx
  in

  (* Skip the '"' *)
  let lexer = incr_cursor lexer in

  let start_pos = lexer.cursor in
  let end_pos = loop start_pos lexer in (* ending '"' position *)
  let lexer = cursor_to end_pos lexer in
  let content = String.sub lexer.input start_pos (end_pos - start_pos) in

  (* Return lexer at ending '"' and string content *)
  lexer, content

let rec next_token lexer =
  let init_ch = get_ch lexer in
  match init_ch with
  | None -> lexer, None
  | Some ch ->
     if Char.Ascii.is_white ch then
       next_token (incr_cursor lexer)
     else
       let lexer, token =
         match ch with
         | '\\' -> failwith "Lexer next_token - Error: Found and back slash."
         | '{' -> lexer, Token.create TokenType.OpenBrace "{"
         | '}' -> lexer, Token.create TokenType.CloseBrace "}"
         | ':' -> lexer, Token.create TokenType.Colon ":"
         | '"' ->
            let lexer, value = read_string lexer in
            let token = Token.create TokenType.String value in
            lexer, token
         | _ -> (
           Printf.printf "ERROR - Lexer next_token: Not implemented match for `%c`\n" ch;
           failwith "Not implemented token match"
         )
       in
       incr_cursor lexer, Some token
