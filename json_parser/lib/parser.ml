open Printf

module Output = struct
  type key = Key of string

  type t =
    | Null
    | Bool of bool
    | Number of float
    | String of string
    | Object of (key * t) list
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

let is_token_of (token: Token.t option) (token_type: Token_type.t): bool =
  match token with
  | None -> false
  | Some token -> token.token_type = token_type

let to_tokentype_string (token: Token.t option): string =
  match token with
  | None -> "None"
  | Some token -> Token_type.to_string token.token_type


let rec parse_object (par: t): t * Output.t =
  let output = Output.Object [] in

  if not (is_token_of par.curr Token_type.OpenBrace) then
    failwith (sprintf "Invalid first token for parse_object. Expected %s, but got %s instead."
                (Token_type.to_string Token_type.OpenBrace)
                (to_tokentype_string par.curr))

  else
    let par = next_token par in
    if is_token_of par.curr Token_type.CloseBrace then
      (* Case: empty object *)
      par, output

    else
      let par, body = parse_object_body par in
      let output = Output.Object body in
      let par = next_token par in
      if not (is_token_of par.curr Token_type.CloseBrace) then
        failwith (sprintf "Invalid last token for parse_object. Expected %s, but got %s instead."
                    (Token_type.to_string Token_type.CloseBrace)
                    (to_tokentype_string par.curr))

      else
        par, output

and parse_object_body (par: t): t * (Output.key * Output.t) list =
  let rec loop acc par =
    if not (is_token_of par.curr Token_type.String) then
      failwith (sprintf "Expected String token for the object key but got `%s` instead." (to_tokentype_string par.curr))

    else
      let key = Output.Key (Option.get par.curr).literal in
      let par = next_token par in
      if not (is_token_of par.curr Token_type.Colon) then
        failwith (sprintf "Expected Colon after key but got `%s` instead." (to_tokentype_string par.curr))

      else
        let par = next_token par in
        let par, value = parse_value par in
        let acc = (key, value) :: acc in

        if is_token_of par.peek Token_type.CloseBrace then
          (* Case: found the object closing character *)
          par, List.rev acc

        else
          let par = next_token par in
          if not (is_token_of par.curr Token_type.Comma) then
            failwith (sprintf "Expected Comma after the value of key/value pair of an object when this object is not closed yet. Got a token of `%s`" (to_tokentype_string par.curr))

          else
            let par = next_token par in (* curr should be next key *)
            loop acc par
  in
  loop [] par

and parse_value (par: t): t * Output.t =
  match par.curr with
  | None -> failwith "End of input reached while trying to parse a value"
  | Some token ->
     match token.token_type with
     | Token_type.OpenBrace -> parse_object par
     | Token_type.OpenBracket -> parse_array par
     | Token_type.String -> par, Output.String token.literal
     | Token_type.Bool -> par, Output.Bool (bool_of_string token.literal)
     | Token_type.Null -> par, Output.Null
     | Token_type.Number ->
        let num = float_of_string_opt token.literal in
        if Option.is_none num then
          failwith "Invalid number found in the token literal trying to parse a value"
        else
          par, Output.Number (Option.get num)
     | _ -> failwith (sprintf "Unsupported or invalid token type for object value. Got a token of `%s` with value `%s` while trying to parse a value." (to_tokentype_string par.curr) token.literal)

and parse_array (par: t): t * Output.t =
  let rec loop acc par =
    if is_token_of par.curr Token_type.CloseBracket then
      par, List.rev acc
    else
      let par, value = parse_value par in
      let par = next_token par in
      let acc = value :: acc in
      loop acc par
  in
  let par = next_token par in (* jump to the first value of the array or the close bracket *)
  let par, arr_body = loop [] par in
  par, Output.Array arr_body

let run (par: t): (Output.t, string) result =
  match par.curr with
  | None -> Error "Empty json"
  | Some token ->
     match token.token_type with
     | Token_type.OpenBrace -> (
        try
          let _, output = parse_object par in
          Ok output
        with
          Failure msg -> Error msg
     )
     | _ -> Error "Invalid or not covered token found at parser run, matching the first token"
