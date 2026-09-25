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

let next_token (par: t): t =
  let curr = par.peek in
  let lex, peek = Lexer.next_token par.lex in
  { lex; curr; peek }

let is_tokenopt_of (token: Token.t option) (token_type: Token_type.t): bool =
  match token with
  | None -> false
  | Some token -> token.token_type = token_type

let to_tokentype_string (token: Token.t option): string =
  match token with
  | None -> "None"
  | Some token -> Token_type.to_string token.token_type

let parse_object (par: t): t * ((Output.t, string) result) =
  let output = Output.Object [] in

  if not (is_tokenopt_of par.curr Token_type.OpenBrace) then
    let err = Printf.sprintf "Invalid first token for parse_object. Expected %s, but got %s instead."
                (Token_type.to_string Token_type.OpenBrace)
                (to_tokentype_string par.curr) in
    par, Error err

  else
    let par = next_token par in
    if not (is_tokenopt_of par.curr Token_type.CloseBrace) then
      let err = Printf.sprintf "Invalid last token for parse_object. Expected %s, but got %s instead."
                  (Token_type.to_string Token_type.CloseBrace)
                  (to_tokentype_string par.curr) in
      par, Error err

    else
      par, Ok output

let run (par: t): (Output.t, string) result =
  match par.curr with
  | None -> Error "Empty json"
  | Some token ->
     match token.token_type with
     | Token_type.OpenBrace -> let _, result = parse_object par in result
     | _ -> failwith "Invalid or not covered token found at parser run, matching the first token"
