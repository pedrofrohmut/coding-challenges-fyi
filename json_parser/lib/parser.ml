type t = {
  lexer: Lexer.t
}

let fail_unexpected () = failwith "Unexpected token"

let create lexer = { lexer }

let parse_input t =
  let lexer = t.lexer in

  let lexer, token = Lexer.next_token lexer in

  if Token.get_literal token <> "{" then
    false

  else
    let lexer, token = Lexer.next_token lexer in
    if Token.get_literal token <> "}" then
      false

    else
      true
