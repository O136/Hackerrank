(* Enter your code here. Read input from STDIN. Print output to STDOUT *)

let epow x = 
let rec e_x acc1 acc2 terms = 
    if terms = 11 then print_float acc1 
    else e_x (acc1+.acc2) (acc2*.x/.(float_of_int terms)) (terms+1)
    in e_x 0. 1. 1
    

let _ = 
    let n = read_int() in
    let rec read acc n = 
        if n = 0 then List.fold_right (fun x () -> epow x; print_string "\n") acc ()
        else read (read_float():: acc) (n-1) 
    in read [] n
