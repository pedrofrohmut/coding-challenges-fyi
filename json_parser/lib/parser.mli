module Output : sig
  type key = Key of string

  type t =
    | Null
    | Bool of bool
    | Number of float
    | String of string
    | Object of (key * t) list
    | Array of t list

  val kind: t -> string
  val string_of_key: key -> string
end

type t = private {
  lex: Lexer.t;
  curr: Token.t option;
  peek: Token.t option;
}

val create: Lexer.t -> t
val run: t -> (Output.t, string) result
