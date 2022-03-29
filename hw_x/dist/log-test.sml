infix 1 >>=
infixr 1 >=>

open LogMonad


datatype tree = Empty | Node of tree * int * tree

fun treeSum (t : tree) : int t =
  case t of
    Empty          => return 0
  | Node (l, x, r) =>
      treeSum l >>= (fn suml =>
        treeSum r >>= (fn sumr =>
          (Int.toString x ^ ", ", suml + x + sumr)
        )
      )

fun leaf x = Node (Empty, x, Empty)

val demoTree =
  Node (
    Node (
      leaf 1,
      2,
      leaf 3
    ),
    4,
    leaf 5
  )

(* EXPECT: ("1, 3, 2, 5, 4, ", 15) *)
val returnBindTest = treeSum demoTree

val finish = fn i => ("fin.", Int.toString i)

(* EXPECT: ("1, 3, 2, 5, 4, fin.", "15") *)
val fishTest = (treeSum >=> finish) demoTree

val hype = ("hype", 21)

(* EXPECT: ("hype", (" for types", 42)) *)
val testMap = map (fn n => (" for types", 2 * n)) hype

(* EXPECT: ("hype for types", 42) *)
val testJoin = join testMap
