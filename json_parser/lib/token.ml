type t = {
  token_type: Token_type.t;
  literal: string;
}

let create (token_type: Token_type.t) (literal: string): t  =
  { token_type; literal }
