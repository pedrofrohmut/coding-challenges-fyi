type t = private {
  cursor: int;
  input: string;
}

val create: string -> t
val next_token: t -> t * Token.t option
