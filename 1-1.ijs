NB. day1_1 'drive:\full\path\to\input\file.ext'
day1_1=: monad define
readfile=. 1!:1
filename=. < y
rawdata=. readfile filename
chardata=. cutopen toJ rawdata
numdata=. 0 ". each chardata
nums=. > numdata
fuelreqof=. [: -&2 [: <. %&3
+/ fuelreqof nums
)