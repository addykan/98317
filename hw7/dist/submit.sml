structure Tasks :> TASKS =
  struct
    open Classical

    (* To test your code:
     * - open Classical Tasks;
     * - letcc (sum [1,2,3]);
     * val it = 6 : int
     * - letcc (map Int.toString [1,2,3]);
     * val it = ["1","2","3"] : string list
     *)

    (* Continuations *)

    val sum = fn [] => (fn f => throw f []) | (x::xs) => (fn f => letcc (fn res => f (x + res)))

    val any = fn f => fn L => filter f L

    val nth = fn (x::xs) => (fn 0 => x | n => nth xs (n-1) ) 

    val map = fn _ => raise Fail "TODO"

    val filter = fn _ => raise Fail "TODO"

    (* Classical Logic *)

    val freebie = fn _ => raise Fail "TODO"

    val contra1 = fn _ => raise Fail "TODO"

    val contra2 = fn _ => raise Fail "TODO"

    val deMorgan1 = fn _ => raise Fail "TODO"

    val deMorgan2 = fn _ => raise Fail "TODO"

    val dne = fn _ => raise Fail "TODO"

    val noFun = fn _ => raise Fail "TODO"
  end
