let my_fun1 (str: string): string =
  let seq = String.to_seq str in
  let seq =
    Seq.concat_map (fun ch -> if ch <> 'o' then Seq.return ch else List.to_seq ('1':: '2' :: '3' :: [])) seq
  in
  String.of_seq seq
;;


(* val fold_left : ('acc -> char -> 'acc) -> 'acc -> string -> 'acc *)
let my_fun2 (str: string): string =
  String.fold_left (fun acc ch ->
    if ch <> 'o' then
      ch :: acc
    else
      'a' :: 'a' :: acc
  ) [] str
  |> List.rev
  |> List.to_seq
  |> String.of_seq
;;

let handle_string_escapes (content: string): string =
  let handle_char_escape acc ch =
    match ch with
    | '"' -> '"' :: '\\'  :: acc
    | _ -> ch :: acc
  in
  String.fold_left handle_char_escape [] content
  |> List.rev
  |> List.to_seq
  |> String.of_seq
;;
