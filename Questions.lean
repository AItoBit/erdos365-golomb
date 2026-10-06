module

public import Solution
public import Mathlib.Data.Finset.Interval
public import Mathlib.Analysis.SpecialFunctions.Log.Basic
public import Mathlib.Algebra.Order.Floor.Ring

public section

namespace Erdos365

/-- Positive lower members of consecutive powerful pairs, up to a real bound.
The endpoint condition is on n, not on n + 1. -/
@[expose] noncomputable def pairsUpTo (x : ℝ) : Finset ℕ := by
  classical
  exact (Finset.Icc 1 ⌊x⌋₊).filter (fun n => Powerful n ∧ Powerful (n + 1))

/-- Each pair is counted once by its lower member. -/
@[expose] noncomputable def pairCount (x : ℝ) : ℕ := (pairsUpTo x).card

/-- The second question of Erdős 365. This is a proposition, not a proved theorem.
There are fixed constants and a fixed exponent, uniform in every large real x.
A natural exponent is a chosen formulation of the polylogarithmic upper bound;
no equivalence with alternative exponent conventions is asserted here. -/
@[expose] def PolylogarithmicCountingQuestion : Prop :=
  ∃ k : ℕ, ∃ C : ℝ, 0 < C ∧ ∃ x₀ : ℝ, 2 ≤ x₀ ∧
    ∀ x : ℝ, x₀ ≤ x → (pairCount x : ℝ) ≤ C * (Real.log x) ^ k

end Erdos365
