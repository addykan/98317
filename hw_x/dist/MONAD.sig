signature MONAD =
  sig
    include MAPPABLE

    val return : 'a -> 'a t

    val >>= : 'a t * ('a -> 'b t) -> 'b t
    val >=> : ('a -> 'b t) * ('b -> 'c t) -> 'a -> 'c t
    val join : 'a t t -> 'a t
  end
