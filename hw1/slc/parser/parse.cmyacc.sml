
functor SimpleLCParseFun
   (structure Streamable : STREAMABLE
    structure Arg :
       sig
          type string
          type typ
          type exp

          val IfThenElse : exp * exp * exp -> exp
          val Second : exp -> exp
          val First : exp -> exp
          val Tuple : exp * exp -> exp
          val lambda : string * typ * exp -> exp
          val Variable : string -> exp
          val ff : unit -> exp
          val tt : unit -> exp
          val unit : unit -> exp
          val Apply : exp * exp -> exp
          val id_exp : exp -> exp
          val Times : typ * typ -> typ
          val Arrow : typ * typ -> typ
          val id_typ : typ -> typ
          val bool : unit -> typ
          val unitty : unit -> typ

          datatype terminal =
             IDENT of string
           | LPAREN
           | RPAREN
           | ARROW
           | TIMES
           | LAMBDA
           | DARROW
           | COLON
           | COMMA
           | FST
           | SND
           | UNIT
           | UNITTY
           | BOOL
           | TRUE
           | FALSE
           | IF
           | THEN
           | ELSE

          val error : terminal Streamable.t -> exn
       end)
   :>
   sig
      val parse : Arg.terminal Streamable.t -> Arg.exp * Arg.terminal Streamable.t
   end
=

