NB. Day16_1 '/abs/path/to/file'
Day16_1=: 3 : 0
  in=. , to_digits "."0 > Read_from_file y
  8 {. (100;0) do_phase in
)

do_phase=: 4 : 0
  stop=. >{.x
  cnt=. >{:x
  if. cnt  < stop do.
    t=. ((#y),(#y)) $ y
    p=. (#y) get_pattern"0 >: i. #y
    o=. {:"1 to_digits | +/"1 t * p
    (stop;>:cnt) do_phase o
  else.
    y
  end.
)

to_digits=: 10&#.^:_1
get_pattern=: [ $ (1&|.)@:(#&(0 1 0 _1))@:]


Read_from_file=: 3 : 0
  cutopen toJ 1!:1 < y
)
Save_to_file=: 4 : '(toHOST ,(": x),"1 LF) 1!:2 < y'
Write_to_stdout=: 3 : '(toHOST ,(": y),"1 LF) 1!:2 <2'
Read_from_stdin=: 3 : '1!:1 <1'