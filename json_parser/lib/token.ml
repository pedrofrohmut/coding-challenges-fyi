type t = {
  token_type: TokenType.t;
  literal: string;
}

let create token_type literal = { token_type; literal }
