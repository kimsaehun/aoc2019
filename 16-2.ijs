NB. Day16_2 '/abs/path/to/file'
Day16_2=: 3 : 0
  in=. , to_digits "."0 > Read_from_file y
  off=. 10 #. 7 {. in
  real_in=. (10000 * # in) $ in
  off_real_in=. off }. real_in
  out=. (100;0) do_phase off_real_in
  8 {. out
)

do_phase=: 4 : 0
  stop=. >{.x
  cnt=. >{:x
  if. cnt  < stop do.
    d=. diag_sum y
    (stop;>:cnt) do_phase d
  else.
    y
  end.
)


diag_sum=: 3 : 0
  d=.'',{:y
  i=. <:<:#y
  y=.}:y
  while. i >: 0 do.
    l=. {:d
    r=. i{y
    n=. 10 | l+r
    d=. d,n
    i=.<:i
  end.
  |. d
)


to_digits=: 10&#.^:_1
get_pattern=: [ $ (1&|.)@:(#&(0 1 0 _1))@:]


Read_from_file=: 3 : 0
  cutopen toJ 1!:1 < y
)
Save_to_file=: 4 : '(toHOST ,(": x),"1 LF) 1!:2 < y'
Write_to_stdout=: 3 : '(toHOST ,(": y),"1 LF) 1!:2 <2'
Read_from_stdin=: 3 : '1!:1 <1'