NB. day10_2 '/absolute/path/to/file'
day10_2=: 3 : 0
    map=. > cutopen toJ 1!:1 < y
    h=. {. $ map
    w=. {: $ map 
    i=. ('#'=,map) # i. $ , map
    coord=. ( <@:((<.@:%&h),(w&|])) )"0 i
    pair=. ([ ,. ] -. [)"(0 1)~ coord
    rr=. rise_run/"1 pair
    a=. ang/"1 |."1 rr
    cnt=. > (#@:~.)&.> <"1 a

    c_max=. ({. \: cnt) { coord
    i_max=. coord i. c_max
    copy=. 0 i_max } ($ coord) $ 1
    coord_max=. copy # coord
    ang_max=. i_max { a
    ang_max_pos =. (]`((o.@:2:) + ])@.(0 > ]))"0 ang_max
    rr_max=. i_max { rr
    aim=. {. default_aim ang_max_pos
    '' laser (coord_max;ang_max;rr_max;aim)
)

NB. destroyed laser (coords;angles;rise_runs;aim)
laser=: 4 : 0
    coord=.>0{y
    rad=.>1{y
    rr=.>2{y
    aim=.>3{y

    rr_target=.(rad = aim) # rr
    rr_destroy=. < ({. /: +/"1 rr_target) { rr_target
    i_destroy=. (<"1 rr) i. rr_destroy
    c_destroy=. < < |. > i_destroy { coord

    if. 200 = #x do.
        > > x
    else.
        new_copy=. 0 i_destroy } ($ coord) $ 1
        new_coord=. new_copy # coord
        new_rad=. new_copy # rad
        new_rr =. new_copy # rr
        new_aim=. 1 { (default_aim rad) rot_til aim

        (x ,  c_destroy) laser (new_coord;new_rad;new_rr;new_aim)
    end.
)
default_aim=: 3 : 0
    sorted_ang=. (\: y) { y
    half_pi=.o.0.5
    init=. ([: $: 1&|.)`(])@.(half_pi&>:@:{.)
    aim=. init sorted_ang
    ~. aim
)
rot_til=: ((1: |. [) rot_til ])`([)@.(({.@:[) = ])

rise_run=: 4 : '(_1 1)* -/"1 (>y),.>x'
    ang=: 4 : 0
    at=. arctan y % x
    if. x > 0 do.
        at
    elseif. (x < 0) *. (y >: 0) do.
        at + o. 1
    elseif. (x < 0) *. (y < 0) do.
        at - o. 1
    elseif. (x = 0) *. (y > 0) do.
        (o. 1) % 2
    elseif. (x = 0) *. (y < 0) do.
        -(o. 1) % 2
    end.
)
