# Verification evidence

Date: 6 October 2026.

| Check | Outcome |
| --- | --- |
| `lake build` | PASS: Challenge, Solution, Questions, Audit; 2004 jobs completed. |
| Main theorem axiom audit | PASS: both list only `propext`, `Classical.choice`, `Quot.sound`. |
| formalization.yaml v0.4 JSON Schema | PASS against the upstream schema retrieved on the audit date. |
| Compiler proof holes | None in any project Lean source. |
| Lean export checker | PASS on Solution's theorem dependency export. |
| NanoDa | PASS on the same export. |
| con-ron | PASS: accepted 3827 declarations (`--verified`). |
| Comparator statement/dependency comparison | PASS on Challenge and Solution exports. |
| Normal isolated Comparator execution | BLOCKED: environment cannot create/read required process namespaces. |
| Palomar full reusable workflow | NOT RUN: requires a public GitHub snapshot and Actions execution. |
| Palomar editorial review / registration | NOT REQUESTED. |

Compiler: Lean v4.35.0-rc3, upstream commit `470d5ce1400764999581fd26d5d72b00d990b0f4`.
Mathlib: `25730c7c759d108ef87ab70af2342a196760f79d`.

The runtime could not resolve the application path via `/proc/<pid>/exe`. A local compatibility shim supplied that path for compiler/Lake startup. It did not alter Lean declarations, proof terms, reductions, or the kernel. The shim is not part of the deliverable and is unnecessary on ordinary Linux installations.

Export generation used the pinned toolchain's `leanexport`, with the advertised theorems, the permitted foundational axioms, and Comparator's own primitive and quotient target lists. The exports came from the compiled project modules. Direct `leanchecker`, `nanoda_bin`, and `con-ron` checks all succeeded.

A default isolated Comparator run over these exports reached the Lean checker but failed because `bwrap` could not access the necessary namespace. A diagnostic comparison of these already-generated local exports used Comparator's `--inadvisably-no-sandbox` switch and accepted the statement/dependency match and all three checkers. Comparator explicitly warns that this execution lacks its normal isolation guarantees. It is **not** represented as a trusted isolated run or Palomar full preflight. The delivered CI uses the standard isolated script, not that diagnostic switch.

Re-run `./scripts/verify-comparator.sh` on an environment that supports bubblewrap, then run Palomar's pinned complete reusable workflow in `mode: full`. Only a mechanical report with `status: pass` satisfies the documented agent intake preflight.
