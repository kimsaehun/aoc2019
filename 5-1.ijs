NB. day5_1 '/full/path/to/file'
getinput=: [: cutopen [: toJ [: 1!:1 <
keys=: [: 0&{ |:
NB. day5_1=: 4 : 0
NB. data=. ([: (<^:2);._1 ')'&,)&.> getinput y
NB. orbs=. map data
NB. )

map_helper=: 4 : 0
k=. {: x
v=. {. x
keys=. > {. y
values=. > {: y
i=. keys i. k
n_v=. < v , > i { values
n_values=. n_v i } values
keys ; < n_values
)

map=: 3 : 0
lhs=. {. |: y
rhs=. {. |. |: y
  keys=. ~. lhs , rhs
  values=. < (#keys) $ <''
  map_helper/ y , keys ; values
)