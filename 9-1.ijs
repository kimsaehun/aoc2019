NB. pc =. 0
NB. relbase=. 0
NB. input=. 1 2
NB. ouput=. ''
NB. mem=. clean_numbers '1233,0,4,0,99'
NB. (pc;relbase;input;ouput) Computer mem
Computer=: dyad define M.
pc=. >0{x
rb=. >1{x
in=. >2{x
out=. >3{x
op=. (10&#.^:_1) pc r_to_m y
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
  ((pc+4);rb;in;out) Computer new_mem
case. 3 do.
  mode=. {. (2&}. |. op) , 0
  param=. (pc + 1) r_fm_m y
  pos=. (1 , mode ,. param) get_arg"(1 _) rb,y
  new_mem=. (({. in),pos) w_to_m y
  ((pc+2);rb;(}.in);out) Computer new_mem
case. 4 do.
  mode=. {. (2&}. |. op) , 0
  param=. (pc + 1) r_fm_m y
  new_out=. (0 , mode ,. param) get_arg"(1 _) rb,y
  ((pc+2);rb;in;(out,new_out)) Computer y
fcase. 5 do.
case. 6 do.
  exe=. <`=@.(opc - 5)
  modes=. 0 1 { (2&}. |. op) , 2 # 0
  params=. (pc + 1 2) r_fm_m y
  args=. ((0 0) ,. modes ,. params) get_arg"(1 _) rb,y
  jump=. 0 exe 0 { args
  new_pc=. jump { (pc + 3) , (1 { args)
  (new_pc;rb;in;out) Computer y
case. 9 do.
  mode=. {. (2&}. |. op) , 0
  param=. (pc + 1) r_fm_m y
  arg=. (0 , mode ,. param) get_arg"(1 _) rb,y
  new_rb=. rb + arg
  ((pc+2);new_rb;in;out) Computer y
case. 99 do.
  pc ; rb ; in ; out ; y
end.
)
Clean_numbers=: [: ". [: > [: <;._1 ','&,
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