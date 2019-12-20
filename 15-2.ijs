NB. Day15_2 '/abs/path/to/file'
Day15_2=: 3 : 0
  in=. ''
  prog=. 0;0;in NB. pc;relbase;in
  mem=. getmem y
  ret=. ''
  halt=. 0
  map=. < (1 1 $ 1) ; 0 0
  t_valid_move=. 1 1 1 1
  queue=. <prog;mem;map
  sln=. ''
  while. (-. 99 = halt) *. (0 < #queue) *. 0 = +/ 2 = t_valid_move do.
    prog=. >0{ >{. queue
    mem=. >1{ >{. queue
    map=. >2{ >{. queue

    in=. > {: prog
    new_in=. <"1 in ,"(_ 0) 1 2 3 4
    prog_nswe=. (}: prog) ,"(_ 0) new_in
    ret_nswe=. prog_nswe Computer"1 _ mem

    halt_nswe=. >0{"1 ret_nswe
    out_nswe=. >1{"1 ret_nswe
    new_prog_nswe=. >2{"1 ret_nswe
    new_mem_nswe=. >3{"1 ret_nswe

    new_map_nswe=. map update_map out_nswe

    t_valid_move=. valid_move@>"1 new_map_nswe
    sln=. , > (t_valid_move = 2) # new_map_nswe
    t_valid_move=. 1 ((t_valid_move = 2) # i.4) } t_valid_move

    new_queue_item=. <"1 t_valid_move # new_prog_nswe ;"1 new_mem_nswe ;"1 0 new_map_nswe
    queue=. (}.queue) , new_queue_item
  end.
  lvl=. 0
  oxy_map=. > {. sln
  oxy_start=. > {: sln
  stk=. < oxy_start ; lvl
  max_lvl =. lvl <. 0
  while. -. 0 = # stk do.
    curr_pos=. > {. > {. stk
    curr_lvl=. > {: > {. stk

    max_lvl=. max_lvl >. curr_lvl

    new_pos=. oxy_map oxy_valid_moves curr_pos

    new_stk_item=. <"1 new_pos ,. >: lvl
    stk=. new_stk_item , (}. stk)    
  end.
  max_lvl
)


oxy_valid_moves=: 4 : 0
  possible_move=. y +"1 (_1 0),(1 0),(0 _1),:(0 1)
  possible_tile=. (;/ possible_move) { x
  t_valid_tile=. 0 < possible_tile
  t_valid_tile # possible_move
)


valid_move=: 3 : 0
  map=. >{.y
  curr=. >{:y
  tile=. (< curr) { map
  if. tile = 2 do.
    2
  else.
    tile > 0
  end.
)


NB. x =. map;curr_pos
NB. y=. result_nswe
update_map=: 4 : 0
  map=. >{.x
  curr=. >{:x
  up_map=. 3 (<curr) } map
  up_mc=. up_map enlarge_map curr
  up_map=. >{. up_mc
  move=. (_1 0),(1 0),(0 _1),:(0 1)
  up_curr=. move +"1 >{: up_mc
  up_map=. > {. > update_tile/ (<"0 i. 4) , < up_map;up_curr;y
  <"1 up_map ;"(_ 1) up_curr
)


NB. x=. index
NB. y=. map;pos;result
update_tile=: 4 : 0
  map=. >0{>y
  pos=. >1{>y
  result=. >2{>y
  i=. < (>x) { pos
  tile=. i { map
  new_tile=. x { result
  up_map=. ]`(new_tile i } ])@.(_1 = tile) map
  < up_map;pos;result
)


NB. x=. map
NB. y=. curr_pos
enlarge_map=: 4 : 0
  up_map=. x
  up_curr=. y
  max_r=. {. $ up_map
  max_c=. {: $ up_map
  if. 0 > _1 + {. y do. NB. north
    up_map=. _1 , up_map
    up_curr=. up_curr + 1 0
  end.
  if. max_r = 1 + {. y do. NB. south
    up_map=. up_map , _1
  end.
  if. 0 > _1 + {: y do. NB. west
    up_map=. _1 ,. up_map
    up_curr=. up_curr + 0 1
  end.
  if. max_c = 1 + {: y do. NB. east
    up_map=. up_map ,. _1
  end.
  up_map;up_curr
)


getmem=: 3 : 0
  ".><;._1 ',' , (, > cutopen toJ 1!:1 < y)
)




NB. pc =. 0
NB. relbase=. 0
NB. input=. 1
NB. mem=. clean_numbers '1233,0,4,0,99'
NB. (pc;relbase;input) Computer mem
Computer=: dyad define
  pc=. >0{x
  rb=. >1{x
  in=. >2{x
  op=. (10&#.^:_1) pc r_fm_m y
  opc=. 10 #. |. 2 {. |. op
  select. opc
  fcase. 1 do.
  fcase. 2 do.
  fcase. 7 do.
  case. 8 do.
    exe_i=. opc - (1:`5:)@.(opc>2)
    exe=. +`*`<`=@.exe_i
    modes=. 0 1 2 { (2&}. |. op) , 3 # 0
    params=. (pc + 1 2 3) r_fm_m y
    args=. ((0 0 1) ,. modes ,. params) get_arg"(1 _) rb,y
    new_mem=. (((0{args) exe (1{args)),(2{args)) w_to_m y
    ((pc+4);rb;in) Computer new_mem
  case. 3 do.
    mode=. {. (2&}. |. op) , 0
    param=. (pc + 1) r_fm_m y
    pos=. (1 , mode ,. param) get_arg"(1 _) rb,y
    new_mem=. (({:in),pos) w_to_m y
    ((pc+2);rb;in) Computer new_mem
  case. 4 do.
    mode=. {. (2&}. |. op) , 0
    param=. (pc + 1) r_fm_m y
    out=. (0 , mode ,. param) get_arg"(1 _) rb,y
    4;out;((pc+2);rb;in);y
  fcase. 5 do.
  case. 6 do.
    exe=. <`=@.(opc - 5)
    modes=. 0 1 { (2&}. |. op) , 2 # 0
    params=. (pc + 1 2) r_fm_m y
    args=. ((0 0) ,. modes ,. params) get_arg"(1 _) rb,y
    jump=. 0 exe 0 { args
    new_pc=. jump { (pc + 3) , (1 { args)
    (new_pc;rb;in) Computer y
  case. 9 do.
    mode=. {. (2&}. |. op) , 0
    param=. (pc + 1) r_fm_m y
    arg=. (0 , mode ,. param) get_arg"(1 _) rb,y
    new_rb=. rb + arg
    ((pc+2);new_rb;in) Computer y
  case. 99 do.
    99 ; '' ; x ; y
  end.
)

NB. (literal_mode ,. mode ,. param) get_arg relbase,mem
get_arg=: 4 : 0
  literal=.0{x
  m=. 1{x
  p=. 2{x
  rb=. {. y
  mem=. }. y
  select. m
  case. 0 do.
    p r_fm_m`[@.literal mem
  case. 1 do.
    p
  case. 2 do.
    (rb + p) r_fm_m`[@.literal mem
  end.
)

get_input=: 3 : 0
  in=: Read_from_stdin ''
  if. in = 'w' do.
    1
  elseif. in = 'a' do.
    3
  elseif. in = 's' do.
    2
  elseif. in = 'd' do.
    4
  elseif. do.
    0
  end.
)

NB. (val,addr) w_to_m mem
w_to_m=: 4 : 0
  val=. {.x
  addr=. {: x
  add=. >: addr - # y
  valid=. addr < # y
  (val addr} (] , add # 0:))`(val addr} ])@.(valid) y
)

NB. addr r_fm_m mem
r_fm_m=: 4 : 0
  x (0:`([ { ])@.([ < #@]))"0 _ y
)




Read_from_file=: 3 : 0
  cutopen toJ 1!:1 < y
)
Save_to_file=: 4 : '(toHOST ,(": x),"1 LF) 1!:2 < y'
Write_to_stdout=: 3 : '(toHOST ,(": y),"1 LF) 1!:2 <2'
Read_from_stdin=: 3 : '1!:1 <1'