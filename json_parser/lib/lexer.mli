type t

val create: string -> t
val next_token: t -> t * Token.t option
val has_next: t -> bool
