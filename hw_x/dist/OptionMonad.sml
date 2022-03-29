structure OptionMonad :> MONAD where type 'a t = 'a option =
  struct
    infix 1 >>=
    infixr 1 >=>

    type 'a t = 'a option

    fun map (f : 'a -> 'b) : 'a t -> 'b t =
      fn NONE   => NONE
       | SOME x => SOME (f x)

    fun return (x : 'a) : 'a t = SOME x

    fun (opt : 'a t) >>= (f : 'a -> 'b t) : 'b t =
      case opt of
        NONE   => NONE
      | SOME x => f x

    fun (f : 'a -> 'b t) >=> (g : 'b -> 'c t) : 'a -> 'c t =
      fn (a : 'a) => return a >>= f >>= g

    fun join optopt =
      case optopt of
        NONE     => NONE
      | SOME opt => (
        case opt of
          NONE   => NONE
        | SOME x => SOME x
      )
  end
