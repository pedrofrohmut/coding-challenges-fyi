open Printf

type t = {
  cursor: int;
  input: string;
  line: int;
  column: int;
}

let create (input: string): t =
  { cursor = 0; input; line = 1; column = 1 }

let get_ch (lex: t): char option =
  if lex.cursor < (String.length lex.input) then
    Some (String.get lex.input lex.cursor)
  else
    None

let get_ch_at (i: int) (lex: t): char option =
  if i < (String.length lex.input) then
    Some (String.get lex.input i)
  else
    None

let peek_ch (lex: t): char option =
  if lex.cursor + 1 < (String.length lex.input) then
    Some (String.get lex.input (lex.cursor + 1))
  else
    None

let incr_cursor (lex: t): t =
  match get_ch lex with
  | None -> failwith "Cannot increment the lexer cursor. End of input"
  | Some ch ->
     if ch = '\n' then
       { lex with cursor = lex.cursor + 1; column = 1; line = lex.line + 1 }
     else
       { lex with cursor = lex.cursor + 1; column = lex.column + 1 }

let cursor_to_foo (lex: t) (i: int): t =
  { lex with cursor = i }

(* Instead of just setting the cursor to i, it iterates on the input to track the line and column *)
let cursor_to (lex: t) (to_pos: int): t =
  let rec loop i line col =
    if i >= to_pos then
      line, col
    else
      match get_ch_at i lex with
      | None -> failwith "Out of bounds. Trying to point the lexer cursor into an invalid position"
      | Some ch ->
         if ch = '\n' then
           loop (i + 1) (line + 1) 1
         else
           loop (i + 1) line (col + 1)
  in
  let line, column = loop lex.cursor lex.line lex.column in
  { lex with cursor = to_pos; line; column }

let is_whitespace_char = function
  | ' ' | '\r' | '\t' | '\n' -> true
  | _ -> false

let is_closing_char = function
  | ':' | ',' | ']' | '}' | '\n' -> true
  | _ -> false

let get_string_content (lex: t): t * string =
  let rec loop i lex =
    let curr = get_ch_at i lex in
    match curr with
    | None -> failwith "Invalid end of string. End of string not found."
    | Some '"' -> i
    | Some '\\' -> (
       match get_ch_at (i + 1) lex with
       | None -> failwith "Invalid end of string. String ended after a backslash."
       | Some '"' -> loop (i + 2) lex
       | _ -> loop (i + 1) lex
    )
    | Some x -> loop (i + 1) lex
  in

  if (peek_ch lex) = Some '"' then
    lex, ""

  else
    let str_begin = lex.cursor + 1 in
    let str_end = loop str_begin lex in
    let content_length = str_end - str_begin in
    let content = String.sub lex.input str_begin content_length in
    let lex = cursor_to lex str_end in
    lex, content

let get_unknown_content (lex: t): t * string =
  let rec loop i lex =
    match get_ch_at i lex with
    | None -> failwith "Invalid Unknown Content. Reached end of input while reading unknown content."
    | Some ch ->
       if is_closing_char ch then
         i
       else
         loop (i + 1) lex
  in

  match get_ch lex with
  | None -> failwith "Invalid Unknown Content. get_unknown_content called after end of input."
  | Some ch ->
     let peek = peek_ch lex in
     if Option.is_none peek || is_closing_char (Option.get peek) then
       lex, Char.escaped ch

     else
       let str_begin = lex.cursor in
       let str_end = loop str_begin lex in
       let content_length = str_end - str_begin in
       let content = String.sub lex.input str_begin content_length in
       let lex = cursor_to lex (str_end - 1) in
       lex, content

let rec next_token (lex: t): t * Token.t option =
  match get_ch lex with
  | None -> lex, None
  | Some ch ->
     if is_whitespace_char ch then
       let lex = incr_cursor lex in
       next_token lex

     else
       let lex, token =
         match ch with
         | '{' -> lex, Token.create Token_type.OpenBrace "{" lex.line lex.column
         | '}' -> lex, Token.create Token_type.CloseBrace "}" lex.line lex.column
         | ':' -> lex, Token.create Token_type.Colon ":" lex.line lex.column
         | ',' -> lex, Token.create Token_type.Comma "," lex.line lex.column
         | '"' ->
            let start_line = lex.line in
            let start_column = lex.column in
            let lex, content = get_string_content lex in
            lex, Token.create Token_type.String content start_line start_column
         | _ ->
            let start_line = lex.line in
            let start_column = lex.column in
            let lex, content = get_unknown_content lex in
            lex, Token.create Token_type.Unknown content start_line start_column
       in
       let lex = incr_cursor lex in
       lex, Some token

let print_all_tokens (input: string): unit =
  let rec loop lex =
    match next_token lex with
    | _, None -> ()
    | lex, Some token -> (
      printf "Token { token_type: `%s`; literal: `%s`; line: %d; column: %d }\n"
        (Token_type.to_string token.token_type) token.literal token.line token.column;
      loop lex
    )
  in
  let lex = create input in
  loop lex
