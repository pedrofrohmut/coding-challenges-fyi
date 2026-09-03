type t =
  | OpenBrace
  | CloseBrace
  | OpenBracket
  | CloseBracket

  | Colon
  | Comma

  | Unknown
  | String
  | Bool
  | Null
  | Number

let to_string = function
  | OpenBrace -> "OpenBrace"
  | CloseBrace -> "CloseBrace"
  | OpenBracket -> "OpenBracket"
  | CloseBracket -> "CloseBracket"

  | Colon -> "Colon"
  | Comma -> "Comma"

  | Unknown -> "Unknown"
  | String -> "String"
  | Bool -> "Bool"
  | Null -> "Null"
  | Number -> "Number"
