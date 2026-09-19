# Json Parser TODOS - Ocaml

[ ] - Remake the json parser to instead of just validation also make an output as
a recursive list
  type t =
    | Null
    | Bool of bool
    | Number of float
    | String of string
    | Array of t list
    | Object of (string * t) list
[ ] - The json parser should have good error messages that explain what it does
and also where is the error. Maybe track the line and char in the lexer.
