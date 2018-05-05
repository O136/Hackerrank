let rotate s =
  let n = String.length s in 
  let rec rotate' i = 
    if i < 0 then () else (
      print_string (Str.string_after s (n-i)); 
      print_string (Str.string_before s (n-i));
      print_char ' '; 
      rotate' (i-1)
    ) in rotate' (n-1)
    
    
let () =
    for n=1 to read_int () do
    rotate (read_line ());
    print_char '\n';
    done;
