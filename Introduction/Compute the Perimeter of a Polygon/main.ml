type point2D = {x: float; y: float}

let read_floats () =
    let re = Str.regexp "[ \t]+" in
    List.map float_of_string (Str.split re (read_line ()))

let euclidean_distance p1 p2 = 
    let x = p1.x -. p2.x in
    let y = p1.y -. p2.y in 
    sqrt (x*.x +. y*.y) 

let get_points nr_points  =
    let rec _get_points nr_points acc =  
        if nr_points = 0 then acc else
        let floats = read_floats () in 
        _get_points (nr_points - 1) ({x=List.nth floats 0;y=List.nth floats 1}::acc) 
        in _get_points nr_points []

(*let points = get_points nr_points;;*)

let calc_perim points =
        let first_point = List.nth points 0 in
        let rec _calc_perim points sum p1 = match points with
            | p2 :: t -> _calc_perim t (sum +. euclidean_distance p1 p2) (p2)
            | [] -> sum +. euclidean_distance p1 first_point
        in _calc_perim points 0. first_point

let _ = 
    let nr_points = read_int () in
    let points = get_points nr_points in
    print_float (calc_perim points)

