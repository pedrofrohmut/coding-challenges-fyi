type t =
  | OpenBrace
  | CloseBrace
  | OpenBracket
  | CloseBracket

  | Colon
  | Comma

  | String
  | Unknown

let to_string = function
  | OpenBrace -> "OpenBrace"
  | CloseBrace -> "CloseBrace"
  | OpenBracket -> "OpenBracket"
  | CloseBracket -> "CloseBracket"

  | Colon -> "Colon"
  | Comma -> "Comma"

  | String -> "String"
  | Unknown -> "Unknown"
