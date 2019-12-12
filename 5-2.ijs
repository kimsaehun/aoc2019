NB. day5_2 '/full/path/to/file'
day5_2=: 3 : 0
getinput=: [: cutopen [: toJ [: 1!:1 <
orbs=. ([: <;._1 ')'&,)&> getinput y
you_orbs=. }: orbs list_orbs"(_ 0) <'YOU'
san_orbs=.}: orbs list_orbs"(_ 0) <'SAN'
you_orbs min_dist san_orbs
)

list_orbs=: 4 : 0
i=. ({: |: x) i. y
(] y&,@list_orbs"_ 0 ([: {. i&{))`(3 : 'a:')@.(i = # x) x
)

min_dist=: 4 : 0
dups=. x -. x -. y
x_dist=. x i. dups
y_dist=. y i. dups
min_dup_i=. {. /: x_dist + y_dist
((min_dup_i { x_dist) + min_dup_i { y_dist) - 2
)