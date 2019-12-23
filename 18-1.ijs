Day18_1=: 3 : 0
  map=. > Read_from_file a
  one_dim_map=. , map
  one_dim_i=. i. $ one_dim_map
  i_start=. one_dim_map i. '@'
  pos_start=. (<. i_start % {: $ map) , ({: $ map) | i_start
  num_key=. +/ 97 <: a. i. one_dim_map
  state=. sln=. pos_start;'';0 NB. postion;key;distance
  history=. 0 2 $ '' NB. position;key
  queue=. 1 3 $ state
  while. -.0=#queue do.
    s=. sln=. {. queue
    queue=. }. queue
    if. num_key = # >1{s do. break. end.
    hs=. map get_next_hs history;<s
    history=. > {. hs
    queue=. queue , > {: hs
  end.
  sln
)
get_next_hs=: 4 : 0
  h=. >{.y
  s=. >{:y
  p=. >{.s
  kd=. }.s
  ps=. rm_empty_state h erase_past"_ 1 (p +"1 (_1 0),(1 0),(0 _1),:(0 1)) ;"1 kd NB. next possible state
  vs=. rm_empty_state x validate_state"_ 1 ps
  uh=. h , }:"1 vs
  uh ; < vs
)
erase_past=: 4 : 0
  (3 $ a:) [`]@.((#x)=x i. }:y) y
)
validate_state=: 4 : 0
  p=. >0{y
  k=. >1{y
  d=. >: >2{y
  if. (+/ p < 0 0) +. (+/ p >: $ x) do. NB. out of bounds
    3 $ a:
  elseif. '#' = (< p) { x do. NB. wall
    3 $ a:
  elseif. 1 = +/ '.@' = (< p) { x do. NB. empty space
    p;k;d
  elseif. 97 <: a=. a. i. (< p) { x do. NB. key
    p ; ((/: { ]) k ,`[@.(+/k=a) a) ; d
  elseif. do. NB. door
    has_key=. +/ k = 32 + a
    (3 $ a:) [`]@.has_key p;k;d
  end.
)
rm_empty_state=: 3 : '(-. y -:"(1) 3 $ a:)# y'


Read_from_file=: 3 : 'cutopen toJ 1!:1 < y'
Save_to_file=: 4 : '(toHOST ,(": x),"1 LF) 1!:2 < y'
Write_to_stdout=: 3 : '(toHOST ,(": y),"1 LF) 1!:2 <2'
Read_from_stdin=: 3 : '1!:1 <1'