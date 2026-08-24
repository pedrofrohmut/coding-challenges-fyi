open Token

type t = {
  lexer: Lexer.t;
  curr: Token.t option;
}

let fail_unexpected () = failwith "Unexpected token"

let create lexer = { lexer; curr = None }

let expect_type token expected_type =
  match token with
  | None -> false
  | Some v ->
     v.token_type = expected_type

let parse_key_value lexer =
  (* TODO: Check if needed to check has next at the beginning *)
  if not (Lexer.has_next lexer) then
    false

  else
    let lexer, token = Lexer.next_token lexer in
    if not (expect_type token TokenType.String) then (
      Printf.printf "Expected token String but got `%s` instead" (Option.get token).literal;
      false
    )

    else
      let lexer, token = Lexer.next_token lexer in
      if not (expect_type token TokenType.Colon) then (
        Printf.printf "Expected token to be Colon but got `%s` instead" (Option.get token).literal;
        false
      )

      else
        let lexer, token = Lexer.next_token lexer in
        if not (expect_type token TokenType.String) then (
          Printf.printf "Expected token to be String but got `%s` instead" (Option.get token).literal;
          false
        )

        else
          true

let parse_object lexer =
  let lexer, token = Lexer.next_token lexer in
  match token with
  | None -> (
    Printf.printf "Unexpected end of object";
    false
  )
  | Some v ->
     if v.token_type = TokenType.CloseBrace then
       true

     else
       parse_key_value lexer

let parse_array lexer =
  failwith "TODO: parse_array not implemented"

let parse_input parser =
  let lexer = parser.lexer in

  let lexer, token = Lexer.next_token lexer in

  (* Parse first character *)
  match token with
  | None -> (
    print_endline "Empty input";
    false
  )
  | Some v ->
     match v.token_type with
     | TokenType.OpenBrace -> parse_object lexer
     | TokenType.OpenBracket -> parse_array lexer
     | _ -> (
       print_endline "Unexpected first token for parsing";
       false
     )
