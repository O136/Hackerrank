let remove_dup s =
  let t = Hashtbl.create 26 in
  String.iter (fun c ->
  if Hashtbl.mem t c then () else (Hashtbl.add t c true; print_char c)) s

let () =
    remove_dup (read_line())

