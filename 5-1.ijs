NB. day5_1 '/full/path/to/file'
day5_1=: 3 : 0
getinput=: [: cutopen [: toJ [: 1!:1 <
data=. ([: <;._1 ')'&,)&> getinput y
orbs=. map data
num_orbs=. orbs num_total_orbs"(_ 0){. |: orbs
+/ num_orbs
)

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
kv=. map_helper/ y , keys ; values
(> {. kv) ,. > {: kv
)

num_total_orbs=: 4 : 0
i=. ({. |: x) i. y
new_ks=. > {: i { x
x ([: >: +/@num_total_orbs"_ 0)`0:@.(new_ks -: '') new_ks
)