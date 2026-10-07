open Json_parser

let pass1_tokens = [
  Token_type.OpenBracket;
  Token_type.String; Token_type.Comma;
  Token_type.OpenBrace;
  Token_type.String; Token_type.Colon;
  Token_type.OpenBracket;
  Token_type.String;
  Token_type.CloseBracket;
  Token_type.CloseBrace; Token_type.Comma;
  Token_type.OpenBrace; Token_type.CloseBrace; Token_type.Comma;
  Token_type.OpenBracket; Token_type.CloseBracket; Token_type.Comma;
  Token_type.Number; Token_type.Comma;
  Token_type.Bool; Token_type.Comma;
  Token_type.Bool; Token_type.Comma;
  Token_type.Null; Token_type.Comma;

  Token_type.OpenBrace;
  Token_type.String; Token_type.Colon; Token_type.Number; Token_type.Comma;
  Token_type.String; Token_type.Colon; Token_type.Number; Token_type.Comma;
  Token_type.String; Token_type.Colon; Token_type.Number; Token_type.Comma;
  Token_type.String; Token_type.Colon; Token_type.Number; Token_type.Comma;
  Token_type.String; Token_type.Colon; Token_type.Number; Token_type.Comma;
  Token_type.String; Token_type.Colon; Token_type.Number; Token_type.Comma;
  Token_type.String; Token_type.Colon; Token_type.Number; Token_type.Comma;

  Token_type.String; Token_type.Colon; Token_type.String; Token_type.Comma;
  Token_type.String; Token_type.Colon; Token_type.String; Token_type.Comma;
  Token_type.String; Token_type.Colon; Token_type.String; Token_type.Comma;
  Token_type.String; Token_type.Colon; Token_type.String; Token_type.Comma;
  Token_type.String; Token_type.Colon; Token_type.String; Token_type.Comma;
  Token_type.String; Token_type.Colon; Token_type.String; Token_type.Comma;
  Token_type.String; Token_type.Colon; Token_type.String; Token_type.Comma;
  Token_type.String; Token_type.Colon; Token_type.String; Token_type.Comma;
  Token_type.String; Token_type.Colon; Token_type.String; Token_type.Comma;
  Token_type.String; Token_type.Colon; Token_type.String; Token_type.Comma;
  Token_type.String; Token_type.Colon; Token_type.String; Token_type.Comma;

  Token_type.String; Token_type.Colon; Token_type.Bool; Token_type.Comma;
  Token_type.String; Token_type.Colon; Token_type.Bool; Token_type.Comma;

  Token_type.String; Token_type.Colon; Token_type.Null; Token_type.Comma;

  Token_type.String; Token_type.Colon; Token_type.OpenBracket; Token_type.CloseBracket; Token_type.Comma;
  Token_type.String; Token_type.Colon; Token_type.OpenBrace; Token_type.CloseBrace; Token_type.Comma;

  Token_type.String; Token_type.Colon; Token_type.String; Token_type.Comma;
  Token_type.String; Token_type.Colon; Token_type.String; Token_type.Comma;
  Token_type.String; Token_type.Colon; Token_type.String; Token_type.Comma;
  Token_type.String; Token_type.Colon; Token_type.String; Token_type.Comma;

  Token_type.String; Token_type.Colon;
  Token_type.OpenBracket;
  Token_type.Number; Token_type.Comma;
  Token_type.Number; Token_type.Comma;
  Token_type.Number; Token_type.Comma;
  Token_type.Number; Token_type.Comma;
  Token_type.Number; Token_type.Comma;
  Token_type.Number; Token_type.Comma;
  Token_type.Number;
  Token_type.CloseBracket; Token_type.Comma;

  Token_type.String; Token_type.Colon;
  Token_type.OpenBracket;
  Token_type.Number; Token_type.Comma;
  Token_type.Number; Token_type.Comma;
  Token_type.Number; Token_type.Comma;
  Token_type.Number; Token_type.Comma;
  Token_type.Number; Token_type.Comma;
  Token_type.Number; Token_type.Comma;
  Token_type.Number;
  Token_type.CloseBracket; Token_type.Comma;

  Token_type.String; Token_type.Colon; Token_type.String; Token_type.Comma;
  Token_type.String; Token_type.Colon; Token_type.String; Token_type.Comma;
  Token_type.String; Token_type.Colon; Token_type.String;

  Token_type.CloseBrace; Token_type.Comma;

  Token_type.Number; Token_type.Comma;
  Token_type.Number; Token_type.Comma;
  Token_type.Number; Token_type.Comma;
  Token_type.Number; Token_type.Comma;
  Token_type.Number; Token_type.Comma;
  Token_type.Number; Token_type.Comma;
  Token_type.Number; Token_type.Comma;
  Token_type.Number; Token_type.Comma;
  Token_type.Number; Token_type.Comma;
  Token_type.Number; Token_type.Comma;
  Token_type.String;

  Token_type.CloseBracket;
]
