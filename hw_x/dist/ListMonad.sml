structure ListMonad :> MONAD where type 'a t = 'a list =
  struct
    infix 1 >>=
    infixr 1 >=>

    type 'a t = 'a list

    fun map (f : 'a -> 'b) : 'a t -> 'b t = List.map f

    fun return (x : 'a) : 'a t = [x]

    fun (l : 'a t) >>= (f : 'a -> 'b t) : 'b t = List.concatMap f l

    fun (f : 'a -> 'b t) >=> (g : 'b -> 'c t) : 'a -> 'c t =
      fn (a : 'a) => return a >>= f >>= g

    fun join l = List.concat l
  end
