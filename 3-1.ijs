NB. wire1=. 'R8,U5,L5,D3'
NB. wire2=. 'U7,R6,D4,L4'
NB. day3_1 wire1 ,: wire2
day3_1=: monad define
c1=. ~. getcoords {. y
c2=. ~. getcoords {: y
c=. (-. ~: c1 , c2) #  c1 , c2
d=. +/"1 (-`+`+)@.(>:@*)"0 c
{. {&d /: d
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
