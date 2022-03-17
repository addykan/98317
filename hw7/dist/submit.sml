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

    val sum = fn _ => raise Fail "TODO"

    val any = fn _ => raise Fail "TODO"

    val nth = fn _ => raise Fail "TODO"

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
