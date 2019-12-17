0 : 0
   O|A|B|C|D|E|F
O|  | | | | | | 
A|10| | | | | | 
B| 1| | | | | | 
C|  |7|1| | | | 
D|  |7| |1| | | 
E|  |7| | |1| | 
F|  |7| | | |1| 


F| O|A|B|C|D|E|F
0|  |7| | | |1| 
1|70|7| | |1| | 
1|70|7| | |1| | 
1|70|7| | |1| | 
1|70|7| | |1| | 
1|70|7| | |1| | 
)

NB. Day14_1 '/abs/path/to/file'
Day14_1=: 3 : 0
  reaction=. (<'FUEL') get_reactions y
  reaction create ('FUEL';<0;'ORE')
)


NB. x=. reaction
NB. y=. want ; list_of_num;have 
create=: 4 : 0
  want=. {. y
  have=. > {: y
)


NB. x=. reaction
NB. y=. chem
get_reaction_tree=: 4 : 0
  i_out_chem=. ({:"1 x) i. y
  if. i_out_chem = #x do.
    a:
  else.
    in=. > {. i_out_chem { x
    recurse_in=. (x&get_reaction_tree@{:"1 in)
    end=. +/^:_ recurse_in=a:
    in (([ ; ])`[)@.end <recurse_in
  end.
)


NB. y=. '/abs/path/to/file'
NB. list_of_inputs;num_out;chem_out
get_reactions=: 4 : 0
  lines=. Read_from_file y
  prep_io_seperation=. ('='&,@:-.&'>')&.> lines
  seperated_io=. > <;._1&.> prep_io_seperation
  prep_in_seperation=. ','&,&.> {."1 seperated_io
  unformatted_in=. <;._1&.> prep_in_seperation
  unformatted_out=. {:"1 seperated_io

  format=: ((".&.>@:{.) , {:) @: -.&a: @: (<;._1) @: (' '&,) @: >"0
  formatted_in=. format&.> unformatted_in
  formatted_out=. format unformatted_out
  (formatted_in ,. formatted_out) get_reaction_tree x
)


Read_from_file=: 3 : 0
  cutopen toJ 1!:1 < y
)
Save_to_file=: 4 : '(toHOST ,(": x),"1 LF) 1!:2 < y'
Write_to_stdout=: 3 : '(toHOST ,(": y),"1 LF) 1!:2 <2'
Read_from_stdin=: 3 : '1!:1 <1'