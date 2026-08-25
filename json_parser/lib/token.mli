type t = private {
  token_type: TokenType.t;
  literal: string;
}

val create: TokenType.t ->  string -> t
val print_token: t -> unit
