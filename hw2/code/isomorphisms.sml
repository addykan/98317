structure Isomorphisms :> ISOMORPHISMS =
  struct
    datatype ('a,'b) either = Left of 'a | Right of 'b
    datatype void = Void of void
    fun absurd (Void v) = absurd v

    type ('a,'b) isomorphic = ('a -> 'b) * ('b -> 'a)

    (* TODO *)
  end
