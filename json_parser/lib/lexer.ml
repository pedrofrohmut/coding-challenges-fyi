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

let incr_cursor (lex: t): t =
  { lex with cursor = lex.cursor + 1; column = lex.column + 1 }

(* TODO: change line and column. Wait to do it when checking for whitespaces *)
let next_token (lex: t): t * Token.t option =
  match get_ch lex with
  | None -> lex, None
  | Some ch ->
     let lex, token =
       match ch with
       | '{' -> lex, Token.create Token_type.OpenBrace "{"
       | '}' -> lex, Token.create Token_type.CloseBrace "}"
       | _ -> lex, Token.create Token_type.Unknown (Char.escaped ch)
     in
     let lex = incr_cursor lex in
     lex, Some token
