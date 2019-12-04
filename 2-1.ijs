NB. 0 day2_1 ".><;._1',', '1,1,1,4,99,5,6,0,99'
day2_1=: dyad define
opcode=. x { y
op_agenda=. 1 + * opcode - 2
ops=. + ` * `(4 : 'ans_pos { y')
arg1=. {&y {&y 1 + x
arg2=. {&y {&y 2 + x
ans_pos=. {&y 3 + x
ans=. arg1 ops @. op_agenda arg2
new_y=. ans ans_pos } y
new_x=. x + 4
new_opcode =. new_x { new_y
if. new_opcode=99 do.
{. new_y
else.
new_x day2_1 new_y
end.
)