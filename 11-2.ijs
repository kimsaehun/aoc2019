NB. day11_2 mem
day11_2=: 3 : 0
  pm=. 0 ; 0 ; (0,1) ; (0,0) ; (< 0 0) ; 0 NB. paint_or_move;color;dir;curr_coord;painted_coords;coord_colors
  new_x=. 0;0;1 NB. pc;relbase;input
  new_y=. y
  halt=.0
  while. -.halt do.
    pause=. new_x Computer new_y
    halt=. >0{pause
    pc=. >1{pause
    rb=. >2{pause
    out=. >3{pause
    new_y=. >4{pause
    pm =. pm do_paint_or_move out
    color=. 1{pm
    new_x=. pc;rb;color
  end.
  painted =. 4 5 { pm
  coords=. > {. painted
  colors=. > {: painted
  xcoords=. , }:"1 >coords
  ycoords=. , }."1 >coords
  minx=. ({. /: xcoords) { xcoords
  miny=. ({. /: ycoords) { ycoords
  shift=. (0 - minx) , (0 - miny)
  shifted_coords=. (shift&+)&.> coords
  max_dim=. >: shift + (({. \: xcoords) { xcoords),(({. \: ycoords) { ycoords)
  panel=. max_dim $ ' '
  draw_coords=. (colors=1) # shifted_coords
  '#' draw_coords } panel
)


NB. pm=. paint_or_move;color;dir;curr_coord;painted_coords;coord_colors
NB. pm do_paint_or_move output
do_paint_or_move=: 4 : 0
  if. -.(y=0)+.(y=1) do.
    x
  elseif. 0 = >{.x do. NB. paint
    1 ; y ; (2{x) , (3{x) , (< ((3{x) , > 4{x)) , (< y , > 5{x)
  elseif. 1 = >{.x do. NB. move
    new_d_c_c=. ((2 3{x) move y)
    c_c=. {:new_d_c_c
    new_c=. ((4{x),(5{x)) get_painted_color c_c
    0 ; new_c , new_d_c_c , (4{x) , (5{x)
  end.
)

NB. painted_coords;coord_colors get_painted_color coord
get_painted_color=: 4 : 0
  pc=. >{.x
  cc=. >{:x
  i=. pc i. y
  < i&{`0:@.(i=#pc) cc
)


NB. dir;curr_coord move output
move=: 4 : 0
  dir_x=.{.>{.x
  dir_y=.{:>{.x
  coord=.>{:x
  sign=. -`+@.y
  if. (dir_x=0) *. (dir_y=1) do. NB. up
    dir=. (sign 1),0
  elseif. (dir_x=0) *. (dir_y=_1) do. NB. down
    dir=. (sign _1),0
  elseif. (dir_y=0) *. (dir_x=1) do. NB. right
    dir=. 0,(sign _1)
  elseif. (dir_y=0) *. (dir_x=_1) do. NB. left
    dir=. 0,(sign 1)
  end.
  dir;dir+coord
)

NB. pc =. 0
NB. relbase=. 0
NB. input=. 1
NB. mem=. clean_numbers '1233,0,4,0,99'
NB. (pc;relbase;input) Computer mem
Computer=: dyad define
  pc=. >0{x
  rb=. >1{x
  in=. >2{x
  op=. (10&#.^:_1) pc r_fm_m y
  opc=. 10 #. |. 2 {. |. op
  select. opc
  fcase. 1 do.
  fcase. 2 do.
  fcase. 7 do.
  case. 8 do.
    exe_i=. opc - (1:`5:)@.(opc>2)
    exe=. +`*`<`=@.exe_i
    modes=. 0 1 2 { (2&}. |. op) , 3 # 0
    params=. (pc + 1 2 3) r_fm_m y
    args=. ((0 0 1) ,. modes ,. params) get_arg"(1 _) rb,y
    new_mem=. (((0{args) exe (1{args)),(2{args)) w_to_m y
    ((pc+4);rb;in) Computer new_mem
  case. 3 do.
    mode=. {. (2&}. |. op) , 0
    param=. (pc + 1) r_fm_m y
    pos=. (1 , mode ,. param) get_arg"(1 _) rb,y
    new_mem=. (in,pos) w_to_m y
    ((pc+2);rb;in) Computer new_mem
  case. 4 do.
    mode=. {. (2&}. |. op) , 0
    param=. (pc + 1) r_fm_m y
    new_out=. (0 , mode ,. param) get_arg"(1 _) rb,y
    0;(pc+2);rb;new_out;y
  fcase. 5 do.
  case. 6 do.
    exe=. <`=@.(opc - 5)
    modes=. 0 1 { (2&}. |. op) , 2 # 0
    params=. (pc + 1 2) r_fm_m y
    args=. ((0 0) ,. modes ,. params) get_arg"(1 _) rb,y
    jump=. 0 exe 0 { args
    new_pc=. jump { (pc + 3) , (1 { args)
    (new_pc;rb;in) Computer y
  case. 9 do.
    mode=. {. (2&}. |. op) , 0
    param=. (pc + 1) r_fm_m y
    arg=. (0 , mode ,. param) get_arg"(1 _) rb,y
    new_rb=. rb + arg
    ((pc+2);new_rb;in) Computer y
  case. 99 do.
    1 ; pc ; rb ; 2 ; y
  end.
)


Clean_numbers=: [: ". [: > [: <;._1 ','&,


NB. (literal_mode ,. mode ,. param) get_arg relbase,mem
get_arg=: 4 : 0
  literal=.0{x
  m=. 1{x
  p=. 2{x
  rb=. {. y
  mem=. }. y
  select. m
  case. 0 do.
    p r_fm_m`[@.literal mem
  case. 1 do.
    p
  case. 2 do.
    (rb + p) r_fm_m`[@.literal mem
  end.
)


NB. (val,addr) w_to_m mem
w_to_m=: 4 : 0
  val=. {.x
  addr=. {: x
  add=. >: addr - # y
  valid=. addr < # y
  (val addr} (] , add # 0:))`(val addr} ])@.(valid) y
)


NB. addr r_fm_m mem
r_fm_m=: 4 : 0
  x (0:`([ { ])@.([ < #@]))"0 _ y
)

save_to_file=: 4 : '(toHOST ,(": x),"1 LF) 1!:2 < y'