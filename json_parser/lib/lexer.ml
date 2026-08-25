type t = {
    cursor: int;
    input: string;
  }

let create input =
  { cursor = 0; input }

let incr_cursor lexer =
  { cursor = lexer.cursor + 1; input = lexer.input }

let cursor_to n lexer =
  { cursor = n; input = lexer.input }

let has_next lexer =
  let input_len = String.length lexer.input in
  let next_pos = lexer.cursor + 1 in
  next_pos < input_len

let get_ch lexer =
  let input_len = String.length lexer.input in
  if lexer.cursor < input_len then
    Some (String.get lexer.input lexer.cursor)
  else
    None

let get_ch_at position lexer =
  let input_len = String.length lexer.input in
  if position < input_len then
    Some (String.get lexer.input position)
  else
    None

let print_char ch =
  Printf.printf "CH: %s\n" (Char.escaped (Option.get ch))

let print_lexer lexer =
  let ch_str =
    match get_ch lexer with
    | None -> "EOF"
    | Some v -> Char.escaped v
  in
  Printf.printf "Lexer: { cursor = %d; char_at = `%s` }\n" lexer.cursor ch_str

let read_string lexer =
  let rec loop i lx =
    let ch = get_ch_at i lx in
    match ch with
    | None -> failwith "Lexer - read_string: Unexpected end of input"
    | Some '"' -> (
      (* Printf.printf "reached the closing quote at %d.\n" i; *)
      i
    )
    | Some _ -> (
       (* Printf.printf "loop ch[%d]: %c\n" i (Option.get ch); *)
       loop (i + 1) lx
    )
  in

  (* Skip the '"' *)
  let lexer = incr_cursor lexer in
  print_char @@ get_ch lexer;

  let start_pos = lexer.cursor in
  let end_pos = loop start_pos lexer in
  let lexer = cursor_to end_pos lexer in
  (* print_lexer lexer; *)
  let content = String.sub lexer.input start_pos (end_pos - start_pos) in
  lexer, content

let show_match_ch_err ch =
  Printf.printf "Lexer next_token - Error: Not implemented match for %c\n" ch

let next_token lexer =
  let ch = get_ch lexer in

  if Option.is_none ch then
    lexer, None

  else (
    let ch = Option.get ch in

    Printf.printf "Lexer_Next ch: `%s`\n" (Char.escaped ch);

    let lexer, token =
      match ch with
      | '{' -> lexer, Token.create TokenType.OpenBrace "{"
      | '}' -> lexer, Token.create TokenType.CloseBrace "}"
      | ':' -> lexer, Token.create TokenType.Colon ":"

      | '\\' -> failwith "Lexer next_token - Error: Found and back slash."

      | '"' ->
         let lexer, value = read_string lexer in
         Printf.printf "ReadString Value: `%s`\n" value;
         (* print_lexer lexer; *)
         let token = Token.create TokenType.String value in
         lexer, token

      | _ -> (
        show_match_ch_err ch;
        failwith "Lexer next_token - Error: Not implemented token match"
      )
    in

    Printf.printf "NextToken: { literal = `%s` } \n" token.literal;
    print_lexer lexer;

    let lexer = incr_cursor lexer in

    (* print_lexer lexer; *)

    lexer, Some token
  )
