open Printf

type t = {
  token_type: Token_type.t;
  literal: string;
  line: int;
  column: int;
}

let create (token_type: Token_type.t) (literal: string) (line: int) (column: int): t  =
  { token_type; literal; line; column }

let print_token (token: t): unit =
  printf "Token { token_type: %s; literal: `%s`; line: %d; column: %d }\n"
    (Token_type.to_string token.token_type) token.literal token.line token.column
