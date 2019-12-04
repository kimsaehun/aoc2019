NB. load '2-1.ijs'
NB. day2_2 '1,1,1,4,99,5,6,0,99'
day2_2=: monad define
input =. ".><;._1',', y
swap_table =. ,"(0 0)&(i.100) @ > i. 100
input_table =. swap_table (1 2) }"1 input
values=. 0 day2_1"(0 1) input_table
nv =. ((, values) i. 19690720) { > , <"1 swap_table
n =. {. nv
v =. {: nv
v + n * 100 
)