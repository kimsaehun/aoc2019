NB. day5_1 '/full/path/to/file'
getinput=: [: cutopen [: toJ [: 1!:1 < 
keys=: [: 0&{ |:
day5_1=: 4 : 0
data=. ([: <;._1 ')'&,)&.> getinput y
orbs=. map/ data , (<'';'')
)
map=. 4 : 0
m=. > y
k=. {. > x
v=. {: > x
)