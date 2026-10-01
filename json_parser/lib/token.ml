type t = {
  token_type: Token_type.t;
  literal: string;
  line: int;
  column: int;
}

let create (token_type: Token_type.t) (literal: string) (line: int) (column: int): t  =
  { token_type; literal; line; column }
