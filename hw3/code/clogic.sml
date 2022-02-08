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
    val andElim1 = raise Fail "Unproven"
    val impTrans = raise Fail "Unproven"
    val sameOR = raise Fail "Unproven"
    val similarOR = raise Fail "Unproven"

    val doubleNegIntro = raise Fail "Unproven"
    val fillIn = raise Fail "Unproven"
    val concepts = raise Fail "Unproven"
    val covariance = raise Fail "Unproven"
    val deMorgan = raise Fail "Unproven"
    val contrapositive' = raise Fail "Unproven"

  end
