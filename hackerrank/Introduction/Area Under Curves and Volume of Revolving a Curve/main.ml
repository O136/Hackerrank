let read_floats () =
    let re = Str.regexp "[ \t]+" in
    List.map float_of_string (Str.split re (read_line ()))

let pi = 3.14159265358979312;;
let coef = read_floats ();;
let pow = read_floats ();;
let limits = read_floats ();;
let a = List.nth limits 0;; (*ugly code, but ocaml is not beautiful either, also very poor ressources on every topic*)
let b = List.nth limits 1;;


let area l r coef pow step =
    let rec _eval l acc n  = (*we need an inclusive *)
        if n = -1 then step *. acc else 
        _eval (l +. step) (acc +. List.fold_left2 (fun s c p -> s +. c *. (l**p)) 0. coef pow ) (n-1)
        in _eval l 0. (int_of_float ((r-.l)/.step))

let volume l r coef pow step =
    let rec _eval l acc n  = (*we need an inclusive *)
        if n = -1 then pi *. step *. acc else 
        let r = List.fold_left2 (fun s c p -> s +. c *. (l**p)) 0. coef pow in
        _eval (l +. step) (acc +. r *. r) (n-1)
        in _eval l 0. (int_of_float ((r-.l)/.step))

let _ =
    print_float (area a b coef pow 0.001);
    print_char '\n';
    print_float (volume a b coef pow 0.001);
