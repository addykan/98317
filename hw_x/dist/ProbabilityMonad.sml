structure ProbabilityMonad :> MONAD where type 'a t = ('a * real) list =
  MkMonad (
    type 'a t = ('a * real) list  (* invariant: sum of reals is 1.0 *)

    fun return (x : 'a) : 'a t =
      [(x, 1.0)]

    infix 1 >>=
    fun (dist : 'a t) >>= (f : 'a -> 'b t) : 'b t =
      List.concatMap
        (fn (a, p1) => List.map (fn (b, p2) => (b, p1 * p2)) (f a))
        dist
  )
