NB. day13_1 '/abs/path/to/file'
Day13_1=: 3 : 0
  new_x=. 0;0;'' NB. pc;relbase;input
  new_y=. getmem y
  halt=.0
  outs=.''
  while. -.halt do.
    pause=. new_x Computer new_y
    halt=. >0{pause
    pc=. >1{pause
    rb=. >2{pause
    out=. >3{pause
    outs=. out , outs
    new_y=. >4{pause
    new_x=. pc;rb;''
  end.
  tile=. get_tiles outs
  +/ (2 = {."1 tile)
)


get_tiles=: 3 : 0
  (((#y) % 3),3) $ y
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
    new_mem=. (in,pos) w_to_m y
    ((pc+2);rb;in) Computer new_mem
  case. 4 do.
    mode=. {. (2&}. |. op) , 0
    param=. (pc + 1) r_fm_m y
    new_out=. (0 , mode ,. param) get_arg"(1 _) rb,y
    0;(pc+2);rb;new_out;y
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
    1 ; pc ; rb ; '' ; y
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