(*

AUTOMATON LISTING
=================

State 0:

start -> . Exp  / 0
5 : Exp -> . ExpOne  / 1
6 : Exp -> . Exp ExpOne  / 1
7 : ExpOne -> . UNIT  / 1
8 : ExpOne -> . TRUE  / 1
9 : ExpOne -> . FALSE  / 1
10 : ExpOne -> . IDENT  / 1
11 : ExpOne -> . LPAREN Exp RPAREN  / 1
12 : ExpOne -> . LAMBDA LPAREN IDENT COLON Typ RPAREN DARROW Exp  / 1
13 : ExpOne -> . LPAREN Exp COMMA Exp RPAREN  / 1
14 : ExpOne -> . FST Exp  / 1
15 : ExpOne -> . SND Exp  / 1
16 : ExpOne -> . IF Exp THEN Exp ELSE Exp  / 1

IDENT => shift 7
LPAREN => shift 6
LAMBDA => shift 5
FST => shift 4
SND => shift 3
UNIT => shift 2
TRUE => shift 9
FALSE => shift 8
IF => shift 1
Exp => goto 10
ExpOne => goto 11

-----

State 1:

5 : Exp -> . ExpOne  / 2
6 : Exp -> . Exp ExpOne  / 2
7 : ExpOne -> . UNIT  / 2
8 : ExpOne -> . TRUE  / 2
9 : ExpOne -> . FALSE  / 2
10 : ExpOne -> . IDENT  / 2
11 : ExpOne -> . LPAREN Exp RPAREN  / 2
12 : ExpOne -> . LAMBDA LPAREN IDENT COLON Typ RPAREN DARROW Exp  / 2
13 : ExpOne -> . LPAREN Exp COMMA Exp RPAREN  / 2
14 : ExpOne -> . FST Exp  / 2
15 : ExpOne -> . SND Exp  / 2
16 : ExpOne -> . IF Exp THEN Exp ELSE Exp  / 2
16 : ExpOne -> IF . Exp THEN Exp ELSE Exp  / 3

IDENT => shift 7
LPAREN => shift 6
LAMBDA => shift 5
FST => shift 4
SND => shift 3
UNIT => shift 2
TRUE => shift 9
FALSE => shift 8
IF => shift 1
Exp => goto 12
ExpOne => goto 11

-----

State 2:

7 : ExpOne -> UNIT .  / 3

$ => reduce 7
IDENT => reduce 7
LPAREN => reduce 7
RPAREN => reduce 7
LAMBDA => reduce 7
COMMA => reduce 7
FST => reduce 7
SND => reduce 7
UNIT => reduce 7
TRUE => reduce 7
FALSE => reduce 7
IF => reduce 7
THEN => reduce 7
ELSE => reduce 7

-----

State 3:

5 : Exp -> . ExpOne  / 3
6 : Exp -> . Exp ExpOne  / 3
7 : ExpOne -> . UNIT  / 3
8 : ExpOne -> . TRUE  / 3
9 : ExpOne -> . FALSE  / 3
10 : ExpOne -> . IDENT  / 3
11 : ExpOne -> . LPAREN Exp RPAREN  / 3
12 : ExpOne -> . LAMBDA LPAREN IDENT COLON Typ RPAREN DARROW Exp  / 3
13 : ExpOne -> . LPAREN Exp COMMA Exp RPAREN  / 3
14 : ExpOne -> . FST Exp  / 3
15 : ExpOne -> . SND Exp  / 3
15 : ExpOne -> SND . Exp  / 3
16 : ExpOne -> . IF Exp THEN Exp ELSE Exp  / 3

IDENT => shift 7
LPAREN => shift 6
LAMBDA => shift 5
FST => shift 4
SND => shift 3
UNIT => shift 2
TRUE => shift 9
FALSE => shift 8
IF => shift 1
Exp => goto 13
ExpOne => goto 11

-----

State 4:

5 : Exp -> . ExpOne  / 3
6 : Exp -> . Exp ExpOne  / 3
7 : ExpOne -> . UNIT  / 3
8 : ExpOne -> . TRUE  / 3
9 : ExpOne -> . FALSE  / 3
10 : ExpOne -> . IDENT  / 3
11 : ExpOne -> . LPAREN Exp RPAREN  / 3
12 : ExpOne -> . LAMBDA LPAREN IDENT COLON Typ RPAREN DARROW Exp  / 3
13 : ExpOne -> . LPAREN Exp COMMA Exp RPAREN  / 3
14 : ExpOne -> . FST Exp  / 3
14 : ExpOne -> FST . Exp  / 3
15 : ExpOne -> . SND Exp  / 3
16 : ExpOne -> . IF Exp THEN Exp ELSE Exp  / 3

IDENT => shift 7
LPAREN => shift 6
LAMBDA => shift 5
FST => shift 4
SND => shift 3
UNIT => shift 2
TRUE => shift 9
FALSE => shift 8
IF => shift 1
Exp => goto 14
ExpOne => goto 11

-----

State 5:

12 : ExpOne -> LAMBDA . LPAREN IDENT COLON Typ RPAREN DARROW Exp  / 3

LPAREN => shift 15

-----

State 6:

5 : Exp -> . ExpOne  / 4
6 : Exp -> . Exp ExpOne  / 4
7 : ExpOne -> . UNIT  / 4
8 : ExpOne -> . TRUE  / 4
9 : ExpOne -> . FALSE  / 4
10 : ExpOne -> . IDENT  / 4
11 : ExpOne -> . LPAREN Exp RPAREN  / 4
11 : ExpOne -> LPAREN . Exp RPAREN  / 3
12 : ExpOne -> . LAMBDA LPAREN IDENT COLON Typ RPAREN DARROW Exp  / 4
13 : ExpOne -> . LPAREN Exp COMMA Exp RPAREN  / 4
13 : ExpOne -> LPAREN . Exp COMMA Exp RPAREN  / 3
14 : ExpOne -> . FST Exp  / 4
15 : ExpOne -> . SND Exp  / 4
16 : ExpOne -> . IF Exp THEN Exp ELSE Exp  / 4

IDENT => shift 7
LPAREN => shift 6
LAMBDA => shift 5
FST => shift 4
SND => shift 3
UNIT => shift 2
TRUE => shift 9
FALSE => shift 8
IF => shift 1
Exp => goto 16
ExpOne => goto 11

-----

State 7:

10 : ExpOne -> IDENT .  / 3

$ => reduce 10
IDENT => reduce 10
LPAREN => reduce 10
RPAREN => reduce 10
LAMBDA => reduce 10
COMMA => reduce 10
FST => reduce 10
SND => reduce 10
UNIT => reduce 10
TRUE => reduce 10
FALSE => reduce 10
IF => reduce 10
THEN => reduce 10
ELSE => reduce 10

-----

State 8:

9 : ExpOne -> FALSE .  / 3

$ => reduce 9
IDENT => reduce 9
LPAREN => reduce 9
RPAREN => reduce 9
LAMBDA => reduce 9
COMMA => reduce 9
FST => reduce 9
SND => reduce 9
UNIT => reduce 9
TRUE => reduce 9
FALSE => reduce 9
IF => reduce 9
THEN => reduce 9
ELSE => reduce 9

-----

State 9:

8 : ExpOne -> TRUE .  / 3

$ => reduce 8
IDENT => reduce 8
LPAREN => reduce 8
RPAREN => reduce 8
LAMBDA => reduce 8
COMMA => reduce 8
FST => reduce 8
SND => reduce 8
UNIT => reduce 8
TRUE => reduce 8
FALSE => reduce 8
IF => reduce 8
THEN => reduce 8
ELSE => reduce 8

-----

State 10:

start -> Exp .  / 0
6 : Exp -> Exp . ExpOne  / 1
7 : ExpOne -> . UNIT  / 1
8 : ExpOne -> . TRUE  / 1
9 : ExpOne -> . FALSE  / 1
10 : ExpOne -> . IDENT  / 1
11 : ExpOne -> . LPAREN Exp RPAREN  / 1
12 : ExpOne -> . LAMBDA LPAREN IDENT COLON Typ RPAREN DARROW Exp  / 1
13 : ExpOne -> . LPAREN Exp COMMA Exp RPAREN  / 1
14 : ExpOne -> . FST Exp  / 1
15 : ExpOne -> . SND Exp  / 1
16 : ExpOne -> . IF Exp THEN Exp ELSE Exp  / 1

$ => accept
IDENT => shift 7
LPAREN => shift 6
LAMBDA => shift 5
FST => shift 4
SND => shift 3
UNIT => shift 2
TRUE => shift 9
FALSE => shift 8
IF => shift 1
ExpOne => goto 17

-----

State 11:

5 : Exp -> ExpOne .  / 3

$ => reduce 5
IDENT => reduce 5
LPAREN => reduce 5
RPAREN => reduce 5
LAMBDA => reduce 5
COMMA => reduce 5
FST => reduce 5
SND => reduce 5
UNIT => reduce 5
TRUE => reduce 5
FALSE => reduce 5
IF => reduce 5
THEN => reduce 5
ELSE => reduce 5

-----

State 12:

6 : Exp -> Exp . ExpOne  / 2
7 : ExpOne -> . UNIT  / 2
8 : ExpOne -> . TRUE  / 2
9 : ExpOne -> . FALSE  / 2
10 : ExpOne -> . IDENT  / 2
11 : ExpOne -> . LPAREN Exp RPAREN  / 2
12 : ExpOne -> . LAMBDA LPAREN IDENT COLON Typ RPAREN DARROW Exp  / 2
13 : ExpOne -> . LPAREN Exp COMMA Exp RPAREN  / 2
14 : ExpOne -> . FST Exp  / 2
15 : ExpOne -> . SND Exp  / 2
16 : ExpOne -> . IF Exp THEN Exp ELSE Exp  / 2
16 : ExpOne -> IF Exp . THEN Exp ELSE Exp  / 3

IDENT => shift 7
LPAREN => shift 6
LAMBDA => shift 5
FST => shift 4
SND => shift 3
UNIT => shift 2
TRUE => shift 9
FALSE => shift 8
IF => shift 1
THEN => shift 18
ExpOne => goto 17

-----

State 13:

6 : Exp -> Exp . ExpOne  / 3
7 : ExpOne -> . UNIT  / 3
8 : ExpOne -> . TRUE  / 3
9 : ExpOne -> . FALSE  / 3
10 : ExpOne -> . IDENT  / 3
11 : ExpOne -> . LPAREN Exp RPAREN  / 3
12 : ExpOne -> . LAMBDA LPAREN IDENT COLON Typ RPAREN DARROW Exp  / 3
13 : ExpOne -> . LPAREN Exp COMMA Exp RPAREN  / 3
14 : ExpOne -> . FST Exp  / 3
15 : ExpOne -> . SND Exp  / 3
15 : ExpOne -> SND Exp .  / 3
16 : ExpOne -> . IF Exp THEN Exp ELSE Exp  / 3

$ => reduce 15
IDENT => shift 7, reduce 15  CONFLICT
LPAREN => shift 6, reduce 15  CONFLICT
RPAREN => reduce 15
LAMBDA => shift 5, reduce 15  CONFLICT
COMMA => reduce 15
FST => shift 4, reduce 15  CONFLICT
SND => shift 3, reduce 15  CONFLICT
UNIT => shift 2, reduce 15  CONFLICT
TRUE => shift 9, reduce 15  CONFLICT
FALSE => shift 8, reduce 15  CONFLICT
IF => shift 1, reduce 15  CONFLICT
THEN => reduce 15
ELSE => reduce 15
ExpOne => goto 17

-----

State 14:

6 : Exp -> Exp . ExpOne  / 3
7 : ExpOne -> . UNIT  / 3
8 : ExpOne -> . TRUE  / 3
9 : ExpOne -> . FALSE  / 3
10 : ExpOne -> . IDENT  / 3
11 : ExpOne -> . LPAREN Exp RPAREN  / 3
12 : ExpOne -> . LAMBDA LPAREN IDENT COLON Typ RPAREN DARROW Exp  / 3
13 : ExpOne -> . LPAREN Exp COMMA Exp RPAREN  / 3
14 : ExpOne -> . FST Exp  / 3
14 : ExpOne -> FST Exp .  / 3
15 : ExpOne -> . SND Exp  / 3
16 : ExpOne -> . IF Exp THEN Exp ELSE Exp  / 3

$ => reduce 14
IDENT => shift 7, reduce 14  CONFLICT
LPAREN => shift 6, reduce 14  CONFLICT
RPAREN => reduce 14
LAMBDA => shift 5, reduce 14  CONFLICT
COMMA => reduce 14
FST => shift 4, reduce 14  CONFLICT
SND => shift 3, reduce 14  CONFLICT
UNIT => shift 2, reduce 14  CONFLICT
TRUE => shift 9, reduce 14  CONFLICT
FALSE => shift 8, reduce 14  CONFLICT
IF => shift 1, reduce 14  CONFLICT
THEN => reduce 14
ELSE => reduce 14
ExpOne => goto 17

-----

State 15:

12 : ExpOne -> LAMBDA LPAREN . IDENT COLON Typ RPAREN DARROW Exp  / 3

IDENT => shift 19

-----

State 16:

6 : Exp -> Exp . ExpOne  / 4
7 : ExpOne -> . UNIT  / 4
8 : ExpOne -> . TRUE  / 4
9 : ExpOne -> . FALSE  / 4
10 : ExpOne -> . IDENT  / 4
11 : ExpOne -> . LPAREN Exp RPAREN  / 4
11 : ExpOne -> LPAREN Exp . RPAREN  / 3
12 : ExpOne -> . LAMBDA LPAREN IDENT COLON Typ RPAREN DARROW Exp  / 4
13 : ExpOne -> . LPAREN Exp COMMA Exp RPAREN  / 4
13 : ExpOne -> LPAREN Exp . COMMA Exp RPAREN  / 3
14 : ExpOne -> . FST Exp  / 4
15 : ExpOne -> . SND Exp  / 4
16 : ExpOne -> . IF Exp THEN Exp ELSE Exp  / 4

IDENT => shift 7
LPAREN => shift 6
RPAREN => shift 21
LAMBDA => shift 5
COMMA => shift 20
FST => shift 4
SND => shift 3
UNIT => shift 2
TRUE => shift 9
FALSE => shift 8
IF => shift 1
ExpOne => goto 17

-----

State 17:

6 : Exp -> Exp ExpOne .  / 3

$ => reduce 6
IDENT => reduce 6
LPAREN => reduce 6
RPAREN => reduce 6
LAMBDA => reduce 6
COMMA => reduce 6
FST => reduce 6
SND => reduce 6
UNIT => reduce 6
TRUE => reduce 6
FALSE => reduce 6
IF => reduce 6
THEN => reduce 6
ELSE => reduce 6

-----

State 18:

5 : Exp -> . ExpOne  / 5
6 : Exp -> . Exp ExpOne  / 5
7 : ExpOne -> . UNIT  / 5
8 : ExpOne -> . TRUE  / 5
9 : ExpOne -> . FALSE  / 5
10 : ExpOne -> . IDENT  / 5
11 : ExpOne -> . LPAREN Exp RPAREN  / 5
12 : ExpOne -> . LAMBDA LPAREN IDENT COLON Typ RPAREN DARROW Exp  / 5
13 : ExpOne -> . LPAREN Exp COMMA Exp RPAREN  / 5
14 : ExpOne -> . FST Exp  / 5
15 : ExpOne -> . SND Exp  / 5
16 : ExpOne -> . IF Exp THEN Exp ELSE Exp  / 5
16 : ExpOne -> IF Exp THEN . Exp ELSE Exp  / 3

IDENT => shift 7
LPAREN => shift 6
LAMBDA => shift 5
FST => shift 4
SND => shift 3
UNIT => shift 2
TRUE => shift 9
FALSE => shift 8
IF => shift 1
Exp => goto 22
ExpOne => goto 11

-----

State 19:

12 : ExpOne -> LAMBDA LPAREN IDENT . COLON Typ RPAREN DARROW Exp  / 3

COLON => shift 23

-----

State 20:

5 : Exp -> . ExpOne  / 6
6 : Exp -> . Exp ExpOne  / 6
7 : ExpOne -> . UNIT  / 6
8 : ExpOne -> . TRUE  / 6
9 : ExpOne -> . FALSE  / 6
10 : ExpOne -> . IDENT  / 6
11 : ExpOne -> . LPAREN Exp RPAREN  / 6
12 : ExpOne -> . LAMBDA LPAREN IDENT COLON Typ RPAREN DARROW Exp  / 6
13 : ExpOne -> . LPAREN Exp COMMA Exp RPAREN  / 6
13 : ExpOne -> LPAREN Exp COMMA . Exp RPAREN  / 3
14 : ExpOne -> . FST Exp  / 6
15 : ExpOne -> . SND Exp  / 6
16 : ExpOne -> . IF Exp THEN Exp ELSE Exp  / 6

IDENT => shift 7
LPAREN => shift 6
LAMBDA => shift 5
FST => shift 4
SND => shift 3
UNIT => shift 2
TRUE => shift 9
FALSE => shift 8
IF => shift 1
Exp => goto 24
ExpOne => goto 11

-----

State 21:

11 : ExpOne -> LPAREN Exp RPAREN .  / 3

$ => reduce 11
IDENT => reduce 11
LPAREN => reduce 11
RPAREN => reduce 11
LAMBDA => reduce 11
COMMA => reduce 11
FST => reduce 11
SND => reduce 11
UNIT => reduce 11
TRUE => reduce 11
FALSE => reduce 11
IF => reduce 11
THEN => reduce 11
ELSE => reduce 11

-----

State 22:

6 : Exp -> Exp . ExpOne  / 5
7 : ExpOne -> . UNIT  / 5
8 : ExpOne -> . TRUE  / 5
9 : ExpOne -> . FALSE  / 5
10 : ExpOne -> . IDENT  / 5
11 : ExpOne -> . LPAREN Exp RPAREN  / 5
12 : ExpOne -> . LAMBDA LPAREN IDENT COLON Typ RPAREN DARROW Exp  / 5
13 : ExpOne -> . LPAREN Exp COMMA Exp RPAREN  / 5
14 : ExpOne -> . FST Exp  / 5
15 : ExpOne -> . SND Exp  / 5
16 : ExpOne -> . IF Exp THEN Exp ELSE Exp  / 5
16 : ExpOne -> IF Exp THEN Exp . ELSE Exp  / 3

IDENT => shift 7
LPAREN => shift 6
LAMBDA => shift 5
FST => shift 4
SND => shift 3
UNIT => shift 2
TRUE => shift 9
FALSE => shift 8
IF => shift 1
ELSE => shift 25
ExpOne => goto 17

-----

State 23:

0 : Typ -> . UNITTY  / 7
1 : Typ -> . BOOL  / 7
2 : Typ -> . LPAREN Typ RPAREN  / 7
3 : Typ -> . Typ ARROW Typ  / 7
4 : Typ -> . Typ TIMES Typ  / 7
12 : ExpOne -> LAMBDA LPAREN IDENT COLON . Typ RPAREN DARROW Exp  / 3

LPAREN => shift 29
UNITTY => shift 28
BOOL => shift 27
Typ => goto 26

-----

State 24:

6 : Exp -> Exp . ExpOne  / 6
7 : ExpOne -> . UNIT  / 6
8 : ExpOne -> . TRUE  / 6
9 : ExpOne -> . FALSE  / 6
10 : ExpOne -> . IDENT  / 6
11 : ExpOne -> . LPAREN Exp RPAREN  / 6
12 : ExpOne -> . LAMBDA LPAREN IDENT COLON Typ RPAREN DARROW Exp  / 6
13 : ExpOne -> . LPAREN Exp COMMA Exp RPAREN  / 6
13 : ExpOne -> LPAREN Exp COMMA Exp . RPAREN  / 3
14 : ExpOne -> . FST Exp  / 6
15 : ExpOne -> . SND Exp  / 6
16 : ExpOne -> . IF Exp THEN Exp ELSE Exp  / 6

IDENT => shift 7
LPAREN => shift 6
RPAREN => shift 30
LAMBDA => shift 5
FST => shift 4
SND => shift 3
UNIT => shift 2
TRUE => shift 9
FALSE => shift 8
IF => shift 1
ExpOne => goto 17

-----

State 25:

5 : Exp -> . ExpOne  / 3
6 : Exp -> . Exp ExpOne  / 3
7 : ExpOne -> . UNIT  / 3
8 : ExpOne -> . TRUE  / 3
9 : ExpOne -> . FALSE  / 3
10 : ExpOne -> . IDENT  / 3
11 : ExpOne -> . LPAREN Exp RPAREN  / 3
12 : ExpOne -> . LAMBDA LPAREN IDENT COLON Typ RPAREN DARROW Exp  / 3
13 : ExpOne -> . LPAREN Exp COMMA Exp RPAREN  / 3
14 : ExpOne -> . FST Exp  / 3
15 : ExpOne -> . SND Exp  / 3
16 : ExpOne -> . IF Exp THEN Exp ELSE Exp  / 3
16 : ExpOne -> IF Exp THEN Exp ELSE . Exp  / 3

IDENT => shift 7
LPAREN => shift 6
LAMBDA => shift 5
FST => shift 4
SND => shift 3
UNIT => shift 2
TRUE => shift 9
FALSE => shift 8
IF => shift 1
Exp => goto 31
ExpOne => goto 11

-----

State 26:

3 : Typ -> Typ . ARROW Typ  / 7
4 : Typ -> Typ . TIMES Typ  / 7
12 : ExpOne -> LAMBDA LPAREN IDENT COLON Typ . RPAREN DARROW Exp  / 3

RPAREN => shift 32
ARROW => shift 33
TIMES => shift 34

-----

State 27:

1 : Typ -> BOOL .  / 7

RPAREN => reduce 1
ARROW => reduce 1
TIMES => reduce 1

-----

State 28:

0 : Typ -> UNITTY .  / 7

RPAREN => reduce 0
ARROW => reduce 0
TIMES => reduce 0

-----

State 29:

0 : Typ -> . UNITTY  / 7
1 : Typ -> . BOOL  / 7
2 : Typ -> . LPAREN Typ RPAREN  / 7
2 : Typ -> LPAREN . Typ RPAREN  / 7
3 : Typ -> . Typ ARROW Typ  / 7
4 : Typ -> . Typ TIMES Typ  / 7

LPAREN => shift 29
UNITTY => shift 28
BOOL => shift 27
Typ => goto 35

-----

State 30:

13 : ExpOne -> LPAREN Exp COMMA Exp RPAREN .  / 3

$ => reduce 13
IDENT => reduce 13
LPAREN => reduce 13
RPAREN => reduce 13
LAMBDA => reduce 13
COMMA => reduce 13
FST => reduce 13
SND => reduce 13
UNIT => reduce 13
TRUE => reduce 13
FALSE => reduce 13
IF => reduce 13
THEN => reduce 13
ELSE => reduce 13

-----

State 31:

6 : Exp -> Exp . ExpOne  / 3
7 : ExpOne -> . UNIT  / 3
8 : ExpOne -> . TRUE  / 3
9 : ExpOne -> . FALSE  / 3
10 : ExpOne -> . IDENT  / 3
11 : ExpOne -> . LPAREN Exp RPAREN  / 3
12 : ExpOne -> . LAMBDA LPAREN IDENT COLON Typ RPAREN DARROW Exp  / 3
13 : ExpOne -> . LPAREN Exp COMMA Exp RPAREN  / 3
14 : ExpOne -> . FST Exp  / 3
15 : ExpOne -> . SND Exp  / 3
16 : ExpOne -> . IF Exp THEN Exp ELSE Exp  / 3
16 : ExpOne -> IF Exp THEN Exp ELSE Exp .  / 3

$ => reduce 16
IDENT => shift 7, reduce 16  CONFLICT
LPAREN => shift 6, reduce 16  CONFLICT
RPAREN => reduce 16
LAMBDA => shift 5, reduce 16  CONFLICT
COMMA => reduce 16
FST => shift 4, reduce 16  CONFLICT
SND => shift 3, reduce 16  CONFLICT
UNIT => shift 2, reduce 16  CONFLICT
TRUE => shift 9, reduce 16  CONFLICT
FALSE => shift 8, reduce 16  CONFLICT
IF => shift 1, reduce 16  CONFLICT
THEN => reduce 16
ELSE => reduce 16
ExpOne => goto 17

-----

State 32:

12 : ExpOne -> LAMBDA LPAREN IDENT COLON Typ RPAREN . DARROW Exp  / 3

DARROW => shift 36

-----

State 33:

0 : Typ -> . UNITTY  / 7
1 : Typ -> . BOOL  / 7
2 : Typ -> . LPAREN Typ RPAREN  / 7
3 : Typ -> . Typ ARROW Typ  / 7
3 : Typ -> Typ ARROW . Typ  / 7
4 : Typ -> . Typ TIMES Typ  / 7

LPAREN => shift 29
UNITTY => shift 28
BOOL => shift 27
Typ => goto 37

-----

State 34:

0 : Typ -> . UNITTY  / 7
1 : Typ -> . BOOL  / 7
2 : Typ -> . LPAREN Typ RPAREN  / 7
3 : Typ -> . Typ ARROW Typ  / 7
4 : Typ -> . Typ TIMES Typ  / 7
4 : Typ -> Typ TIMES . Typ  / 7

LPAREN => shift 29
UNITTY => shift 28
BOOL => shift 27
Typ => goto 38

-----

State 35:

2 : Typ -> LPAREN Typ . RPAREN  / 7
3 : Typ -> Typ . ARROW Typ  / 7
4 : Typ -> Typ . TIMES Typ  / 7

RPAREN => shift 39
ARROW => shift 33
TIMES => shift 34

-----

State 36:

5 : Exp -> . ExpOne  / 3
6 : Exp -> . Exp ExpOne  / 3
7 : ExpOne -> . UNIT  / 3
8 : ExpOne -> . TRUE  / 3
9 : ExpOne -> . FALSE  / 3
10 : ExpOne -> . IDENT  / 3
11 : ExpOne -> . LPAREN Exp RPAREN  / 3
12 : ExpOne -> . LAMBDA LPAREN IDENT COLON Typ RPAREN DARROW Exp  / 3
12 : ExpOne -> LAMBDA LPAREN IDENT COLON Typ RPAREN DARROW . Exp  / 3
13 : ExpOne -> . LPAREN Exp COMMA Exp RPAREN  / 3
14 : ExpOne -> . FST Exp  / 3
15 : ExpOne -> . SND Exp  / 3
16 : ExpOne -> . IF Exp THEN Exp ELSE Exp  / 3

IDENT => shift 7
LPAREN => shift 6
LAMBDA => shift 5
FST => shift 4
SND => shift 3
UNIT => shift 2
TRUE => shift 9
FALSE => shift 8
IF => shift 1
Exp => goto 40
ExpOne => goto 11

-----

State 37:

3 : Typ -> Typ . ARROW Typ  / 7
3 : Typ -> Typ ARROW Typ .  / 7
4 : Typ -> Typ . TIMES Typ  / 7

RPAREN => reduce 3
ARROW => shift 33, reduce 3  PRECEDENCE
TIMES => shift 34, reduce 3  PRECEDENCE

-----

State 38:

3 : Typ -> Typ . ARROW Typ  / 7
4 : Typ -> Typ . TIMES Typ  / 7
4 : Typ -> Typ TIMES Typ .  / 7

RPAREN => reduce 4
ARROW => reduce 4, shift 33  PRECEDENCE
TIMES => reduce 4, shift 34  PRECEDENCE

-----

State 39:

2 : Typ -> LPAREN Typ RPAREN .  / 7

RPAREN => reduce 2
ARROW => reduce 2
TIMES => reduce 2

-----

State 40:

6 : Exp -> Exp . ExpOne  / 3
7 : ExpOne -> . UNIT  / 3
8 : ExpOne -> . TRUE  / 3
9 : ExpOne -> . FALSE  / 3
10 : ExpOne -> . IDENT  / 3
11 : ExpOne -> . LPAREN Exp RPAREN  / 3
12 : ExpOne -> . LAMBDA LPAREN IDENT COLON Typ RPAREN DARROW Exp  / 3
12 : ExpOne -> LAMBDA LPAREN IDENT COLON Typ RPAREN DARROW Exp .  / 3
13 : ExpOne -> . LPAREN Exp COMMA Exp RPAREN  / 3
14 : ExpOne -> . FST Exp  / 3
15 : ExpOne -> . SND Exp  / 3
16 : ExpOne -> . IF Exp THEN Exp ELSE Exp  / 3

$ => reduce 12
IDENT => shift 7, reduce 12  CONFLICT
LPAREN => shift 6, reduce 12  CONFLICT
RPAREN => reduce 12
LAMBDA => shift 5, reduce 12  CONFLICT
COMMA => reduce 12
FST => shift 4, reduce 12  CONFLICT
SND => shift 3, reduce 12  CONFLICT
UNIT => shift 2, reduce 12  CONFLICT
TRUE => shift 9, reduce 12  CONFLICT
FALSE => shift 8, reduce 12  CONFLICT
IF => shift 1, reduce 12  CONFLICT
THEN => reduce 12
ELSE => reduce 12
ExpOne => goto 17

-----

lookahead 0 = $ 
lookahead 1 = $ IDENT LPAREN LAMBDA FST SND UNIT TRUE FALSE IF 
lookahead 2 = IDENT LPAREN LAMBDA FST SND UNIT TRUE FALSE IF THEN 
lookahead 3 = $ IDENT LPAREN RPAREN LAMBDA COMMA FST SND UNIT TRUE FALSE IF THEN ELSE 
lookahead 4 = IDENT LPAREN RPAREN LAMBDA COMMA FST SND UNIT TRUE FALSE IF 
lookahead 5 = IDENT LPAREN LAMBDA FST SND UNIT TRUE FALSE IF ELSE 
lookahead 6 = IDENT LPAREN RPAREN LAMBDA FST SND UNIT TRUE FALSE IF 
lookahead 7 = RPAREN ARROW TIMES 

*)

