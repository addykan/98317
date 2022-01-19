structure Lexer =
struct
  datatype token =
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
  | IF
  | THEN
  | ELSE
  | UNITTY
  | UNIT
  | BOOL
  | TRUE
  | FALSE

  open Stream

  exception Error

  type pos = int

  type t = int -> (token * pos) front

  type self = { lexmain : char stream -> t }

  type info = { match : char list,
                len : int,
                start : char stream,
                follow : char stream,
                self : self }

  fun action f ({ match, len, follow, self, ... }:info) pos =
     Cons (f (match, len, pos), lazy (fn () => #lexmain self follow (pos+len)))

  fun simple token ({ len, follow, self, ... }:info) pos =
     Cons ((token, pos), lazy (fn () => #lexmain self follow (pos+len)))

  structure Arg =
  struct
    type symbol = char
    val ord = Char.ord

    type t = t

    type self = self
    type info = info

    fun eof _ _ = Nil

    fun skip ({ len, follow, self, ... }:info) pos = #lexmain self follow (pos+len)

    val ident = action (fn (chars, _, pos) => (IDENT (implode chars), pos))

    fun error _ pos =
      (print "Lexical error at "; print (Int.toString pos); print ".\n"; raise Error)

    val lparen = simple LPAREN
    val rparen = simple RPAREN
    val arrow = simple ARROW
    val times = simple TIMES
    val lambda = simple LAMBDA
    val darrow = simple DARROW
    val colon = simple COLON
    val comma = simple COMMA
    val fst = simple FST
    val snd = simple SND
    val if_ = simple IF
    val then_ = simple THEN
    val else_ = simple ELSE
    val unitty = simple UNITTY
    val unit = simple UNIT
    val true_ = simple TRUE
    val false_ = simple FALSE
    val bool = simple BOOL
  end

  structure LexMain =
    SimpleLCLexFun
     (structure Streamable = StreamStreamable
      structure Arg = Arg)

  fun lex s = lazy (fn () => LexMain.lexmain s 0)
end
