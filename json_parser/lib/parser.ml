open Token

type t = {
    lexer: Lexer.t;
    curr: Token.t option;
    peek: Token.t option;
  }

(* Creates a parser an populate it with the first token *)
let create lexer =
  let lexer, curr_token = Lexer.next_token lexer in
  let lexer, peek_token = Lexer.next_token lexer in
  { lexer; curr = curr_token; peek = peek_token }

(* Interate the parser to the next token *)
let parser_next parser =
  let lexer, token = Lexer.next_token parser.lexer in
  { lexer; curr = parser.peek; peek = token }

let expect_type token expected_type =
  match token with
  | None -> false
  | Some token ->
     token.token_type = expected_type

let parse_key_value parser =
  let parser = parser_next parser in
  if not (expect_type parser.curr TokenType.String) then (
    Printf.printf "Expected token String for key but got `%s` instead.\n" (Option.get parser.curr).literal;
    parser, false
  )

  else
    let parser = parser_next parser in
    if not (expect_type parser.curr TokenType.Colon) then (
      Printf.printf "Expected token to be Colon but got `%s` instead.\n" (Option.get parser.curr).literal;
      parser, false
    )

    else
      let parser = parser_next parser in
      if not (expect_type parser.curr TokenType.String) then (
        Printf.printf "Expected token String for value but got `%s` instead.\n" (Option.get parser.curr).literal;
        parser, false
      )

      else
        parser, true

let parse_object parser =
  match parser.curr with
  | None -> (
    print_endline "Unexpected end of object";
    parser, false
  )
  | Some _ ->
     (* if token.token_type = TokenType.CloseBrace then *)
     if expect_type parser.peek TokenType.CloseBrace then
       let parser = parser_next parser in
       parser, true

     else
       let parser, okay = parse_key_value parser in
       if not okay then
         parser, false

       else
         let parser = parser_next parser in
         if not (expect_type parser.curr TokenType.CloseBrace) then (
           Printf.printf "Expected token CloseBrace for End of object but got `%s` instead.\n" (Option.get parser.curr).literal;
           parser, false
         )

         else
           parser, true


let parse_array parser =
  failwith "TODO: parse_array not implemented"

let parse_input parser =
  (* Parse first token *)
  match parser.curr with
  | None -> (
    print_endline "Empty input";
    false
  )
  | Some v ->
     match v.token_type with
     | TokenType.OpenBrace -> let _, ok = parse_object parser in ok
     | TokenType.OpenBracket -> let _, ok = parse_array parser in ok
     | _ -> (
       print_endline "Unexpected first token for parsing";
       false
     )
