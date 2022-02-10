signature CLOGIC =
  sig
    
    datatype ('a,'b) OR = Left of 'a | Right of 'b
    type ('a,'b) AND = 'a * 'b
    datatype FALSE = False of FALSE
    val absurd : FALSE -> 'a 
    type 'a NOT = 'a -> FALSE
    type TRUE = unit

    (* Looks just like iso, but the inverse property is not required! *)
    type ('a,'b) IFF = ('a -> 'b) * ('b -> 'a)


    val easy : unit (* idk :/ *)
    val andElim1 : ('a, 'b) AND -> 'a
    val impTrans : (('a -> 'b), ('b -> 'c)) AND -> ('a -> 'c)
    val sameOR : ('a, 'a) OR -> 'a
    val similarOR : (('a, 'b) OR, ('a -> 'b)) AND -> 'b

    val doubleNegIntro  : 'a -> 'a NOT NOT
    val fillIn : ('a,'b) IFF -> ('a,'b) OR -> ('a,'b) AND
    val concepts : ('a NOT, 'b) OR -> ('a -> 'b)
    val covariance : ('a -> 'b) -> ('c -> ('a,'d) AND) -> ('c -> ('b,'d) AND) 
    val deMorgan : ('a,'b) AND -> (('a NOT, 'b NOT) OR) NOT 
    val contrapositive' : ('b,'b NOT) OR -> ('b NOT -> 'a NOT) -> 'a -> 'b
end

