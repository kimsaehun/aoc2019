NB. Day14_2 '/abs/path/to/file'
Day14_2=: 3 : 0
  reaction=. get_reaction y
  cost_table=. create_cost_table reaction
  recipe=. (}:"1 reaction) ,. <"1 > cost_table
  i_fuel=. ({."1 recipe) i. <'FUEL'
  want=. 1 i_fuel } (#recipe)$0
  ore_per_fuel=. recipe calc_cost want
  (recipe;i_fuel;1000000000000) brute_force >. 1000000000000 % ore_per_fuel
)


NB. x=. recipe;i_fuel;num_ores
NB. y=. guess_gain_fuel
brute_force=: 4 : 0
  guess=. y
  recipe=. >0{x
  i_fuel=. >1{x
  num_ore=. >2{x
  want=. guess i_fuel } (#recipe)$0
  used_ore=. recipe calc_cost want
  while. num_ore > recipe calc_cost want do.
    guess=. >: guess
    want=. guess i_fuel } (#recipe)$0
  end.
  <: guess
)


NB. x=. recipe
NB. y=. want
calc_cost=: 4 : 0
  i_ore=. ({."1 x) i. <'ORE'
  only_ores=. 0 = +/ 0 < 0 i_ore } y
  if. only_ores do.
   i_ore { y
  else.
    all_i=. i. #x
    sel_want=. 0 < y
    i_want=. sel_want # i. #x
    gain=. 0 (all_i -. i_want) } > 1&{"1 x
    cost=. 0 (all_i -. i_want) } > 2&{"1 x
    multiplier=. y >.@% gain
    suf_gain=. gain * - multiplier
    req_cost=. cost *"1 0 multiplier
    new_y=. y + suf_gain + +/ req_cost
    x calc_cost new_y
  end.
)


NB. y=. reaction
create_cost_table=: 3 : 0
  empty_cost=. < (2$#y) $ 0
  reaction_all_one=. <"1 (<y) , "_ 0 <"1 y
  reaction_to_cost/ reaction_all_one , empty_cost
)


NB. x=. all_reaction;individual_reaction
NB. y=. cost_table
reaction_to_cost=: 4 : 0
  reaction=. > {. > x
  chem=. {."1 reaction
  single_react=. > {: > x
  cost_table=. > y

  i_cost=. chem i. 0 { single_react
  cost_num=. > {."1 > 2 { single_react
  cost_chem=. {:"1 > 2 { single_react
  i_cost_chem=. chem i."_ 0 cost_chem
  i_amend=. i_cost (<@:,)"0 i_cost_chem
  < cost_num i_amend } cost_table
)


NB. y=. '/abs/path/to/file'
NB. list_of_inputs;num_out;chem_out
get_reaction=: 3 : 0
  lines=. Read_from_file y
  prep_io_seperation=. ('='&,@:-.&'>')&.> lines
  seperated_io=. > <;._1&.> prep_io_seperation
  prep_in_seperation=. ','&,&.> {."1 seperated_io
  unformatted_in=. <;._1&.> prep_in_seperation
  unformatted_out=. {:"1 seperated_io
  format=: ((".&.>@:{.) , {:) @: -.&a: @: (<;._1) @: (' '&,) @: >"0
  formatted_in=. (<1;'ORE'), format&.> unformatted_in
  formatted_out=. ('ORE';1), |."1 format unformatted_out
  formatted_out ,. formatted_in
)


Read_from_file=: 3 : 0
  cutopen toJ 1!:1 < y
)
Save_to_file=: 4 : '(toHOST ,(": x),"1 LF) 1!:2 < y'
Write_to_stdout=: 3 : '(toHOST ,(": y),"1 LF) 1!:2 <2'
Read_from_stdin=: 3 : '1!:1 <1'