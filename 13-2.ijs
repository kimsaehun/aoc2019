NB. day13_2 '/abs/path/to/file'
Day13_2=: 3 : 0
  prog=. 0;0;0;'';0;(< <'') NB. pc;relbase;input;output;stack_count;screen
  mem=. getmem y
  ret=. ''
  halt=. 0
  new_score=:0
  score=:0
  while. 1 do.
    ret=. prog Computer mem
    halt=. >0{ret
    pc=. ]`0:@.(* halt) >1{ret
    rb=. >2{ret
    in=. >3{ret
    out=. >4{ret
    sc=. 0
    screen=. >6{ret
    prog=. pc;rb;in;out;sc;<screen
    mem=. >7{ret
  end.
)


draw=: 4 : 0
  screen=. <''
  if. x = <'' do.
    tile=. |. get_tiles y
    paddle=.  ((2 {"1 tile) i. 3) { tile
    ball=.  ((2 {"1 tile) i. 4) { tile
    max_col=. >: ({. \: 0 {"1 tile) { (0 {"1 tile)
    max_row=. >: ({. \: 1 {"1 tile) { (1 {"1 tile)
    empty_screen=. (max_row,max_col) $ ' '
    ball=.  ((2 {"1 tile) i. 4) { tile
    screen=. delta_draw/ (<"1 ball,tile),<empty_screen
  else.
    tile=. |. get_tiles y
    i_score=. ((<"(1) 0 1 {"1 |. y) i. <_1 0)
    score_tile=. i_score&{`(score + 0:)@.(i_score=#tile) tile
    new_score=: {: score_tile
    screen=. delta_draw/ (<"1 tile),x
  end.
  game_screen=. (< new_score) NB. ,:screen
  num_blocks=. +/ +/ 'x' = > screen
  NB.if. new_score > score do.
  if. 0 = 10 | num_blocks do.
    score=: new_score
    write_to_stdout num_blocks;score
    1!:1 <1
  end.
  screen
)


NB. tile delta_draw screen
delta_draw=: 4 : 0
  tile=. >x
  screen=. >y
  pos=. < 1 0 { tile
  sprite=. get_sprite {: tile
  if. pos=<0 _1 do.
    pos=.< 0 0
  end.
  < sprite pos } screen
)


get_sprite=: 3 : 0
  select. y
  case. 1 do.
    '#'
  case. 2 do.
    'x'
  case. 3 do.
    '-'
  case. 4 do.
    'o'
  case. do.
    ' '
  end.
)


get_tiles=: 3 : 0
  (((#y) % 3),3) $ y
)


getmem=: 3 : 0
  ".><;._1 ',' , (, > cutopen toJ 1!:1 < y)
)

NB. pc =. 0
NB. relbase=. 0
NB. input=. 0
NB. output=. 0
NB. screen=. <''
NB. stack_count=. 0
NB. mem=. clean_numbers '1233,0,4,0,99'
NB. (pc;relbase;input;output;stack_count;screen) Computer mem
Computer=: dyad define
  pc=. >0{x
  rb=. >1{x
  in=. >2{x
  out=. >3{x
  sc=. >: >4{x
  screen=. >5{x

  if. sc=500 do.
    0 ; x , < y return.
  end.

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
    ((pc+4);rb;in;out;sc;<screen) Computer new_mem
  case. 3 do.
    mode=. {. (2&}. |. op) , 0
    param=. (pc + 1) r_fm_m y
    pos=. (1 , mode ,. param) get_arg"(1 _) rb,y
    new_screen=. screen draw out
    new_in=. get_input out
    new_mem=. (new_in,pos) w_to_m y
    ((pc+2);rb;new_in;'';sc;<new_screen) Computer new_mem
  case. 4 do.
    mode=. {. (2&}. |. op) , 0
    param=. (pc + 1) r_fm_m y
    new_out=. out , (0 , mode ,. param) get_arg"(1 _) rb,y
    ((pc+2);rb;in;new_out;sc;<screen) Computer y
  fcase. 5 do.
  case. 6 do.
    exe=. <`=@.(opc - 5)
    modes=. 0 1 { (2&}. |. op) , 2 # 0
    params=. (pc + 1 2) r_fm_m y
    args=. ((0 0) ,. modes ,. params) get_arg"(1 _) rb,y
    jump=. 0 exe 0 { args
    new_pc=. jump { (pc + 3) , (1 { args)
    (new_pc;rb;in;out;sc;<screen) Computer y
  case. 9 do.
    mode=. {. (2&}. |. op) , 0
    param=. (pc + 1) r_fm_m y
    arg=. (0 , mode ,. param) get_arg"(1 _) rb,y
    new_rb=. rb + arg
    ((pc+2);new_rb;in;out;sc;<screen) Computer y
  case. 99 do.
    99 ; x , < y
  end.
)


get_input=: 3 : 0
  0
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


Save_to_file=: 4 : '(toHOST ,(": x),"1 LF) 1!:2 < y'
write_to_stdout=: 3 : '(toHOST ,(": y),"1 LF) 1!:2 <2'