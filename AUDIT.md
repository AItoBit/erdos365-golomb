# Erdős Problem 365 — source audit and fidelity contract

Audit date: 6 October 2026. Language: English.

## Scope and mathematical status

The supplied `365.pdf` was read in full, including both image-only pages. It is a print of the Erdős Problems discussion thread. Page 1 contains the problem and editorial notes; page 2 contains three forum contributions (one is a reply). The page itself warns that comments are not verified.

The source contains two separate questions:

1. For every positive integer n, if n and n+1 are powerful, is at least one a square? **False**, with the counterexample n = 12167, attributed by the supplied source to S. W. Golomb (1970). This project proves its negation and checks the explicit counterexample.
2. If A(x) counts the positive integers n ≤ x for which both n and n+1 are powerful, do there exist fixed constants C > 0, k ≥ 0 and x₀ such that A(x) ≤ C(log x)^k for all x ≥ x₀? **Open according to the supplied source.** This project supplies only a proposition expressing the question. It supplies no proof of it and no claim that an open question was solved. The current live Erdős Problems page returned HTTP 403, so the live status could not be independently reconfirmed.

“Powerful” means positive and p² divides the number whenever the prime p divides it. One is powerful vacuously. Zero is excluded.

The project does not formalize Walker's infinitude theorem, the complete Pell classifications, Aktaş–Murty's analytic or conditional theorems, or Reuss's upper bound. These remain literature background, not hidden hypotheses in a proved theorem. No result is claimed to be mathematically new, or the first formalization.

## Precise fixed statements

Let P(n) mean n > 0 and ∀ prime p, p ∣ n implies p² ∣ n. Let S(n) mean ∃ r ∈ ℕ, n = r².

The first question is Q := ∀ n ∈ ℕ, P(n) → P(n+1) → (S(n) ∨ S(n+1)). The main theorem is ¬Q. The explicit witness theorem states P(12167) ∧ P(12168) ∧ ¬S(12167) ∧ ¬S(12168). Since 12168 = 12167+1, this is an answer to the actual universal question, not merely an auxiliary lemma.

For real x, A(x) := #{n ∈ ℕ : 1 ≤ n ≤ floor(x), P(n) ∧ P(n+1)}. The counting question is ∃ k ∈ ℕ, ∃ C ∈ ℝ, C > 0 ∧ ∃ x₀ ∈ ℝ, x₀ ≥ 2 ∧ ∀ x ∈ ℝ, x ≥ x₀ → A(x) ≤ C(log x)^k. It counts all consecutive powerful pairs, including pairs containing a square, and places the upper endpoint on n, not n+1.

## Clause-by-clause Lean contract

| Informal clause | Exact Lean expression | Reason for correspondence | Convention or qualification |
| --- | --- | --- | --- |
| A positive integer | `n : ℕ`, `0 < n` | Natural numbers with a positivity condition represent positive integers. | Zero is excluded; one is allowed. |
| A prime divisor | `p : ℕ`, `p.Prime`, `p ∣ n` | Mathlib's ordinary natural prime and divisibility predicates. | p=0 and p=1 cannot satisfy primality. |
| Prime exponent at least two | `p ^ 2 ∣ n` | Divisibility by p² is the source definition itself. | No unproved equivalence with a square-times-cube representation is used. |
| A square | `IsSquare n` | Mathlib defines it by `∃ r, n = r * r`. | Here both n and r are natural numbers. The proof does not use real squares, which would make every nonnegative number a square. |
| Consecutive | `n + 1` | Successor is exactly one larger. | No truncated natural subtraction. |
| For every qualifying pair | `∀ n : ℕ, Powerful n → Powerful (n + 1) → IsSquare n ∨ IsSquare (n + 1)` | Universal n, with exactly the two powerful hypotheses and the source conclusion. | Defined as `SquareQuestion`; the proved result is its negation. |
| Negative answer | `¬ SquareQuestion` | A single verified counterexample refutes a universal assertion. | No extra assumptions; no conditional solution. |
| Specific witness | `Powerful 12167 ∧ Powerful 12168 ∧ ¬ IsSquare (12167 : ℕ) ∧ ¬ IsSquare (12168 : ℕ)` | Checks both numbers and both failures of squarehood. | Their difference is one by numeral arithmetic. |
| Lower member n ≤ real x | `Finset.Icc 1 ⌊x⌋₊` | For nonnegative x, n ≤ the natural floor iff `(n : ℝ) ≤ x`. See `Nat.le_floor_iff`. | For negative x the interval is empty, correctly counting no positive integers. |
| Both numbers powerful | `.filter (fun n => Powerful n ∧ Powerful (n + 1))` | Applies the source predicate to both members. | n+1 need not be ≤x. |
| Count each pair once | `(pairsUpTo x).card` | A finite set counts distinct lower members. | No ordered-pair double counting or infinite cardinal. |
| Polylogarithmic bound | `∃ k : ℕ, ∃ C : ℝ, 0 < C ∧ ∃ x₀ : ℝ, 2 ≤ x₀ ∧ ∀ x : ℝ, x₀ ≤ x → (pairCount x : ℝ) ≤ C * (Real.log x) ^ k` | All constants precede the universal x and are uniform; the conclusion is eventual. | Natural exponent convention; proposition only. There is no equality, limit assertion, or computed asymptotic estimate. |

