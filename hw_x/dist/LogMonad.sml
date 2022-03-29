structure LogMonad :> MONAD where type 'a t = string * 'a =
  struct
    infix 1 >>=
    infixr 1 >=>

    type 'a t = string * 'a

    fun map (f : 'a -> 'b) : 'a t -> 'b t =
      raise Fail "TODO"

    fun return (x : 'a) : 'a t =
      raise Fail "TODO"

    fun (x : 'a t) >>= (f : 'a -> 'b t) : 'b t =
      raise Fail "TODO"

    fun (f : 'a -> 'b t) >=> (g : 'b -> 'c t) : 'a -> 'c t =
      raise Fail "TODO"

    fun join (x : 'a t t) : 'a t =
      raise Fail "TODO"
  end
