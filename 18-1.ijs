Day18_1=: 3 : 0
  map=. > Read_from_file a

  rc_map=. (i.{.$map) <@:,"0/ (i.{:$map) NB. row column coordinates

  move_map=. map gen_move"_ 0 rc_map NB. possible move from each position

  a_map=. a. i. map
  t_vip=. rc_map ([: (64&= +. 97&<:) {)"0 _ a_map
  rc_vip=. (, t_vip ) # (, rc_map)
  vip=. (rc_vip { a_map) ;"0 rc_vip
  vip=. (/: {."1 vip) { vip NB. very important positions

  vid=. (map;<move_map) gen_dist_table vip NB. very important distances

  grab_all_keys vid
)

gen_move=: 4 : 0 NB. genereate possible move for given index of map
  if. '#' = y { x do. NB. given position is wall and is invalid
    < 0 2 $ ''
  elseif. do.
    adj_pos=. (>y) +"1 (_1 0),(1 0),(0 _1),:(0 1)
    t_in_bound=. (* +/"1 adj_pos >:"(1) 0 0) *. (* +/"1 adj_pos <"1 $x)
    in_bound_pos=. t_in_bound # adj_pos NB. remove out of bounds
    adj_t=. (<"1 in_bound_pos) { x
    i_non_wall=. -. '#' = adj_t
    valid_pos=. i_non_wall # in_bound_pos NB. remove walls
    valid_tile=. i_non_wall # adj_t
    is_door=. 65&<: *. <:&90
    req_key=. a: ([`(<@:(32&+)@:])@.(is_door@:]))"0 a. i. valid_tile
    < valid_pos ;"1 0 req_key
  end.
)

find_important_pos=: 3 : 0 NB. find starting position and keys
  is_key=. 97 <: a. i. ]
  i=. ('@'&= +. is_key)"0 y
)

gen_dist_table=: 4 : 0 NB. find distances between starting position and keys
  se_table=. {:"1&.> y (<@:,:"1)"(1 _) y
  dist_tbl=. x&find_shortest_dist&> se_table
  ({."1 y)&door_to_index&.> dist_tbl
)
door_to_index=: 4 : 0
  req_key=. > 1{y
  all_key=. > x
  index=. (all_key i. req_key) -. #all_key
  (0{y),(<index),(2{y)
)
find_shortest_dist=: 4 : 0 NB. finds shortest distance and required keys
  map=. >{.x
  move_map=. >{:x
  s_pos=. {.y
  e_pos=. {:y
  state=. sln=. s_pos,'';0 NB. pos;doors;distance
  queue=. ,: state
  history=. ''
  while. -.0=#queue do.
    c_s=. sln=. {. queue
    queue=. }. queue
    if. e_pos = c_pos=.{.c_s do. break. end.
    if. -. (#history) = history i. c_pos do. continue. end.
    next_move=. > c_pos { move_map
    next_pos=. {."1 next_move
    next_door=. (1{c_s) ,&.> 1{"1 next_move
    next_dist=. >: > {:c_s
    queue=. queue , next_pos,.next_door,. <next_dist
    history=. history , c_pos
  end.
  < sln
)

grab_all_keys=: 3 : 0
  sln_d=: 0
  sln_h=: 0 3 $ ''
  dist=. , y find_key_path 0;0;''
  dist=. dist -. 0 _1
)
find_key_path=: 4 : 0
  all_k=. }. i. # {.x

  curr_k=. >0{y
  curr_d=. >1{y
  collected_k=. >2{y

  if. 0=#sln_h do.
    sln_h=: sln_h,y
  elseif. (#sln_h) > i_h=. (0 2{"1 sln_h) i. (0 2{"1 y) do.
    h=. i_h { sln_h
    hd=. >1{h
    if. hd <: curr_d do. _1 return. end.
    sln_h=: y i_h } sln_h
  elseif. do.
    sln_h=: sln_h,y
  end.

  if. curr_d <`>:@.(*sln_d) sln_d do. _1 return. end.
  if. (#all_k)=#collected_k do. 
    sln_d=: sln_d >.`<.@.(*sln_d) curr_d return.
  end.

  try_k=. (all_k -. curr_k) -. collected_k
  if. 0=#try_k do. _1 return. end.
  try_move=. > try_k { curr_k { x
  t_valid_move=. 0 = (#@:(-.&collected_k))&> 1{"1 try_move

  possible_k=. t_valid_move # try_k
  if. 0=#possible_k do. _1 return. end.
  possible_move=. t_valid_move # try_move

  next_k=. possible_k
  next_collected_k=. (/: { ])"1 collected_k ,"1 0 next_k
  next_d=. curr_d +"0 1 > {:"1 possible_move
  x&find_key_path"1 next_k ;"0 1 next_d ;"0 1 next_collected_k
)


Read_from_file=: 3 : 'cutopen toJ 1!:1 < y'
Save_to_file=: 4 : '(toHOST ,(": x),"1 LF) 1!:2 < y'
Write_to_stdout=: 3 : '(toHOST ,(": y),"1 LF) 1!:2 <2'
Read_from_stdin=: 3 : '1!:1 <1'