(* Use this private syntax so you can access the field with 'my_token.literal'
   instead of using getters (that are more verbose doing the same thing) *)
type t = private {
  token_type: Token_type.t;
  literal: string;
}
