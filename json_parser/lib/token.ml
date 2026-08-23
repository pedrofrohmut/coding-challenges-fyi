open Token_type

type t = {
  token_type: Token_type.t;
  literal: string;
}

let create token_type literal = { token_type; literal }

let get_literal t = t.literal
