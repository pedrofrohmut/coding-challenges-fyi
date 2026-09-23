module Output = struct
  type t =
    | Null
    | Bool of bool
    | Number of float
    | String of string
    | Object of (string * t) list
    | Array of t list
end

type t = {
  lex: Lexer.t;
  curr: Token.t option;
  peek: Token.t option;
}

let create (lex: Lexer.t): t =
  let lex, curr = Lexer.next_token lex in
  let lex, peek = Lexer.next_token lex in
  { lex; curr; peek }

let run (_par: t): (Output.t, string) result =
  failwith "TODO: Not implemented - parser.run"
