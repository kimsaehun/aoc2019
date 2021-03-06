NB. Day17_1 '/abs/path/to/file'
Day17_1=: 3 : 0
  prog=. 0;0;'';0 NB. pc;relbase;in;stack_cnt
  mem=. getmem y
  ret=. ''
  halt=. 0
  out=. ''
  while. -. 99 = halt do.
    ret=. prog Computer mem
    halt=. >0{ret
    out=. out, >1{ret
    prog=. >2{ret
    mem=. >3{ret
  end.
  find_intersect draw_map out
)


find_intersect=: 3 : 0
  max_r=. {. $y
  max_c=. {: $y
  i=. (}. }: i.max_r) ([ <@,"0 ])"(0 1) (}. }: i.max_c)
  inter=. -.&a: , (y is_intersect"(_ 0) i) #"1 i
  +/ > */&.> inter
)


is_intersect=: 4 : 0
  i=. > y
  cnswe_i=. <"1 i , i +"1 (_1 0),(1 0),(0 _1),:(0 1)
  5 = +/ '#' = cnswe_i { x
)


draw_map=: 3 : 0
  num=. > (<;._2 y,10)-. a:
  tile=. get_tile"0 num
)

get_tile=: 3 : 0
  if. y = 35 do.
    '#'
  elseif. y = 46 do.
    '.'
  elseif. y = 94 do.
    '^'
  elseif. do.
    '?'
  end.
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
  sc=. >: >3{x
  if. sc > 1000 do.
    98 ; '' ; (pc;rb;in;0) ; y return.
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
    ((pc+4);rb;in;sc) Computer new_mem
  case. 3 do.
    mode=. {. (2&}. |. op) , 0
    param=. (pc + 1) r_fm_m y
    pos=. (1 , mode ,. param) get_arg"(1 _) rb,y
    new_mem=. (({:in),pos) w_to_m y
    ((pc+2);rb;in;sc) Computer new_mem
  case. 4 do.
    mode=. {. (2&}. |. op) , 0
    param=. (pc + 1) r_fm_m y
    out=. (0 , mode ,. param) get_arg"(1 _) rb,y
    4;out;((pc+2);rb;in;sc);y
  fcase. 5 do.
  case. 6 do.
    exe=. <`=@.(opc - 5)
    modes=. 0 1 { (2&}. |. op) , 2 # 0
    params=. (pc + 1 2) r_fm_m y
    args=. ((0 0) ,. modes ,. params) get_arg"(1 _) rb,y
    jump=. 0 exe 0 { args
    new_pc=. jump { (pc + 3) , (1 { args)
    (new_pc;rb;in;sc) Computer y
  case. 9 do.
    mode=. {. (2&}. |. op) , 0
    param=. (pc + 1) r_fm_m y
    arg=. (0 , mode ,. param) get_arg"(1 _) rb,y
    new_rb=. rb + arg
    ((pc+2);new_rb;in;sc) Computer y
  case. 99 do.
    99 ; '' ; x ; y
  end.
)


getmem=: 3 : 0
  ".><;._1 ',' , (, > cutopen toJ 1!:1 < y)
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