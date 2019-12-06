NB. range=. 245318 , 765747
NB. day4_2 range

day4_2=: monad define
lo=. {. y
hi=. {: y
n=. lo , >: lo + i. hi - lo
digits=. 10&#.^:_1 &.> <"0 n
cnts=. [: #;._1"(1) 0 ,"1 ] ="0 1 ]
gt2=. 0: < [: +/^:2 (0:`1:@.>&2)&>
eq2=. 0: < [: +/^:2 (0:`1:@.=&2)&>
neverdecrease=:] -: /: { ]
check1=. ((1:`0:@.gt2)`1:@.([: eq2 cnts)) &.> digits
check2=. neverdecrease &.> digits
+/ *./ > check1 ,: check2
)