struct
local
structure Value = struct
datatype nonterminal =
nonterminal
| string of Arg.string
| typ of Arg.typ
| exp of Arg.exp
end
structure ParseEngine = ParseEngineFun (structure Streamable = Streamable
type terminal = Arg.terminal
type value = Value.nonterminal
val dummy = Value.nonterminal
fun read terminal =
(case terminal of
Arg.IDENT x => (1, Value.string x)
| Arg.LPAREN => (2, Value.nonterminal)
| Arg.RPAREN => (3, Value.nonterminal)
| Arg.ARROW => (4, Value.nonterminal)
| Arg.TIMES => (5, Value.nonterminal)
| Arg.LAMBDA => (6, Value.nonterminal)
| Arg.DARROW => (7, Value.nonterminal)
| Arg.COLON => (8, Value.nonterminal)
| Arg.COMMA => (9, Value.nonterminal)
| Arg.FST => (10, Value.nonterminal)
| Arg.SND => (11, Value.nonterminal)
| Arg.UNIT => (12, Value.nonterminal)
| Arg.UNITTY => (13, Value.nonterminal)
| Arg.BOOL => (14, Value.nonterminal)
| Arg.TRUE => (15, Value.nonterminal)
| Arg.FALSE => (16, Value.nonterminal)
| Arg.IF => (17, Value.nonterminal)
| Arg.THEN => (18, Value.nonterminal)
| Arg.ELSE => (19, Value.nonterminal)
)
)
in
val parse = ParseEngine.parse (
ParseEngine.next5x1 "\128\136\135\128\128\128\134\128\128\128\133\132\131\128\128\138\137\130\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\135\128\128\128\134\128\128\128\133\132\131\128\128\138\137\130\128\128\128\128\128\128\128\128\128\128\128\128\128\128wwww\128\128w\128\128wwww\128\128wwwww\128\128\128\128\128\128\128\128\128\128\128\128\128\136\135\128\128\128\134\128\128\128\133\132\131\128\128\138\137\130\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\135\128\128\128\134\128\128\128\133\132\131\128\128\138\137\130\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\144\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\135\128\128\128\134\128\128\128\133\132\131\128\128\138\137\130\128\128\128\128\128\128\128\128\128\128\128\128\128\128tttt\128\128t\128\128tttt\128\128ttttt\128\128\128\128\128\128\128\128\128\128\128\128uuuu\128\128u\128\128uuuu\128\128uuuuu\128\128\128\128\128\128\128\128\128\128\128\128vvvv\128\128v\128\128vvvv\128\128vvvvv\128\128\128\128\128\128\128\128\128\128\128\128\127\136\135\128\128\128\134\128\128\128\133\132\131\128\128\138\137\130\128\128\128\128\128\128\128\128\128\128\128\128\128\128yyyy\128\128y\128\128yyyy\128\128yyyyy\128\128\128\128\128\128\128\128\128\128\128\128\128\136\135\128\128\128\134\128\128\128\133\132\131\128\128\138\137\130\147\128\128\128\128\128\128\128\128\128\128\128\128\128o\136\135o\128\128\134\128\128o\133\132\131\128\128\138\137\130oo\128\128\128\128\128\128\128\128\128\128\128\128p\136\135p\128\128\134\128\128p\133\132\131\128\128\138\137\130pp\128\128\128\128\128\128\128\128\128\128\128\128\128\148\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\135\150\128\128\134\128\128\149\133\132\131\128\128\138\137\130\128\128\128\128\128\128\128\128\128\128\128\128\128\128xxxx\128\128x\128\128xxxx\128\128xxxxx\128\128\128\128\128\128\128\128\128\128\128\128\128\136\135\128\128\128\134\128\128\128\133\132\131\128\128\138\137\130\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\152\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\135\128\128\128\134\128\128\128\133\132\131\128\128\138\137\130\128\128\128\128\128\128\128\128\128\128\128\128\128\128ssss\128\128s\128\128ssss\128\128sssss\128\128\128\128\128\128\128\128\128\128\128\128\128\136\135\128\128\128\134\128\128\128\133\132\131\128\128\138\137\130\128\154\128\128\128\128\128\128\128\128\128\128\128\128\128\128\158\128\128\128\128\128\128\128\128\128\128\157\156\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\135\159\128\128\134\128\128\128\133\132\131\128\128\138\137\130\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\135\128\128\128\134\128\128\128\133\132\131\128\128\138\137\130\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\161\162\163\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128}}}\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128~~~\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\158\128\128\128\128\128\128\128\128\128\128\157\156\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128qqqq\128\128q\128\128qqqq\128\128qqqqq\128\128\128\128\128\128\128\128\128\128\128\128n\136\135n\128\128\134\128\128n\133\132\131\128\128\138\137\130nn\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\165\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\158\128\128\128\128\128\128\128\128\128\128\157\156\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\158\128\128\128\128\128\128\128\128\128\128\157\156\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\168\162\163\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\136\135\128\128\128\134\128\128\128\133\132\131\128\128\138\137\130\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128{\162\163\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128zzz\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128|||\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128r\136\135r\128\128\134\128\128r\133\132\131\128\128\138\137\130rr\128\128\128\128\128\128\128\128\128\128\128\128",
ParseEngine.next5x1 "\128\138\139\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\140\139\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\141\139\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\142\139\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\144\139\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\145\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\145\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\145\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\145\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\145\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\150\139\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\152\139\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\145\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\154\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\145\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\159\139\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\163\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\145\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\165\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\166\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\168\139\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\145\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128",
Vector.fromList [(0,1,(fn _::rest => Value.typ(Arg.unitty {})::rest|_=>raise (Fail "bad parser"))),
(0,1,(fn _::rest => Value.typ(Arg.bool {})::rest|_=>raise (Fail "bad parser"))),
(0,3,(fn _::Value.typ(arg0)::_::rest => Value.typ(Arg.id_typ arg0)::rest|_=>raise (Fail "bad parser"))),
(0,3,(fn Value.typ(arg0)::_::Value.typ(arg1)::rest => Value.typ(Arg.Arrow {2=arg0,1=arg1})::rest|_=>raise (Fail "bad parser"))),
(0,3,(fn Value.typ(arg0)::_::Value.typ(arg1)::rest => Value.typ(Arg.Times {2=arg0,1=arg1})::rest|_=>raise (Fail "bad parser"))),
(1,1,(fn Value.exp(arg0)::rest => Value.exp(Arg.id_exp arg0)::rest|_=>raise (Fail "bad parser"))),
(1,2,(fn Value.exp(arg0)::Value.exp(arg1)::rest => Value.exp(Arg.Apply {2=arg0,1=arg1})::rest|_=>raise (Fail "bad parser"))),
(2,1,(fn _::rest => Value.exp(Arg.unit {})::rest|_=>raise (Fail "bad parser"))),
(2,1,(fn _::rest => Value.exp(Arg.tt {})::rest|_=>raise (Fail "bad parser"))),
(2,1,(fn _::rest => Value.exp(Arg.ff {})::rest|_=>raise (Fail "bad parser"))),
(2,1,(fn Value.string(arg0)::rest => Value.exp(Arg.Variable arg0)::rest|_=>raise (Fail "bad parser"))),
(2,3,(fn _::Value.exp(arg0)::_::rest => Value.exp(Arg.id_exp arg0)::rest|_=>raise (Fail "bad parser"))),
(2,8,(fn Value.exp(arg0)::_::_::Value.typ(arg1)::_::Value.string(arg2)::_::_::rest => Value.exp(Arg.lambda {3=arg0,2=arg1,1=arg2})::rest|_=>raise (Fail "bad parser"))),
(2,5,(fn _::Value.exp(arg0)::_::Value.exp(arg1)::_::rest => Value.exp(Arg.Tuple {2=arg0,1=arg1})::rest|_=>raise (Fail "bad parser"))),
(2,2,(fn Value.exp(arg0)::_::rest => Value.exp(Arg.First arg0)::rest|_=>raise (Fail "bad parser"))),
(2,2,(fn Value.exp(arg0)::_::rest => Value.exp(Arg.Second arg0)::rest|_=>raise (Fail "bad parser"))),
(2,6,(fn Value.exp(arg0)::_::Value.exp(arg1)::_::Value.exp(arg2)::_::rest => Value.exp(Arg.IfThenElse {3=arg0,2=arg1,1=arg2})::rest|_=>raise (Fail "bad parser")))],
(fn Value.exp x => x | _ => raise (Fail "bad parser")), Arg.error)
end
end
