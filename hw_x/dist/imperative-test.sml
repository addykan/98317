infix 1 >>=
infixr 1 >=>

type state = { counter : int, output : string }
structure M = ImperativeMonad (type state = state)
open M


val getState : state M.t         = fn state => {state = state, value = state}
val setState : state -> unit M.t = fn state => (fn _ => { state = state, value = () })

val getCounter : int M.t    = getState >>= (fn { counter, ... } => return counter)
val getOutput  : string M.t = getState >>= (fn { output, ... }  => return output )

fun setCounter (counter : int ) : unit M.t =
  getOutput >>= (fn output => setState { counter = counter, output = output })
fun setOutput (output : string) : unit M.t =
  getCounter >>= (fn counter => setState { counter = counter, output = output })

(*
  int counter = 0;
  string output = "";

  string fizz() {
    output = output ^ (counter % 3 == 0) ? "Fizz" : Int.toString x;

    if (counter < 10) {
      counter = counter + 1;
      return fizz();
    } else
      return output;
  }
*)

fun fizz () : string M.t =
  getState
  >>= (fn { counter, output } =>
    (raise Fail "TODO")
    >>= (fn () =>
      if counter < 10
        then getCounter >>= (fn counter => setCounter (counter + 1) >>= fizz)
        else getOutput
    )
  )

(* val result = fizz () { counter = 0, output = "" } *)
