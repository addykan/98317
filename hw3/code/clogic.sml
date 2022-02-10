structure Clogic : CLOGIC =
  struct
    
    datatype ('a,'b) OR = Left of 'a | Right of 'b
    type ('a,'b) AND = 'a * 'b
    datatype FALSE = False of FALSE
    val rec absurd = fn False f => absurd f
    type 'a NOT = 'a -> FALSE
    type TRUE = unit

    type ('a,'b) IFF = ('a -> 'b) * ('b -> 'a)

    val easy = raise Fail "Unproven"
    val andElim1 = fn (a, b) => a
    val impTrans = fn (aToB, bToC) => (fn x => bToC (aToB x))
    val sameOR = fn Left a => a | Right b => b
    val similarOR = fn (a, b) => b a

    val doubleNegIntro = (fn y => (fn x => False) False)
    val fillIn = raise Fail "Unproven"
    val concepts = fn Left aNot => (fn a => b) | Right b => (fn a => b)
    val covariance = raise Fail "Unproven"
    val deMorgan = raise Fail "Unproven"
    val contrapositive' = raise Fail "Unproven"

  end
