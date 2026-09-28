open Printf

type t = {
  cursor: int;
  input: string;
  line: int;
  column: int;
}

let create (input: string): t =
  { cursor = 0; input; line = 1; column = 0 }

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
  (* TODO: if curr ch is \n add line and reset column instead *)
  { lex with cursor = lex.cursor + 1; column = lex.column + 1 }

(* TODO: track the line and col from lex.cursor to i *)
let cursor_to (lex: t) (i: int): t =
  if i > (String.length lex.input) then
    failwith "Out of bounds. Try to point the lexer cursor into an invalid position"
  else
    { lex with cursor = i } (* TODO: Add the tracked values here *)

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

let is_whitespace = function
  | ' ' | '\r' | '\t' | '\n' -> true
  | _ -> false

(* TODO: change line and column. Wait to do it when checking for whitespaces *)
let rec next_token (lex: t): t * Token.t option =
  match get_ch lex with
  | None -> lex, None
  | Some ch ->
     if is_whitespace ch then
       next_token (incr_cursor lex)

     else
       let lex, token =
         match ch with
         | '{' -> lex, Token.create Token_type.OpenBrace "{"
         | '}' -> lex, Token.create Token_type.CloseBrace "}"
         | ':' -> lex, Token.create Token_type.Colon ":"
         | '"' ->
            let lex, string_content = get_string_content lex in
            lex, Token.create Token_type.String string_content
         | _ -> lex, Token.create Token_type.Unknown (Char.escaped ch)
       in
       let lex = incr_cursor lex in
       lex, Some token
