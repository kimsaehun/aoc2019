NB. prog=. '1233 0 4 0 99'
NB. day7_1 prog
day7_1=: 3 : 0
all_settings=. > , <"1 settings i.5
prog_settings=. (<"1 y;"(_ 0) all_settings) ,"1 <0
signals=. > signal/"1 prog_settings
{. (\: signals) { signals
)

NB. settings i.5
settings=: 3 : 0
((] ,"0 1 [: settings [: y&-. ])"0)`(3 : '0 $ 0')@.(0 = # y) y
)

NB. (prog;setting) signal < output
signal=: 4 : 0
in=. (> {: > x) , > y
prog=. > {. > x
(0,in) day5_1 '';clean_numbers prog
)

NB. pc =. 0
NB. input=. 1 2
NB. ouput=. ''
NB. prog=. '1233,0,4,0,99'
NB. (pc,input) day5_1 output;clean_numbers prog
day5_1=: dyad define
pc=. {. x
in=. 0:`}.@.(1 < # x) x
out=. > {. y
prog=. > {: y
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
  ((pc+4),in) day5_1 out;new_prog
case. 3 do.
  pos=. (pc + 1) { prog
  new_prog=. ({. in) pos } prog
  ((pc+2),}.in) day5_1 out;new_prog
case. 4 do.
  mode=. {. (2&}. |. op) , 0
  param=. (pc + 1) { prog
  res=. (mode ,. param) (({:@[) { ])`({:@[)@.(1 = {.@[)"(1 _) prog
  new_out=. out , res
  ((pc+2),in) day5_1 new_out;prog
fcase. 5 do.
case. 6 do.
  exe=. <`=@.(opc - 5)
  modes=. 0 1 { (2&}. |. op) , 2 # 0
  params=. (pc + 1 2) { prog
  args=. (modes ,. params) (({:@[) { ])`({:@[)@.(1 = {.@[)"(1 _) prog
  jump=. 0 exe 0 { args
  new_pc=. jump { (pc + 3) , (1 { args)
  (new_pc,in) day5_1 out;prog
case. do.
  ((i.pc) { prog);opc;pc;y
  < out
end.
)
clean_numbers=: [: ". [: > [: <;._1 ','&,