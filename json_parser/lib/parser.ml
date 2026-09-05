open Token

type t = {
    lexer: Lexer.t;
    curr: Token.t option;
    peek: Token.t option;
  }

(* Creates a parser an populate it with the first token *)
let create (lexer: Lexer.t): t =
  let lexer, curr_token = Lexer.next_token lexer in
  let lexer, peek_token = Lexer.next_token lexer in
  { lexer; curr = curr_token; peek = peek_token }

(* Interate the parser to the next token *)
let parser_next (par: t): t =
  let lexer, token = Lexer.next_token par.lexer in
  { lexer; curr = par.peek; peek = token }

let expect_type token expected_type =
  match token with
  | None -> false
  | Some token ->
     token.token_type = expected_type

let is_valid_object_key (token: Token.t option): bool =
  expect_type token TokenType.String

let rec parse_object (par: t): t * bool =
  let par = parser_next par in

  if expect_type par.curr TokenType.CloseBrace then
    par, true

  else
    (* TODO: Check ok when stuff is not just a bunch of failwith *)
    let par, _ok = parse_object_body par in

    let par = parser_next par in
    match par.curr with
    | None -> failwith "Unexpected end of input: nothing after object body"
    | Some curr_token ->
      if curr_token.token_type <> TokenType.CloseBrace then
        failwith "Not a CloseBrace after object body"
      else
        par, true

(* TODO: Changes this failwiths for false *)
and parse_object_body (par: t): t * bool =
  if not (is_valid_object_key par.curr) then
    failwith "Invalid or missing Object key"

  else
    let par = parser_next par in
    if not (expect_type par.curr TokenType.Colon) then
      failwith "Not a colon after object key"

    else
      let par = parser_next par in
      let par, is_valid = is_valid_object_value par.curr par in
      if not is_valid then
        failwith "Not a valid object value"

    else
      if expect_type par.peek TokenType.Comma then
        let par = parser_next par in (* Curr is comma *)
        let par = parser_next par in (* Curr is next key *)
        parse_object_body par

      else
        par, true (* Curr is value of key/value pair *)


(* token option -> parser -> parser * bool *)
and is_valid_object_value (token: Token.t option) (par: t): t * bool =
  if Option.is_none token then
    par, false
  else
    let token = Option.get token in
    match token.token_type with
    | TokenType.String | TokenType.Bool | TokenType.Null | TokenType.Number -> par, true
    | TokenType.OpenBrace -> parse_object par
    | TokenType.OpenBracket -> parse_array par
    | _ -> par, false

and parse_array (par: t): t * bool =
  let par = parser_next par in
  if expect_type par.curr TokenType.CloseBracket then
    par, true

  else
    let par, is_valid = parse_array_body par in
    if not is_valid then
      failwith "Not a valid array body"

    else
      let par = parser_next par in
      match par.curr with
      | None -> failwith "Unexpected end of input: nothing after array body"
      | Some curr_token ->
          if curr_token.token_type <> TokenType.CloseBracket then
            failwith "Not a CloseBracket after array body"

          else
            par, true

and parse_array_body (par: t): t * bool =
  if not (is_valid_array_element par.curr) then (
    if Option.is_none par.curr then
      failwith "Unexpected end of input: Input ended in the middle of array body"
    else
      let token_type = TokenType.to_string (Option.get par.curr).token_type in
      Printf.printf "Invalid token found when parsing the array: `%s`\n" token_type;
      failwith "Invalid token in the array body"
  )

  else
    let curr_token_type = (Option.get par.curr).token_type in
    match curr_token_type with
    | TokenType.OpenBrace -> failwith "Not implemented: parse_array_body OpenBrace"
    | TokenType.OpenBracket -> failwith "Not implemented: parse_array_body OpenBracket"
    | TokenType.String
    | TokenType.Bool
    | TokenType.Null
    | TokenType.Number -> (
      match par.peek with
      | None -> failwith "Unexpected end of input: close bracket not found after array body"
      | Some peek_token ->
        match peek_token.token_type with
        | TokenType.CloseBracket -> par, true
        | TokenType.Comma -> (
          let par = parser_next par in (* curr is comma *)
          let par = parser_next par in (* curr is next_value *)
          parse_array_body par
        )
        | _ -> failwith "Invalid token in the array body"
    )
    | _ -> par, false


and is_valid_array_element token =
  match token with
  | None -> false
  | Some token ->
      match token.token_type with
      | TokenType.String
      | TokenType.Bool
      | TokenType.Null
      | TokenType.Number
      | TokenType.OpenBrace
      | TokenType.OpenBracket -> true
      | _ -> false

let parse_input (par: t): bool =
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
