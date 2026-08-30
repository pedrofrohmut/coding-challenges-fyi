let is_whitespace = function
  | ' ' | '\r' | '\t' | '\n' -> true
  | _ -> false

let split_string sep src =
  let sep_len = String.length sep in
  let src_len = String.length src in
  let limit = src_len - sep_len in
  let sep_first = String.get sep 0 in

  let rec loop i =
    if i = limit then
      None
    else
      let curr = String.get src i in
      if curr <> sep_first then
        loop (i + 1)
    else
      let start = i in
      let count = sep_len in
      let src_sub = String.sub src start count in
      if src_sub <> sep then
        loop (i + 1)
      else
        let before = String.sub src 0 start in
        let rest = String.sub src start (src_len - start) in
        Some (before, rest)
  in
  loop 0
