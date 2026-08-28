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
let parser_next par =
  let lexer, token = Lexer.next_token par.lexer in
  { lexer; curr = par.peek; peek = token }

let expect_type token expected_type =
  match token with
  | None -> false
  | Some token ->
     token.token_type = expected_type

let parse_object par =
  failwith "TODO: parse_object not implemented"

let parse_array par =
  failwith "TODO: parse_array not implemented"

let parse_input par =
  (* Parse first token *)
  match par.curr with
  | None -> (
    print_endline "Empty input";
    false
  )
  | Some v ->
     match v.token_type with
     | TokenType.OpenBrace ->
        let _, ok = parse_object par in ok
     | TokenType.OpenBracket ->
        let _, ok = parse_array par in ok
     | _ -> (
       print_endline "Unexpected first token for parsing";
       false
     )
