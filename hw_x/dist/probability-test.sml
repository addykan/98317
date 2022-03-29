infix 1 >>=
infixr 1 >=>

open ProbabilityMonad

local
  structure Dict =
    RedBlackMapFn (
      type ord_key = int
      val compare = Int.compare
    )
  val insertWith = fn f => fn (d, k, v) =>
    case Dict.find (d, k) of
      NONE    => Dict.insert (d, k, v)
    | SOME v' => Dict.insert (d, k, f (v', v))
  type 'a tofrom = ('a -> int) * (int -> 'a)
in
  (* utility for compressing entries of a distribution *)
  val compress : 'a tofrom -> 'a t -> 'a t = fn (to, from) =>
    List.map (fn (i, p) => (from i, p))
    o Dict.listItemsi
    o List.foldr
        (fn ((x, p), d) => insertWith op+ (d, to x, p))
        Dict.empty
end

(* ****************************** wakeup ****************************** *)

datatype wakeup = Early | Late

val transition : wakeup -> wakeup t =
 fn Early => [(Early, 0.7), (Late, 0.3)]
  | Late  => [(Late, 0.9), (Early, 0.1)]

local
  val tofrom = (
    fn Early => 0 | Late => 1,
    fn 0 => Early | 1 => Late | _ => raise Match
  )
  (* shadow >>= and >=>, so they compresses automatically *)
  val op >>= = compress tofrom o (op >>=)
  val op >=> = fn (f, g) => compress tofrom o (f >=> g)
in
  fun simulate 0 w = return w
    | simulate n w = simulate (n - 1) w >>= transition
end

val lateAtEndOfSemester = 0.0  (* TODO *)


(* ****************************** monopoly ****************************** *)

(* 6-sided die *)
val d6 = List.tabulate (6, fn i => (i + 1, 1.0 / 6.0))

datatype state = InJail | OutOfJail

local
  val tofrom = (
    fn InJail => 0 | OutOfJail => 1,
    fn 0 => InJail | 1 => OutOfJail | _ => raise Match
  )
  (* shadow >>= and >=>, so they compresses automatically *)
  val op >>= = compress tofrom o (op >>=)
  val op >=> = fn (f, g) => compress tofrom o (f >=> g)
in
  val jailRoll : state -> state t =
    fn (state : state) => [(InJail, 1.0)]  (* TODO *)

  val getOutOfJail = jailRoll >=> jailRoll >=> jailRoll
end

(* EXPECTED: [(OutOfJail,1.0)], since already out of jail to begin with *)
val ifOutOfJail = getOutOfJail OutOfJail

(* EXPECTED: [(InJail,1-P),(OutOfJail,P)], for some P... what is it? *)
val ifInJail = getOutOfJail InJail
