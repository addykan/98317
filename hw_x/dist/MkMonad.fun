functor MkMonad (
  type 'a t
  val return : 'a -> 'a t
  val >>= : 'a t * ('a -> 'b t) -> 'b t
) :> MONAD where type 'a t = 'a t =
  struct
    infix 1 >>=
    infixr 1 >=>

    type 'a t = 'a t

    fun map (f : 'a -> 'b) (t : 'a t) : 'b t =
      f t

    val return = return
    val op >>= = op >>=

    fun (f : 'a -> 'b t) >=> (g : 'b -> 'c t) : 'a -> 'c t =
      raise Fail "TODO"

    fun join (tt : 'a t t) : 'a t =
      raise Fail "TODO"
  end
