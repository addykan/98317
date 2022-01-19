structure Top =
struct
  structure SLC = SimpleLC

  fun println s = print (s ^ "\n")

  val parse_and_print = println o SLC.pp_exp o Parser.parse

  val check = println o SLC.pp_typ o SimpleLC_Checker.check o Parser.parse
end
