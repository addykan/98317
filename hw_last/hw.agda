{-
  Welcome to the final Hype for Types homework!
  You're going to be writing some code (aka proofs) in Agda, a programming language with dependent types.
  Like we saw in lecture, Agda isn't just a programming langauge, it's also an interactive development tool.
  If you click on the `Agda` dropdown menu at the top of the editor, you'll see a list of commands, along with
  keyboard shortcuts that correspond to them. It's a lot quicker to use the keyboard shortcuts, but you can do
  whatever you're comfortable with. Only the first two commands here are necessary to complete the homework,
  but the rest can be very helpful.
  YOU CAN'T DO THE HOMEWORK WITHOUT THESE:
  C-c C-l       typecheck the whole file
  C-c C-SPACE   when the cursor is inside a hole:  will check if an expression you've written in the hole has the right type, and fill it in if it does
  THESE ARE NICE AND RECOMMENDED:
  C-c C-c       pattern match on a variable. Will present you with a little window asking for which variables to case one
  C-c C-COMMA   when the cursor is inside a hole: displays the goal type (the type you need to produce a member of) and the types of all in-scope variables
  C-c C-r       works like C-c C-SPACE, but you can give an incomplete expression, and Agda will check if it could work, and put new holes in your incomplete expression
  C-c C-a       asks Agda to try guessing, you'd be surprised how often this works
  "C-c C-l" means "Hit the control key and the "c" key at the same time, then hit the control key and the "l" key at the same time".
  You can just hold the control key and then hit "c" and "l" in sequence. Or you can use the dropdown menu.
-}


{- The nats. ℕ is written \bN, and → is written \to. You can also use -> if you prefer -}
data ℕ : Set where
  zero : ℕ
  succ : ℕ → ℕ
{-# BUILTIN NATURAL ℕ #-}
{- This commands lets you write decimal numbers like 32 or 6 instead of using succ a bunch of times -}

pred : ℕ → ℕ
pred zero     = zero
pred (succ k) = k

{- ≤ is written \le -}
data _≤_ : ℕ → ℕ → Set where
  zero≤ : {x : ℕ} → 0 ≤ x -- Remember that curly brackets mean you don't need to provide this argument when using the constructor. It's just zero≤, not zero≤ 4
  succ≤ : {x y : ℕ} → x ≤ y → succ x ≤ succ y

{- Prove that 3 ≤ 7
   That green area in brackets is a hole. You can make a new one by typing a question mark and loading the file.
   If you put your cursor in there and hit C-c C-COMMA you'll be presented
   with a goal: the type you want to produce, and a context: the variables you have and their types. Once you've
   written an answer into the hole, hit C-c C-SPACE to try filling it in. Writing out all the constructors for this
   task is pretty annoying, try using C-c C-a to ask Agda to write the term for you!
-}

3≤7 : 3 ≤ 7
3≤7 = {!!}

{- Prove that for all x, x is less than or equal to its successor. You'll probably want to use C-c C-c to pattern match on x -}
succ-≤ : (x : ℕ) → x ≤ succ x
succ-≤ = {!!}

{- Prove that for all x, the predesessor of x is less than or equal to x. The previous proof might prove useful here -}
pred-≤ : (x : ℕ) → pred x ≤ x
pred-≤ = {!!}

{- Prove that ≤ is transitive!
   Remember that the curly braces around x,y,z mean they're implicit arguments. you can essentially pretend they don't exist.
   This functions takes TWO arguments, not five.
-}
≤-trans : {x y z : ℕ} → x ≤ y → y ≤ z → x ≤ z
≤-trans = {!!}

{- END OF REQUIRED PROBELMS -}

{- THE REST OF THIS IS BONUS, ONLY DO IT IF YOU WANT TO -}

infixl 5 _+_
_+_ : ℕ → ℕ → ℕ
zero + y = y
succ x + y = succ (x + y)

{- Here are two cool ways to double a number -}

double1 : ℕ → ℕ
double1 x = x + x

double2 : ℕ → ℕ
double2 zero = zero
double2 (succ x) = succ (succ (double2 x))

{- Recall the equality type from lecture -}

{- ≡ is written \== -}
infix 1 _≡_
data _≡_ {A : Set} : A → A → Set where
  refl : {x : A} → x ≡ x

{- Prove equality is a congruence. Remember that implicit arguments means this function only really takes TWO arguments, not six. -}
cong : {A B : Set} → {x y : A} → (f : A → B) → x ≡ y → f x ≡ f y
cong = {!!}

{- Prove equality is transitive -}
trans : {A : Set} → {x y z : A} → x ≡ y → y ≡ z → x ≡ z
trans = {!!}

{- This will be a useful lemma -}
+-succ : (x y : ℕ) → x + succ y ≡ succ (x + y)
+-succ = {!!}

{- Prove that our two implementations of double are actually equivalent. This is pretty hard. You'll need cong, trans and +-succ -}
double-equiv : (x : ℕ) → double1 x ≡ double2 x
double-equiv = {!!}
