structure LogMonad :> MONAD where type 'a t = string * 'a =
  struct
    infix 1 >>=
    infixr 1 >=>

    type 'a t = string * 'a

    fun map (f : 'a -> 'b) : 'a t -> 'b t =
      fn (x, v) => (x, f v)

    fun return (x : 'a) : 'a t =
      ("", x)

    fun (x : 'a t) >>= (f : 'a -> 'b t) : 'b t =
      let
        val (s, v) = x
        val (fStr, fRes) = f v
      in
        (s ^ fStr, fRes)
      end

    fun (f : 'a -> 'b t) >=> (g : 'b -> 'c t) : 'a -> 'c t =
      fn x => 
        let
          val (s, fRes) = f x
          val (gS, gRes) = g fRes
        in
          (s ^ gS, gRes)
        end

    fun join (x : 'a t t) : 'a t =
      let
        val (s1, (s2, v)) = x
      in
        (s1 ^ s2, v)
      end
  end
