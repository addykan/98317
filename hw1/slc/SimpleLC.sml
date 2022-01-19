structure SimpleLC =
struct
  datatype typ =
    UnitTy
  | Bool
  | Arrow of typ * typ
  | Times of typ * typ

  datatype exp =
    Variable of string
  | Lambda of (string * typ) * exp
  | Apply of exp * exp
  | Tuple of exp * exp
  | First of exp
  | Second of exp
  | Unit
  | True
  | False
  | IfThenElse of exp * exp * exp

  infix 6 ^^
  fun s1 ^^ s2 = s1 ^ " " ^ s2

  fun parens_if b s = if b then "(" ^ s ^ ")" else s

  fun pp_typ level = (fn
      UnitTy => "unit"
    | Bool => "bool"
    | Arrow (t1, t2) => parens_if (level>11) (pp_typ 12 t1 ^^ "->" ^^ pp_typ 11 t2)
    | Times (t1, t2) => parens_if (level>13) (pp_typ 13 t1 ^^ "*" ^^ pp_typ 14 t2)
  )

  val pp_typ = pp_typ 10

  val rec pp_exp = (fn
      Variable x => x
    | Lambda ((x, t), e) => "fn (" ^ x ^^ ":" ^^ pp_typ t ^ ") =>" ^^ pp_exp e
    | Apply (e1, e2) => "(" ^ pp_exp e1 ^^ pp_exp e2 ^ ")"
    | Tuple (e1, e2) => "(" ^ pp_exp e1 ^ "," ^^ pp_exp e2 ^ ")"
    | First e => "fst(" ^ pp_exp e ^ ")"
    | Second e => "snd(" ^ pp_exp e ^ ")"
    | Unit => "()"
    | True => "true"
    | False => "false"
    | IfThenElse (b,e1,e2) => "if" ^^ pp_exp b ^^ "then" ^^ pp_exp e1 ^^ "else" ^^ pp_exp e2
  )
end
