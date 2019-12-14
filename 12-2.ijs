NB. day12_2 '/asbsolute/path/to/file'
day12_2=: 3 : 0
  moon=. getmoons y
  init_axis=. split_axis moon
  foundx=.0
  foundy=.0
  foundz=.0
  stepx=.0
  stepy=.0
  stepz=.0
  step=.0
  while. -. foundx *. foundy *. foundz do.
    moon=. scan moon
    step=. >: step
    new_axis=. split_axis moon
    found=. new_axis = init_axis
    foundx=. ]`1:@.(0{found) foundx
    foundy=. ]`1:@.(1{found) foundy
    foundz=. ]`1:@.(2{found) foundz
    stepx=. stepx ([`]@.(foundx *. stepx=0)) step
    stepy=. stepy ([`]@.(foundy *. stepy=0)) step
    stepz=. stepz ([`]@.(foundz *. stepz=0)) step
  end.
  *./ stepx,stepy,stepz
)


split_axis=: 3 : 0
  ax=. 0&{&>y
  ay=. 1&{&>y
  az=. 2&{&>y
  ax;ay;az
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