NB. width=. 3
NB. height=. 2
NB. (width,height) day8_2 '123456789012'
day8_2=: 4 : 0
w=. {.x
h=. {:x
z=. (#y)%(w*h)
layer=. (z,h,w) $ y
pix=. 0 |: layer
msg=. (<./"1 (i."(1 0)&'01')"1 pix) {"0 1 pix
(h,w) $ ("."0 , msg) { ' 1'
)