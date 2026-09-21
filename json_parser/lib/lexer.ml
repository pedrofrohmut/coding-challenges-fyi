type t = {
  cursor: int;
  input: string;
}

let create (input: string): t =
  { cursor = 0; input }

let next_token (lexer: t): t * Token.t option =
  failwith "TODO: not implemented next_token."
