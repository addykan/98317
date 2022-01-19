structure Parser =
struct
  structure Arg =
  struct
    type string = string

    open SimpleLC

    datatype terminal = datatype Lexer.token

    fun id_typ x = x
    fun id_exp x = x
    val lambda = Lambda o (fn (a, b, c) => ((a, b), c))
    val unitty = fn () => UnitTy
    val unit = fn () => Unit
    val tt = fn () => True
    val ff = fn () => False
    val bool = fn () => Bool

    fun error s =
      case Stream.front s of
        Stream.Nil => (print "Syntax error at end of file.\n"; Fail "parse")
    | Stream.Cons ((_, pos), _) =>
        (print "Syntax error at "; print (Int.toString pos); print ".\n"; Fail "parse")
  end

  type pos = int

  structure StreamWithPos =
     CoercedStreamable (structure Streamable = StreamStreamable
                        type 'a item = 'a * pos
                        fun coerce (x, _) = x)

  structure ParseMain = SimpleLCParseFun (
    structure Streamable = StreamWithPos
    structure Arg = Arg
  )

  val parse = #1 o ParseMain.parse o Lexer.lex o Stream.fromString
end
