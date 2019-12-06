NB. range=. 245318 , 765747
NB. day4_1 range
day4_1=: monad define
lo=. {. y
hi=. {: y
n=. lo , >: lo + i. hi - lo
digits=. 10&#.^:_1 &.> <"0 n
hasdouble =. 0 < [: +/^:2  *./"(1) @ (2: =\ ])
neverdecrease=:] -: /: { ]
check1=. hasdouble &.> digits
check2=. neverdecrease &.> digits
+/ *./ > check1 ,: check2
)