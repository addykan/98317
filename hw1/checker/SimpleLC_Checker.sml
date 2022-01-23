structure SimpleLC_Checker :>
  sig
    exception TypeError
    val check : SimpleLC.exp -> SimpleLC.typ
  end =
  struct
    structure SLC = SimpleLC (* see slc/SimpleLC.sml *)
    structure Ctx = StringRedBlackDict
    (*
      The signature of Ctx can be found in cmlib/dict.sig, but you probably
      only need to know the following:
        empty   : 'a dict
        insert  : 'a dict -> string -> 'a -> 'a dict
        find    : 'a dict -> string -> 'a option
    *)

    exception TypeError

    fun check_helper ctx = fn
        SLC.Variable x => (
          case Ctx.find ctx x of
            SOME t => t
          | NONE => raise TypeError
        ) (* when we have a variable, we need to look up its type in the context *)
      | SLC.Unit => SLC.UnitTy (* a unit always has type unit! *)
      | SLC.True => SLC.Bool (* true always has type bool! *)
      | SLC.False => SLC.Bool (* false always has type bool! *)
      | SLC.Tuple (e1, e2) => SLC.Times (check_helper ctx e1, check_helper ctx e2) 
      | SLC.First e => (
          case check_helper ctx e of
            SLC.Times (t, _) => t
          | _ => raise TypeError
        ) (* when we have something like <a, b>.1, we get the type of a by recursively typecheck_helpering *)
      | SLC.Second e => (
          case check_helper ctx e of
            SLC.Times (_, t) => t
          | _ => raise TypeError
        )
      | SLC.IfThenElse (b,e1,e2) => (
          case check_helper ctx b of 
            SLC.Bool => 
              let
                val e1Type = check_helper ctx e1
                val e2Type = check_helper ctx e2
              in
                if e1Type = e2Type then e1Type else raise TypeError
              end
          | _ => raise TypeError
        )
      | SLC.Lambda ((x, t), e) => SLC.Arrow (t, check_helper (Ctx.insert ctx x t) e)
          (* hint: don't forget the context, as we discussed in lecture! *)
      | SLC.Apply (e1, e2) => (
          case check_helper ctx e1 of
            SLC.Arrow (t1, t2) =>
              if t1 = check_helper ctx e2 then t2 else raise TypeError
          | _ => raise TypeError
        ) (* we make sure e1 is a function type that takes in e2's type, and return its result type *)

    val check = check_helper Ctx.empty

  end