No infinite series, `tsum`, division, convergence, limsup, or liminf appears. There is no distinction of repeated sequence terms to resolve: distinct n are counted by a finite set.

## Interpretative decisions and equivalences

**Pell wording.** The source introduces its first question using Pell equations and then explicitly restates it as squarehood. This project fixes the latter statement. It does not assert an equivalence with an independently defined predicate “comes from a Pell equation.” Classical Pell forms x²−Dy²=±1 have a square member; generalized forms mX²−nY²=±1 can have neither member square. Walker treats both types. Thus an unrestricted use of “Pell equation” would be ambiguous. No theorem equating the broad and narrow readings is claimed.

**Exponent convention.** Restricting a polylogarithmic upper-bound exponent to a natural number does not change the ordinary mathematical existence question. Given any fixed real exponent a, choose k∈ℕ with k≥max(a,0), increase x₀ until x₀≥e, and then log x≥1, so (log x)^a≤(log x)^k. Conversely, a natural exponent is a real exponent. A base change multiplies the power by a fixed positive constant that can be absorbed into C. These are informal mathematical arguments, not Lean theorems in this project. The equivalence to a separately encoded real-power statement remains unformalized; no such equivalence is advertised as verified.

**Frozen target.** The square question and its negation were fixed before proof construction. No stronger hypothesis or weaker conclusion was introduced during compilation repairs. Only import dependencies were repaired. The open bound has no alleged proof.

## Mathematical proof and exact library support

1. `12167 = 23^3`. A prime dividing this number divides 23, hence equals 23; its square divides 12167.
2. `12168 = 2^3 * 3^2 * 13^2`. A prime divisor must divide one factor, hence equals 2, 3, or 13; its square divides 12168.
3. `110^2 = 12100` and `111^2 = 12321`. Both numbers lie strictly between these successive squares. If n=r*r were between them, nonlinear arithmetic would force 110<r<111, impossible for natural r.
4. Applying the universal square question to 12167 would contradict one of these two nonsquare facts.

Inspected library declarations: `Nat.Prime.dvd_mul`, `Nat.Prime.dvd_of_dvd_pow`, and `Nat.prime_eq_prime_of_dvd_pow` in `Mathlib/Data/Nat/Prime/Basic.lean`; `IsSquare` in `Mathlib/Algebra/Group/Even.lean`; and `Nat.le_floor_iff` in `Mathlib/Algebra/Order/Floor/Defs.lean`. Tactics `norm_num` (including `NormNum.Prime`), `nlinarith`, and `omega` construct ordinary kernel-checked proofs. No native evaluation bypass is used.

## Source and forum audit

