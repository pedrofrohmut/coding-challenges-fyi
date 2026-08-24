type t = {
    cursor: int;
    input: string;
  }

let create input =
  { cursor = 0; input }

let incr_cursor t =
  { cursor = t.cursor + 1; input = t.input }

let incr_cursor_by n t =
  { cursor = t.cursor + n; input = t.input }


let has_next t =
  let input_len = String.length t.input in
  let next_pos = t.cursor + 1 in
  next_pos < input_len

let get_ch t =
  let input_len = String.length t.input in
  if t.cursor < input_len then
    Some (String.get t.input t.cursor)
  else
    None

let read_string lexer =
  let rec reach_end lx =
    let ch = get_ch lx in
    match ch with
    | None -> failwith "Lexer - read_string: Unexpected end of input"
    | Some '"' -> lx
    | Some _ ->
       let inc_lx = incr_cursor lexer in
       reach_end inc_lx
  in

  (* Skip first '"' *)
  let lexer = incr_cursor lexer in

  (* Get a start position and a lexer at ending '"' *)
  let start = lexer.cursor in
  let lexer = reach_end lexer in
  let count = lexer.cursor - start in

  String.sub lexer.input start count

let next_token lexer =
  let ch = get_ch lexer in

  if Option.is_none ch then
    lexer, None

  else (
    let ch = Option.get ch in

    Printf.printf "Lexer_Next ch: `%s`\n" (Char.escaped ch);

    (* TODO: key, colon, string *)
    let token =
      match ch with
      | '{' -> Token.create TokenType.OpenBrace "{"
      | '}' -> Token.create TokenType.CloseBrace "}"
      (* | ':' -> Token.create TokenType.Colon ":" *)
      (* | '\\' -> failwith "Lexer next_token - Error: Found and back slash." *)
      (* | '"' -> *)
      (*    (\* TODO return the new lexer *\) *)
      (*    let value = read_string lexer in *)
      (*    Printf.printf "ReadString Value: `%s`\n" value; *)
      (*    Token.create TokenType.String value *)
      | _ -> failwith "Lexer next_token - Error: Not implemented token match"
    in

    let lexer = incr_cursor lexer in

    lexer, Some token
  )
