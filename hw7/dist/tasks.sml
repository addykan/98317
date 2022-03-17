local
  open Classical
in
  signature TASKS =
    sig
      (* Continuations *)

      val sum : int list -> int cont -> 'hype

      val any : ('a -> bool) -> 'a list -> bool cont -> 'hype

      val nth : 'a list -> int -> 'a option cont -> 'hype

      val map : ('a -> 'b) -> 'a list -> 'b list cont -> 'hype

      val filter : ('a -> bool) -> 'a list -> 'a list cont -> 'hype

      (* Classical Logic *)

      val freebie : 'a not -> 'a -> 'b

      val contra1 : 'a not -> 'a -> false

      val contra2 : ('a -> false) -> 'a not

      val deMorgan1 : ('a not * 'b not) -> ('a,'b) or not

      val deMorgan2 : ('a not,'b not) or -> ('a * 'b) not

      val dne : 'a not not -> 'a

      val noFun : ('a -> 'b) -> ('a not, 'b) or
    end
end