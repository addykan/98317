signature CLASSICAL =
  sig
    type void
    val absurd : void -> 'a

    type 'a cont
    val letcc : ('a cont -> 'a) -> 'a
    val throw : 'a cont -> 'a -> 'b
    val catch : ('a -> void) -> 'a cont

    (* logic *)
    (* "and" is an SML keyword but tuples are ok as is *)
    datatype ('a,'b) or = Left of 'a | Right of 'b
    type 'a not = 'a cont
    type true = unit
    type false = void
  end


structure Classical :> CLASSICAL =
  struct
    datatype void = Void of void (* SML hack for a type with no constructor *)

    type 'a cont = 'a SMLofNJ.Cont.cont

    datatype ('a,'b) or = Left of 'a | Right of 'b
    (* "and" is an SML keyword but tuples are ok as is *)
    type 'a not = 'a cont
    type true = unit
    type false = void

    fun absurd (Void v) = absurd v (* believe it or not this is total *)
    val letcc = SMLofNJ.Cont.callcc
    val throw = SMLofNJ.Cont.throw
    val catch = fn f => SMLofNJ.Cont.callcc (absurd o f o letcc o throw)
  end
