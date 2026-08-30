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

let is_valid_object_key token =
  expect_type token TokenType.String

let is_valid_object_value token =
  if Option.is_none token then
    false
  else
    let token = Option.get token in
    (* TODO: Support more types *)
    match token.token_type with
    | TokenType.String -> true
    | _ -> false

let rec parse_object_body par =
  if not (is_valid_object_key par.curr) then
    failwith "Invalid or missing Object key"

  else
    let par = parser_next par in
    if not (expect_type par.curr TokenType.Colon) then
      failwith "Not a colon after object key"

    else
      let par = parser_next par in
      if not (is_valid_object_value par.curr) then
        failwith "Not a valid object value"

    else
      if expect_type par.peek TokenType.Comma then
        let par = parser_next par in (* Curr is comma *)
        let par = parser_next par in (* Curr is next key *)
        parse_object_body par
      else
        par

let parse_object par =
  let par = parser_next par in

  if expect_type par.curr TokenType.CloseBrace then
    par

  else
    let par = parse_object_body par in

    let par = parser_next par in
    match par.curr with
    | None -> failwith "Unexpected end of object"
    | Some curr_token ->
      if curr_token.token_type <> TokenType.CloseBrace then
        failwith "Not a CloseBrace after object body"
      else
        par

let parse_array par =
  failwith "TODO: parse_array not implemented"

let parse_input par =
  try
    (* Parse first token *)
    match par.curr with
    | None -> (print_endline "Empty input"; false)
    | Some v ->
        match v.token_type with
       | TokenType.OpenBrace -> ignore (parse_object par); true
       | TokenType.OpenBracket -> ignore (parse_array par); true
       | _ -> (print_endline "Unexpected first token for parsing"; false)
  with
  | Failure msg -> (Printf.eprintf "Error parsing input: %s\n" msg; false)
