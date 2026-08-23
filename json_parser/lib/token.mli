open Token_type

type t

val create: Token_type.t ->  string -> t

val get_literal: t -> string
