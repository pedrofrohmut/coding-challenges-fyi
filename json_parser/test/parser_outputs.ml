open Json_parser

module Out = Parser.Output

let pass1_output = Out.Array [
  Out.String "JSON Test Pattern pass1";

  Out.Object [
    Out.Key "object with 1 member", Out.Array [ Out.String "array with 1 element" ];
  ];

  Out.Object [];

  Out.Array [];

  Out.Number (-42.0);

  Out.Bool true;

  Out.Bool false;

  Out.Null;

  Out.Object [
    Out.Key "integer",          Out.Number 1234567890.0;
    Out.Key "real",             Out.Number (-9876.543210);
    Out.Key "e",                Out.Number 0.123456789e-12;
    Out.Key "E",                Out.Number 1.234567890e34;
    Out.Key "",                 Out.Number 23456789012e66;
    Out.Key "zero",             Out.Number 0.0;
    Out.Key "one",              Out.Number 1.0;
    Out.Key "space",            Out.String " ";
    Out.Key "quote",            Out.String "\"";
    Out.Key "backslash",        Out.String "\\";

    (* Out.Key "controls",         Out.String "\b\f\n\r\t"; *)
    Out.Key "controls",         Out.String "\b\x0C\n\r\t";

    Out.Key "slash",            Out.String "/ & \\/";
    Out.Key "alpha",            Out.String "abcdefghijklmnopqrstuvwyz";
    Out.Key "ALPHA",            Out.String "ABCDEFGHIJKLMNOPQRSTUVWYZ";
    Out.Key "digit",            Out.String "0123456789";
    Out.Key "0123456789",       Out.String "digit";
    Out.Key "special",          Out.String "`1~!@#$%^&*()_+-={':[,]}|;.</>?";
    Out.Key "hex",              Out.String "\u{0123}\u{4567}\u{89AB}\u{CDEF}\u{abcd}\u{ef4A}";
    Out.Key "true",             Out.Bool true;
    Out.Key "false",            Out.Bool false;
    Out.Key "null",             Out.Null;
    Out.Key "array",            Out.Array [];
    Out.Key "object",           Out.Object [];
    Out.Key "address",          Out.String "50 St. James Street";
    Out.Key "url",              Out.String "http://www.JSON.org/";
    Out.Key "comment",          Out.String "// /* <!-- --";
    Out.Key "# -- --> */",      Out.String " ";

    Out.Key " s p a c e d ",    Out.Array [
                                  Out.Number 1.0; Out.Number 2.0; Out.Number 3.0;
                                  Out.Number 4.0; Out.Number 5.0; Out.Number 6.0;
                                  Out.Number 7.0;
                                ];

    Out.Key "compact",          Out.Array [
                                  Out.Number 1.0; Out.Number 2.0; Out.Number 3.0;
                                  Out.Number 4.0; Out.Number 5.0; Out.Number 6.0;
                                  Out.Number 7.0;
                                ];

    Out.Key "jsontext",         Out.String "{\"object with 1 member\":[\"array with 1 element\"]}";
    Out.Key "quotes",           Out.String "&#34; \u{0022} %22 0x22 034 &#x22;";

    (* Out.Key "\"\\\u{CAFE}\u{BABE}\u{AB98}\u{FCDE}\u{bcda}\u{ef4A}\b\f\n\r\t`1~!@#$%^&*()_+-=[]{}|;:',./<>?", *)
    Out.Key "\"\\\u{CAFE}\u{BABE}\u{AB98}\u{FCDE}\u{bcda}\u{ef4A}\b\x0C\n\r\t`1~!@#$%^&*()_+-=[]{}|;:',./<>?",
                                Out.String "A key can be any string";
  ];

  Out.Number 0.5;
  Out.Number 98.6;
  Out.Number 99.44;
  Out.Number 1066.0;
  Out.Number 1e1;
  Out.Number 0.1e1;
  Out.Number 1e-1;
  Out.Number 1e00;
  Out.Number 2e+00;
  Out.Number 2e-00;

  Out.String "rosebud";
]

let pass1_alt_output = Out.Array [
  Out.String "JSON Test Pattern pass1";
  Out.Object [
    Out.Key "object with 1 member", Out.Array [ Out.String "array with 1 element" ];
  ];
  Out.Object [];
  Out.Array [];
  Out.Number (-42.0);
  Out.Bool true;
  Out.Bool false;
  Out.Null;
  Out.Object [
    Out.Key "integer",          Out.Number 1234567890.0;
    Out.Key "real",             Out.Number (-9876.543210);
    Out.Key "e",                Out.Number 0.123456789e-12;
    Out.Key "E",                Out.Number 1.234567890e34;
    Out.Key "",                 Out.Number 23456789012e66;
    Out.Key "zero",             Out.Number 0.0;
    Out.Key "one",              Out.Number 1.0;
    Out.Key "space",            Out.String " ";
    Out.Key "quote",            Out.String "\\\"";
    Out.Key "backslash",        Out.String "\\\\";
    Out.Key "controls",         Out.String "\\b\\f\\n\\r\\t";
  ]
]

let pass1_alt2_output = Out.Object [
  Out.Key "quote",            Out.String "\\\"";
  Out.Key "backslash",        Out.String "\\\\";
]
