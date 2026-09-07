type t

val create: string -> t
val next_token: t -> t * Token.t option
val print_all_tokens: t -> unit
val print_lexer: t -> unit
