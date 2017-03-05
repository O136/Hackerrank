let read_floats () =
    let re = Str.regexp "[ \t]+" in
    List.map float_of_string (Str.split re (read_line ()))

        
let get_x_and_y () = 
    let rec _get_xy accx accy = 
    try let l = read_floats() in
    _get_xy ((List.nth l 0) :: accx) ((List.nth l 1) :: accy)
    with End_of_file -> accx, accy
    in _get_xy [] []
        
let calc_area xp yp =
    let first_x, first_y = List.nth xp 0, List.nth yp 0 in  
    
    let rec _calc_area xp yp x_old y_old sum = match xp, yp with 
    | x_new :: tx, y_new :: ty -> 
        _calc_area tx ty x_new y_new (sum +. x_old *. y_new -. y_old *. x_new)
    | [], _ | _::_, [] -> 
        abs_float(0.5 *. (sum +. x_old *. first_y -. y_old *. first_x))
    in _calc_area xp yp first_x first_y 0.
    
let _ = 
    let _ = read_int () in
    let xp , yp = get_x_and_y () in
    print_float (calc_area xp yp)