- **Supplied PDF, p.1:** main question, known Golomb witness, editorial attribution to Walker, OEIS reference A060355, cross-reference to problem 364, and Guy B16 reference. The numerical witness is independently proved here. The inaccessible Golomb original was not read in full; attribution and publication details are supported by the supplied source, JSTOR's indexed excerpt, and Walker's bibliography. This access limitation is recorded rather than represented as a full primary-source check.
- **Walker (1976), pp.111–116:** the entire six-page primary paper was retrieved and read. It defines positive powerful numbers, distinguishes square-containing Type I from nonsquare Type II, and develops both families. Its final example and odd powers support infinitude of Type II. This project does not reuse its proof code or claim to formalize those theorems.
- **Tao comment, supplied PDF p.2:** reports an elementary O(x^(2/5)) bound by Aktaş–Murty and tentatively suggests it is the best known. The “best known” part is not accepted: Reuss, arXiv:1212.3150v2, Theorem 4, states A(x)≪ε x^(29/100+ε) for every ε>0 and all sufficiently large x. For example ε=1/100 gives exponent 3/10<2/5. The theorem statement and surrounding definitions were checked in the primary paper; its complete 28-page proof was not audited or formalized here. No absolute best-current-bound claim is made.
- **Aktaş–Murty (2017):** the indexed author-hosted paper identifies the title, authors, DOI, and bounds; the current direct URL redirects to a profile, so the full primary text was not obtained. Its bound is background only, not an assumption or formalized result. The retrieved text also references sharper bounds, reinforcing why the forum's best-bound suggestion requires qualification.
- **Alfaiz comment, p.2:** discusses consecutive odd powerful numbers, such as 25 and 27, and a separate question about differences of powerful numbers. Those integers differ by two, not one. No conclusion about the present first question is inferred.
- **StijnC reply, p.2:** explicitly points out the difference-two versus difference-one distinction. This is an explanatory comment, not a proof imported into the development.
- **Mahler's observation, p.1:** infinitude of square-containing pairs via x²=8y²+1 is historical background. It is not claimed to be formalized.

## Provenance and licensing

The mathematical counterexample is attributed to S. W. Golomb, *Powerful Numbers*, American Mathematical Monthly 77(8) (1970), pp.848–852, DOI 10.2307/2317020 (also indexed as 10.1080/00029890.1970.11992598). Attribution is distinct from a claim of complete source access.

An earlier formalization was found: `golfyx/jsp-000301-lean`, exact commit `ead5a5c54079c7b78acb57a6d83f158aa28daea2`, author @golfyx, Apache-2.0, https://github.com/golfyx/jsp-000301-lean/tree/ead5a5c54079c7b78acb57a6d83f158aa28daea2. Its README was inspected, not its Lean proof. No code from that formalization is copied, adapted, imported, or used as a dependency. Its README acknowledges other earlier formalizations; those were not exhaustively located. No priority claim is made.

This project's Lean code was independently written with OpenAI Codex assistance for Alexander / AItoBit. Human expert mathematical review has not occurred. Naming the user as author/maintainer follows the choice explicitly supplied in this session; it is not a claim that they personally wrote or reviewed every proof step.

Mathlib is a reused proof library, Apache-2.0, exact commit `25730c7c759d108ef87ab70af2342a196760f79d`: https://github.com/leanprover-community/mathlib4/tree/25730c7c759d108ef87ab70af2342a196760f79d. The project pins Lean v4.35.0-rc3, matching that Mathlib checkout. This is an exact compatible snapshot, not a claim that it is the newest Mathlib commit on the audit date.

The repository is Apache-2.0. Configuration scripts and licence material originate from the Palomar starter template; see PROVENANCE.md for its exact snapshot. No mathematical proof from that template is reused. External papers retain their own copyrights and are not redistributed in this package.

## Verification and submission boundary

All four modules compile. The two main theorem axiom reports list only `propext`, `Classical.choice`, `Quot.sound`. There are no proof holes, custom axioms, unsafe project declarations, or `native_decide` in the Lean source. Even Challenge has complete proofs to honor the request banning proof holes.

See VERIFICATION.md for the independent checker results and the environment limitations. A normal isolated Comparator run and Palomar's complete `mode: full` workflow still need to pass on the public immutable snapshot. This package has not been submitted or registered. Neither compilation nor a correctly formed package implies editorial acceptance: Palomar separately evaluates research interest and duplication/provenance.
