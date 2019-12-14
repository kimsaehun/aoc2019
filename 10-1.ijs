NB. day10_1 '/absolute/path/to/file'
day10_1=: 3 : 0
map=. > cutopen toJ 1!:1 < y
h=. {. $ map
w=. {: $ map 
i=. ('#'=,map) # i. $ , map
coord=. ( <@:((<.@:%&h),(w&|])) )"0 i
pair=. ([ ,. ] -. [)"(0 1)~ coord
rr=. rise_run/"1 pair
a=. ang/"1 |."1 rr
cnt=. > (#@:~.)&.> <"1 a
NB. coords_of_max=. |.&.> ({. \: cnt) { coord
({. \: cnt) { cnt
)
rise_run=: 4 : '(_1 1)* -/"1 (>y),.>x'
ang=: 4 : 0
at=. arctan y % x
if. x > 0 do.
at
elseif. (x < 0) *. (y >: 0) do.
at + o. 1
elseif. (x < 0) *. (y < 0) do.
at - o. 1
elseif. (x = 0) *. (y > 0) do.
(o. 1) % 2
elseif. (x = 0) *. (y < 0) do.
-(o. 1) % 2
end.
)