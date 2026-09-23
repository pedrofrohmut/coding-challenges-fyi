type t = {
  cursor: int;
  input: string;
  line: int;
  column: int;
}

let create (input: string): t =
  { cursor = 0; input; line = 1; column = 0 }

let get_ch (lexer: t): char option =
  if lexer.cursor < (String.length lexer.input) then
    Some (String.get lexer.input lexer.cursor)
  else
    None

let incr_cursor (lexer: t): t =
  { lexer with cursor = lexer.cursor + 1; column = lexer.column + 1 }

(* TODO: change line and column. Wait to do it when checking for whitespaces *)
let next_token (lexer: t): t * Token.t option =
  match get_ch lexer with
  | None -> lexer, None
  | Some ch ->
     let lexer, token =
       match ch with
       | '{' -> lexer, Token.create Token_type.OpenBrace "{"
       | '}' -> lexer, Token.create Token_type.CloseBrace "}"
       | _ -> lexer, Token.create Token_type.Unknown (Char.escaped ch)
     in
     let lexer = incr_cursor lexer in
     lexer, Some token
