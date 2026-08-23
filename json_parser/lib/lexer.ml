type t = {
  cursor: int;
  input: string;
}

let create input =
  { cursor = 0; input }

let incr_cursor t =
  { cursor = t.cursor + 1; input = t.input }

let next_token t =
  let ch = String.get t.input t.cursor in

  Printf.printf "Lexer_Next ch: `%s`\n" (Char.escaped ch);

  let token =
    match ch with
    | '{' -> Token.create TokenType.OpenBrace "{"
    | '}' -> Token.create TokenType.CloseBrace "}"
    | _ -> failwith "Not implemented token match"
  in

  let new_t = incr_cursor t in

  new_t, token
