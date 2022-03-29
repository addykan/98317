functor ImperativeMonad (type state) :> MONAD where type 'a t = state -> { state : state, value : 'a } =
  MkMonad (
    type 'a t = state -> { state : state, value : 'a }

    fun return x = fn state => { state = state, value = x }

    infix 1 >>=
    fun (x : 'a t) >>= (f : 'a -> 'b t) : 'b t =
      fn (state : state) =>
        let
          val {state, value} = x state
        in
          f value state
        end
  )
