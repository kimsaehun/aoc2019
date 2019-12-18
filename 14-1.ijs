0 : 0
 | #| O|A|B|C|D|E|F
O| 1| 1| | | | | | 
A|10|10| | | | | | 
B| 1| 1| | | | | | 
C| 1|  |7|1| | | | 
D| 1|  |7| |1| | | 
E| 1|  |7| | |1| | 
F| 1|  |7| | | |1| 

subtract # column
add cost column


F| O|A|B|C|D|E|F|--|O|A|B|C|D|E|F|
0|  |7| | | |1| |--| | | | | | | |

need A,E
1|  |7| | | |1| |--| | | | | | | |
 |10| | | | |1| |--| |3| | | | | |
 |10|7| | | |1| |--| |3| | | | | |
 |10|4| | |1| | |--| | | | | | | |

need A,D
2|10|4| | |1| | |--| | | | | | | |
 |20| | | |1| | |--| |6| | | | | |
 |20|7| |1| | | |--| |6| | | | | |
 |20|1| |1| | | |--| | | | | | | |

need A,C
3|20|1| |1| | | |--| | | | | | | |
 |30| | |1| | | |--| |9| | | | | |
 |30|7|1| | | | |--| |9| | | | | |
 |30| |1| | | | |--| |2| | | | | |

need B
4|30| |1| | | | |--| |2| | | | | |
4|31| | | | | | |--| |2| | | | | |


necessary=. > {. (({:"1 recipe) i. <'FUEL') { recipe
if does not exist get for free

)


NB. Day14_1 '/abs/path/to/file'
Day14_1=: 3 : 0
  reaction=. get_reaction y
  cost_table=. create_cost_table reaction
  recipe=. (}:"1 reaction) ,. <"1 > cost_table
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