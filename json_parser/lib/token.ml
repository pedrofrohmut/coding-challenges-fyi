open TokenType

type t = {
  token_type: TokenType.t;
  literal: string;
}

let create token_type literal = { token_type; literal }

let print_token token =
  let str_type = TokenType.to_string token.token_type in
  Printf.printf "Token => { token_type = %s; literal = \"%s\" }\n" str_type token.literal
