NB. width=. 3
NB. height=. 2
NB. (width,height) day8_1 '123456789012'
day8_1=: 4 : 0
w=. {.x
h=. {:x
z=. (#y)%(w*h)
layer=. (z,(w*h)) $ y
few=. ({. /: +/"1 '0' = layer) { layer
*/ +/"1 (few&=)"0 '12'
)