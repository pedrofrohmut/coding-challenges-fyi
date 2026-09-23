type t = private {
  cursor: int;
  input: string;
  line: int;
  column: int;
}

val create: string -> t
val next_token: t -> t * Token.t option
