NB. day1_2 'drive:\full\path\to\input\file.ext'
day1_2=: monad define
readfile=. 1!:1
filename=. < y
rawdata=. readfile filename
chardata=. cutopen toJ rawdata
numdata=. 0 ". each chardata
nums=. > numdata
reqfuel=. [: -&2 [: <. %&3
fuelreqof=. [ ` (([ + ([: reqfuel ])) $: ([: reqfuel ])) @. ([: 1&= *@([: reqfuel ]))
+/ 0 fuelreqof"(0 0) nums
)