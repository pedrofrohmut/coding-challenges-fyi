#!/usr/bin/env utop

#directory "+unix";;

let rec match_output_lines (a_lines: string list) (b_lines: string list): unit =
  match a_lines, b_lines with
  | [], [] -> ()

  | [], _ | _, [] -> failwith "Unmatch: Output have different number of lines"

  | a :: at, b :: bt ->
     if a = b then
       match_output_lines at bt
     else
       begin
         prerr_endline @@ Printf.sprintf "Lines are different. \n\twc: `%s` \n\tmy: `%s`\n" a b;
         failwith "Unmatched lines in outputs"
       end
;;

let e2e_test (cmd_a: string) (cmd_b: string): unit =
  let (in_chan, out_chan) = Unix.open_process cmd_a in
  close_out out_chan;
  let wc_lines = In_channel.input_lines in_chan in
  close_in in_chan;
  let _ = Unix.wait () in

  let (in_chan, out_chan) = Unix.open_process cmd_b in
  close_out out_chan;
  let my_lines = In_channel.input_lines in_chan in
  close_in in_chan;
  let _ = Unix.wait () in

  let wc_len = List.length wc_lines in
  let my_len = List.length my_lines in
  if wc_len <> my_len then
    failwith @@
      Printf.sprintf
        "Original tool and your tool output have different lengths.\n \tExpected: %d, but got: %d instead.\n"
        wc_len
        my_len
  else
    match_output_lines wc_lines my_lines
;;

let test_help (my_cmd: string): unit =
  e2e_test "wc --help" (my_cmd ^ " --help")
;;

let test_version (my_cmd: string): unit =
  e2e_test "wc --version" (my_cmd ^ " --version")
;;

let test_wc_count_bytes (my_cmd: string) (file: string): unit =
  e2e_test ("wc --bytes " ^ file) (my_cmd ^ " --bytes " ^ file)
;;

let test_wc_count_lines (my_cmd: string) (file: string): unit =
  e2e_test ("wc --lines " ^ file) (my_cmd ^ " --lines " ^ file)
;;

let test_wc_count_words (my_cmd: string) (file: string): unit =
  e2e_test ("wc --words " ^ file) (my_cmd ^ " --words " ^ file)
;;

let () =
  let my_wc = "./_build/default/wc.exe" in
  let man_file = "./man_wc.txt" in
  let test_file = "./test.txt" in

  (* Step One *)
  test_wc_count_bytes my_wc man_file;
  test_wc_count_bytes my_wc test_file;

  (* Step Two *)
  test_wc_count_lines my_wc man_file;
  test_wc_count_lines my_wc test_file;

  (* Step Three *)
  test_wc_count_words my_wc man_file;
  test_wc_count_words my_wc test_file;

  print_endline "All test passed with not errors"
;;
