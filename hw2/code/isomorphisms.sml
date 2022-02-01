structure Isomorphisms :> ISOMORPHISMS =
  struct
    datatype ('a,'b) either = Left of 'a | Right of 'b
    datatype void = Void of void
    fun absurd (Void v) = absurd v

    type ('a,'b) isomorphic = ('a -> 'b) * ('b -> 'a)

    fun forwardInc NONE = Right ()
      | forwardInc (SOME x) = Left x
    fun backwardInc (Left x) = SOME x
      | backwardInc (Right ()) = NONE
    
    val increment = (forwardInc, backwardInc)

    fun forwardThree (Left ()) = LESS
      | forwardThree (Right true) = EQUAL
      | forwardThree (Right false) = GREATER
    
    fun backwardThree LESS = Left ()
      | backwardThree EQUALS = Right true
      | backwardThree GREATER = Right false
    
    val three = (forwardThree, backwardThree)

    fun forwardComm (Left(a)) = Right a
      | forwardComm (Right(a)) = Left a
    fun backwardComm (Right(b)) = Left b
      | backwardComm (Left(b)) = Right b
    
    val commutative_property = (forwardComm, backwardComm)

    fun forwardAssoc (Left(Left(a))) = Left a
      | forwardAssoc (Left(Right(b))) = Right(Left(b))
      | forwardAssoc (Right c) = Right c
    
    fun backwardAssoc Left(a) = Left Left a
      | backwardAssoc (Right(Left(b))) = Left Right b
      | backwardAssoc Right(c) = Right a
    
    val associative_property = (forwardAssoc, backwardAssoc)

    fun distForward Left(a, b) = (a, Left b)
      | distForward Right(a, c) = (a, Right c)
    fun distBack (a, Left b) = Left(a, b)
      | distBack (a, Right c) = Right(a, c)
    
    val distributive_property = (distForward, distBack)

    
  end
