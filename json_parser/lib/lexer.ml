open Utils

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

  (* Return lexer.cursor at ending '"' and string content *)
  lexer, content


(* TODO: Cover case where the Unknown object is length 1 *)
let read_unknown lexer =
  let rec loop i lx =
    match get_ch_at i lx with
    | None -> failwith "Lexer - read_string: Unexpected end of input"
    | Some ch ->
      if Utils.is_closing_char ch then
        i
      else
        loop (i + 1) lx
  in

  let start_pos = lexer.cursor in
  let end_pos = loop start_pos lexer in (* closing character position *)
  let lexer = cursor_to (end_pos - 1) lexer in
  let content = String.sub lexer.input start_pos (end_pos - start_pos) in

  (* Return lexer.cursor at the closing character position - 1 *)
  lexer, content

let rec next_token lexer =
  match get_ch lexer with
  | None -> lexer, None
  | Some ch ->
    if Utils.is_whitespace ch then
      next_token (incr_cursor lexer)
    else
      let lexer, token =
        match ch with
        | '{' -> lexer, Token.create TokenType.OpenBrace "{"
        | '}' -> lexer, Token.create TokenType.CloseBrace "}"
        | '[' -> lexer, Token.create TokenType.OpenBracket "["
        | ']' -> lexer, Token.create TokenType.CloseBracket "]"
        | ':' -> lexer, Token.create TokenType.Colon ":"
        | ',' -> lexer, Token.create TokenType.Comma ","
        | '"' ->
          let lexer, value = read_string lexer in
          let token = Token.create TokenType.String value in
          lexer, token
        | '\\' -> failwith "TODO: implement the backslash tokens"
        | _ ->
          let lexer, value = read_unknown lexer in
          match value with
          | "true" | "false" -> lexer, Token.create TokenType.Bool value
          | "null" -> lexer, Token.create TokenType.Null value
          | _ ->
            if Utils.is_number value then
              lexer, Token.create TokenType.Number value
            else
              lexer, Token.create TokenType.Unknown value
      in
      incr_cursor lexer, Some token

let rec print_all_tokens (lexer: t): unit =
  let lexer, token = next_token lexer in
  match token with
  | None -> ()
  | Some token -> (
    Token.print_token token;
    print_all_tokens lexer
  )

let print_lexer (lexer: t): unit =
  let ch_str =
    match get_ch lexer with
    | None -> "EOF"
    | Some v -> Char.escaped v
  in
  Printf.printf "Lexer => { cursor = %d; char_at = `%s` }\n" lexer.cursor ch_str
