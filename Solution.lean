module

public import Mathlib.Data.Nat.Prime.Basic
public import Mathlib.Algebra.Group.Even
public import Mathlib.Tactic.NormNum
public import Mathlib.Tactic.NormNum.Prime
public import Mathlib.Tactic.Linarith

public section

/-!
# Erdős 365: the first question is false

An independent proof of Golomb's known counterexample, not a solution of
the open counting question. See AUDIT.md for the fixed source contract.
-/

namespace Erdos365

/-- Positive and divisible by the square of each of its prime divisors. -/
@[expose] def Powerful (n : ℕ) : Prop :=
  0 < n ∧ ∀ p : ℕ, p.Prime → p ∣ n → p ^ 2 ∣ n

/-- The first yes/no question, expressed in the source's square formulation. -/
@[expose] def SquareQuestion : Prop :=
  ∀ n : ℕ, Powerful n → Powerful (n + 1) →
    IsSquare n ∨ IsSquare (n + 1)

/-- Golomb's explicit consecutive powerful pair, with neither member square. -/
theorem golomb_pair :
    Powerful 12167 ∧ Powerful 12168 ∧
      ¬ IsSquare (12167 : ℕ) ∧ ¬ IsSquare (12168 : ℕ) := by
  have hA : Powerful 12167 := by
    refine ⟨by norm_num, ?_⟩
    intro p hp hd
    have hpow : p ∣ (23 : ℕ) ^ 3 := by norm_num at hd ⊢; exact hd
    have heq : p = 23 := Nat.prime_eq_prime_of_dvd_pow hp (by norm_num) hpow
    subst p
    norm_num
  have hB : Powerful 12168 := by
    refine ⟨by norm_num, ?_⟩
    intro p hp hd
    have hprod : p ∣ (2 : ℕ) ^ 3 * 3 ^ 2 * 13 ^ 2 := by
      norm_num at hd ⊢; exact hd
    rcases hp.dvd_mul.mp hprod with hab | hc
    · rcases hp.dvd_mul.mp hab with ha | hb
      · have heq : p = 2 := Nat.prime_eq_prime_of_dvd_pow hp (by norm_num) ha
        subst p
        norm_num
      · have heq : p = 3 := Nat.prime_eq_prime_of_dvd_pow hp (by norm_num) hb
        subst p
        norm_num
    · have heq : p = 13 := Nat.prime_eq_prime_of_dvd_pow hp (by norm_num) hc
      subst p
      norm_num
  have hns : ∀ n : ℕ, 12100 < n → n < 12321 → ¬ IsSquare n := by
    intro n hlo hhi ⟨r, hr⟩
    have hrlo : 110 < r := by nlinarith
    have hrhi : r < 111 := by nlinarith
    omega
  exact ⟨hA, hB, hns _ (by norm_num) (by norm_num),
    hns _ (by norm_num) (by norm_num)⟩

/-- Direct negative answer to the first question of Erdős Problem 365. -/
theorem square_question_false : ¬ SquareQuestion := by
  intro h
  rcases golomb_pair with ⟨hA, hB, hnA, hnB⟩
  rcases h 12167 hA hB with hs | hs
  · exact hnA hs
  · exact hnB hs

end Erdos365
