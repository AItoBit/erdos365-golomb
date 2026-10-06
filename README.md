# Erdős 365: Golomb's consecutive powerful nonsquares

This Lean 4 project proves the known negative answer to the **first** question of Erdős Problem 365: consecutive powerful numbers need not contain a square.

The counterexample, attributed to S. W. Golomb (1970), is

- 12167 = 23³;
- 12168 = 2³ · 3² · 13².

Both numbers are powerful. Both lie strictly between 110² and 111², so neither is a square. The source's separate polylogarithmic counting question remains unproved here.

This is a source-based independent formalization, not a new mathematical result or a claim of first formalization. Earlier work is identified at an immutable commit in [AUDIT.md](AUDIT.md).

## Files and advertised results

| File | Purpose |
| --- | --- |
| `Challenge.lean` | Small independent auditable surface, with complete proofs to avoid all proof holes. |
| `Solution.lean` | Proved `Erdos365.golomb_pair` and `Erdos365.square_question_false`. |
| `Questions.lean` | Exact finite counting definition and the unproved open question as a `Prop`. |
| `Audit.lean` | Main theorem axiom reports. |
| `AUDIT.md` | Full source audit, mathematical argument, fidelity table, and limitations. |
| `formalization.yaml` | English provenance, authorship, scope, automation, and review disclosures. |
| `VERIFICATION.md` | Local evidence and outstanding Palomar preflight. |
| `SUBMISSION.md` | Public repository, preflight, and submission steps. |

The Comparator configuration records only the two proved results. `definition_names` is empty: neither predicate is an unspecified definition hole, and their bodies must match through the theorem dependencies.

## Reproduce

Install the pinned Lean toolchain with elan, then run:

```sh
lake exe cache get
lake build
lake env lean Audit.lean
./scripts/verify-comparator.sh
```

Lean: `leanprover/lean4:v4.35.0-rc3`.
Mathlib: `25730c7c759d108ef87ab70af2342a196760f79d`.
The committed manifest pins the transitive dependencies.

There are no `sorry`, `admit`, added axioms, unsafe declarations, or `native_decide` in the project Lean code. The main theorem dependencies are exactly the permitted foundational axioms `propext`, `Classical.choice`, and `Quot.sound`.

## Palomar status

Prepared for the Palomar repository layout; **not submitted, not registered, and not fully preflighted by Palomar**. The local ordinary build and independent proof checks passed. Normal Comparator isolation is unavailable in the authoring environment, so the public CI and full Palomar workflow must pass before intake. See [VERIFICATION.md](VERIFICATION.md).

Editorial acceptance is separate from formal correctness. This is a small known counterexample with earlier formalizations; useful source provenance is supplied, but the project does not promise that Palomar will consider this alone a sufficient research contribution.

Human submission form: https://submit.palomar-registry.org/.
Agent protocol: https://submit.palomar-registry.org/llms.txt.
Do not register until the review has been read and publication explicitly authorized.

## Licence and authorship

Apache-2.0. Prepared for Alexander (AItoBit), with OpenAI Codex assistance. No human expert review is claimed. See [PROVENANCE.md](PROVENANCE.md).
