#!/usr/bin/env utop

#directory "+unix";;

open Unix;;

let my_wc = "./_build/default/wc.exe";;

let foo () =
  let (in_chan, out_chan) = Unix.open_process "wc ./man_wc.txt" in
  close_out out_chan;

  let output = input_line in_chan in
  close_in in_chan;

  let _ = Unix.wait () in
  Printf.printf "Output: %s\n" output
;;

let test_help () =
  let (in_chan, out_chan) = Unix.open_process "wc --help" in
  close_out out_chan;
  let wc_lines = In_channel.input_lines in_chan in
  close_in in_chan;
  let _ = Unix.wait () in

  let (in_chan, out_chan) = Unix.open_process (my_wc ^ " --help") in
  close_out out_chan;
  let my_lines = In_channel.input_lines in_chan in
  close_in in_chan;
  let _ = Unix.wait () in

  let wc_len = List.length wc_lines in
  let my_len = List.length my_lines in
  if wc_len <> my_len then
    begin
      Printf.printf "Wc_lines length: %d, my_lines length: %d\n" wc_len my_len;
      Printf.printf "Original tool output and your tool output have different lengths\n"
    end
  else
    List.iter2 (fun a b ->
        if a = b then () else
          Printf.printf "Lines are different. \n\twc: `%s` \n\tmy: `%s`\n" a b
      ) wc_lines my_lines
;;

let () =
  test_help ()
