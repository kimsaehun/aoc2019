NB. wire1=. 'R8,U5,L5,D3'
NB. wire2=. 'U7,R6,D4,L4'
NB. day3_2 wire1 ,: wire2
day3_2=: monad define
c1=. getcoords {. y
c2=. getcoords {: y
uc1=. ~. c1
uc2=. ~. c2
c=. (-. ~: uc1 , uc2) # uc1 , uc2
s=. +/ >: (c1 ,: c2) i."(2 _) c
{. {&s /: s
)

getcoords=. 3 : 0
w=. (< 0, 0),"0 <;._1 ',' , y
c=. gc_h/ |. ((0 0) ; '') , w
}. > {. c
)

gc_h=. 4 : 0
d=. {. > {: x
n=. 1 + i. ". }. > {: x
coords=. > {. y
l_c =. {: coords
select. d
case. 'R' do.
  coords=. coords , l_c +"(1) n ,. 0
case. 'L' do.
  coords=. coords , l_c -"(1) n ,. 0
case. 'U' do.
  coords=. coords , l_c +"(1) 0 ,. n
case. 'D' do.
  coords=. coords , l_c -"(1) 0 ,. n
end.
coords ; ''
)
