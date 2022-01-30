signature ISOMORPHISMS =
  sig
    datatype ('a,'b) either = Left of 'a | Right of 'b
    datatype void = Void of void
    val absurd : void -> 'a

    type ('a,'b) isomorphic = ('a -> 'b) * ('b -> 'a)
    (* It should be that if (f,f') : ('a,'b) isomorphic then f' (f x) = x *)
    (* We don't have the tools to say this in the type system of SML *)

    (* Adding 1 *)
    (* options are increments *)
    val increment : (
      'a option,
      ('a,unit) either
    ) isomorphic

    (* 1 + 2 = 3 *)
    val three : (
      (unit,bool) either,
      order
    ) isomorphic

    (* Properties of arithmetic *)
    (* a + b = b + a *)
    val commutative_property : (
      ('a,'b) either,
      ('b,'a) either
    ) isomorphic

    (* (a + b) + c = a + (b + c) *)
    val associative_property : (
      (('a,'b) either,'c) either,
      ('a,('b,'c) either) either
    ) isomorphic

    (* a * b + a * c = a * (b + c) *)
    val distributive_property : (
      ('a * 'b, 'a * 'c) either,
      'a * ('b, 'c) either
    ) isomorphic

    (* a * 0 = 0 *)
    val zero_property : (
      'a * void,
      void
    ) isomorphic

    (* a + 0 = a *)
    val identity_property : (
      ('a,void) either,
      'a
    ) isomorphic

    (* Exponents are values *)
    (* a^0 = 1 *)
    val power_of_zero : (
      void -> 'a,
      unit
    ) isomorphic

    (* a^1 = a *)
    val power_of_one : (
      unit -> 'a,
      'a
    ) isomorphic

    (* a^3 = a * a * a *)
    val power_of_three : (
      order -> 'a,
      'a * 'a * 'a
    ) isomorphic

    (* a^(b+1) = a^b * a *)
    val power_of_option : (
      'b option -> 'a,
      ('b -> 'a) * 'a
    ) isomorphic

    (* a^(b+c) = a^b * a^c *)
    val power_of_sum : (
      ('b,'c) either -> 'a,
      ('b -> 'a) * ('c -> 'a)
    ) isomorphic

    (* Isomorphisms is an Equivalence Relation *)

    val reflexivity : ('a,'a) isomorphic
    val symmetry : ('a,'b) isomorphic -> ('b,'a) isomorphic
    val transitivity : ('a,'b) isomorphic * ('b,'c) isomorphic -> ('a,'c) isomorphic
  end
