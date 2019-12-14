NB. day12_1 '/asbsolute/path/to/file'
day12_1=: 3 : 0
  moon=. getmoons y
  for. i.1000 do.
    new_moon=. scan moon
    moon=. new_moon
  end.
  energy_of moon
)


NB. read from file and genearate positions;velocity of moons
getmoons=: 3 : 0
  data=. cutopen toJ 1!:1 < y
  char_nums=. (-."1&'<,=>xyz')&.> data
  nums=. (0&".)&> char_nums
  nums ;"(1) 3#0
)


NB. Calculate velocity then move
scan=: 3 : 0
  pairs=. ([ ;"(1 0) ] <"1@:-. [)"(1 _)~ y
  curr_vel=. > {:"1 y
  new_vel=. curr_vel + +/"2 (>@:{. apply_gravity >@{:)"1 pairs
  up_vel_moon=. ({."1 y) ,"0 <"1 new_vel
  move"1 up_vel_moon
)


NB. returns velocity
NB. moon_x apply_gravity moon_y
apply_gravity=: 4 : 0
  pos_x=. > {. x
  pos_y=. > {. y
  * pos_y - pos_x
)


NB. move moon
move=: 3 : 0
  pos=. >{.y
  vel=. >{:y
  (<"1 pos + vel) ,"0 {:"1 y
)

NB. calculate enery
energy_of=: 3 : 0
  pos=. >{."1 y
  vel=. >{:"1 y
  pot=. +/"1 | pos
  kin=. +/"1 | vel
  +/ pot * kin
)