let _ =
    let rec loop ls acc = 
        try loop (read_int()::ls) (acc+1) with End_of_file -> print_int acc
    in loop [] 0
