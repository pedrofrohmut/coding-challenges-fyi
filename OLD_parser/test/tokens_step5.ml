open Json_parser

let pass1_tokens = [
  TokenType.OpenBracket;

  TokenType.String;
  TokenType.Comma;

  TokenType.OpenBrace;
  TokenType.String;
  TokenType.Colon;
  TokenType.OpenBracket;
  TokenType.String;
  TokenType.CloseBracket;
  TokenType.CloseBrace;
  TokenType.Comma;

  TokenType.OpenBrace;
  TokenType.CloseBrace;
  TokenType.Comma;

  TokenType.OpenBracket;
  TokenType.CloseBracket;
  TokenType.Comma;

  TokenType.Number;
  TokenType.Comma;

  TokenType.Bool;
  TokenType.Comma;

  TokenType.Bool;
  TokenType.Comma;

  TokenType.Null;
  TokenType.Comma;

  TokenType.OpenBrace;
  TokenType.String;
  TokenType.Colon;
  TokenType.Number;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.Number;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.Number;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.Number;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.Number;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.Number;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.Number;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.String;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.String;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.String;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.String;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.String;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.String;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.String;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.String;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.String;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.String;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.String;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.String;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.String;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.Bool;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.Bool;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.Null;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.OpenBracket;
  TokenType.CloseBracket;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.OpenBrace;
  TokenType.CloseBrace;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.String;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.String;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.String;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.String;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.OpenBracket;
  TokenType.Number;
  TokenType.Comma;
  TokenType.Number;
  TokenType.Comma;
  TokenType.Number;
  TokenType.Comma;
  TokenType.Number;
  TokenType.Comma;
  TokenType.Number;
  TokenType.Comma;
  TokenType.Number;
  TokenType.Comma;
  TokenType.Number;
  TokenType.CloseBracket;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.OpenBracket;
  TokenType.Number;
  TokenType.Comma;
  TokenType.Number;
  TokenType.Comma;
  TokenType.Number;
  TokenType.Comma;
  TokenType.Number;
  TokenType.Comma;
  TokenType.Number;
  TokenType.Comma;
  TokenType.Number;
  TokenType.Comma;
  TokenType.Number;
  TokenType.CloseBracket;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.String;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.String;
  TokenType.Comma;

  TokenType.String;
  TokenType.Colon;
  TokenType.String;
  TokenType.CloseBrace;
  TokenType.Comma;

  TokenType.Number;
  TokenType.Comma;

  TokenType.Number;
  TokenType.Comma;

  TokenType.Number;
  TokenType.Comma;

  TokenType.Number;
  TokenType.Comma;

  TokenType.Number;
  TokenType.Comma;

  TokenType.Number;
  TokenType.Comma;

  TokenType.Number;
  TokenType.Comma;

  TokenType.Number;
  TokenType.Comma;

  TokenType.Number;
  TokenType.Comma;

  TokenType.Number;
  TokenType.Comma;

  TokenType.String;

  TokenType.CloseBracket;
]
