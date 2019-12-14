NB. prog=. '1233,0,4,0,99'
NB. day7_2 prog
day7_2=: 3 : 0
all_settings=. > , <"1 settings 5+i.5
signals=. y signal_loop"1 all_settings
{. (\: signals) { signals
)

NB. settings i.5
settings=: 3 : 0
((] ,"0 1 [: settings [: y&-. ])"0)`(3 : '0 $ 0')@.(0 = # y) y
)

NB. prog signal_loop setting
signal_loop=: 4 : 0
halt=.0
in=. (< ({. y) , 0) 0 } <"0 y
prog=. 0 ;"(1) 0 ;"1 in ;&> <"1 '' ;"1 >5$<clean_numbers x
i=.0
while. -. halt *. i = 4 do.
p=. i{prog
p=. (< (>2{p) , >3{(<:i){prog) 2 } p
ret=. ((>1{p);(>2{p);(>3{p)) day5_1 >4{p
prog=. ret i}prog
halt=. >{.ret
i=.5 | >:i
end.
> 3 { {: prog
)


NB. pc =. 0
NB. input=. 1 2
NB. ouput=. ''
NB. prog=. clean_numbers '1233,0,4,0,99'
NB. (pc;input;out) day5_1 prog
day5_1=: dyad define
pc=. >0{x
in=. >1{x
out=. >2{x
prog=. y
op=. (10&#.^:_1) pc&{ prog
opc=. {: op
select. opc
fcase. 1 do.
fcase. 2 do.
fcase. 7 do.
case. 8 do.
  exe_i=.opc - (1:`5:)@.(opc>2)
  exe=. +`*`<`=@.exe_i
  modes=. 0 1 2 { (2&}. |. op) , 3 # 0
  params=. (pc + 1 2 3) { prog
  args=. (modes ,. params) (({:@[) { ])`({:@[)@.(1 = {.@[)"(1 _) prog
  new_prog=. ((0{args) exe (1{args)) (2{params) } prog
  ((pc+4);in;out) day5_1 new_prog
case. 3 do.
  pos=. (pc + 1) { prog
  new_prog=. ({. in) pos } prog
  ((pc+2);(}.in);out) day5_1 new_prog
case. 4 do.
  mode=. {. (2&}. |. op) , 0
  param=. (pc + 1) { prog
  new_out=. (mode ,. param) (({:@[) { ])`({:@[)@.(1 = {.@[)"(1 _) prog
  0 ; (pc+2) ; in ; new_out ; prog
fcase. 5 do.
case. 6 do.
  exe=. <`=@.(opc - 5)
  modes=. 0 1 { (2&}. |. op) , 2 # 0
  params=. (pc + 1 2) { prog
  args=. (modes ,. params) (({:@[) { ])`({:@[)@.(1 = {.@[)"(1 _) prog
  jump=. 0 exe 0 { args
  new_pc=. jump { (pc + 3) , (1 { args)
  (new_pc;in;out) day5_1 prog
case. 9 do.
  1 ; pc ; in ; out ; prog
end.
)
clean_numbers=: [: ". [: > [: <;._1 ','&,