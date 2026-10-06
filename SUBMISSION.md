# Palomar submission handoff

## Submission description

**Title:** Erdős 365: Golomb's consecutive powerful nonsquares

**Abstract:** This source-based independent Lean 4 formalization proves that consecutive powerful positive integers need not include a square. It verifies Golomb's classical counterexample 12167 = 23³ and 12168 = 2³·3²·13², then refutes the universal square question. The separate open question asking for a polylogarithmic bound on the number of consecutive powerful pairs is defined as a proposition only. No mathematical novelty or first-formalization priority is claimed.

**Author and responsible maintainer:** Alexander (AItoBit), as selected in the preparation session. AI assistance and lack of human expert review are disclosed in the metadata.

**Proposed new public repository name:** `AItoBit/erdos365-golomb`. This name is a proposal; no such repository was created during preparation.

**Project directory:** repository root.

**Comparator configuration:** `comparator.json`.

**Formalization metadata:** `formalization.yaml`.

**Recorded theorems:** `Erdos365.golomb_pair`, `Erdos365.square_question_false`.

## Publish and preflight

1. Create a public GitHub repository under the maintainer's account and upload the complete extracted folder contents, including `.github`, the licence, and the committed manifest. Exclude `.lake` and generated binary/cache files.
2. Commit and push every included file; obtain the **full 40-character** final commit SHA with `git rev-parse HEAD`. No public SHA is available from this preparation session.
3. Let `Lean and Comparator` CI pass. It builds the modules, audits axioms, validates metadata, and runs the normal isolated Comparator with Lean, NanoDa, and con-ron.
4. In GitHub Actions, manually run **Palomar full mechanical preflight** at the same final commit. The delivered workflow pins PalomarSubmission's reusable workflow and `pipeline_commit` to `d4e41c1d5b0d114c4859e6e5831dc6d3ad1d0d44`, uses `mode: full`, and selects `palomar-standard-v1`.
5. Inspect the mechanical report and require `status: pass`. A local build or the repository-specific CI alone does not satisfy the documented agent full-preflight requirement.

## Intake and permanent registration

Humans use https://submit.palomar-registry.org/. Agents read https://submit.palomar-registry.org/llms.txt and use its HTTPS protocol; they must not automate the sign-in form.

Before agent intake, confirm the actual public repository, full pushed commit, `comparator.json`, and the user's relationship to the substantive formalization (normally `maintainer`). The service's protocol explicitly requires agreement on these concrete fields. The proposed repository name is not an actual repository/commit pair, so intake was not attempted.

After verification and editorial review, show the user the review and what permanent registration publishes. Obtain an explicit instruction to register before the final registration request. A package, proof check, or request to prepare a formalization does not establish editorial acceptance.

The first question is classically settled and earlier formalizations exist. Palomar separately requires plausible research interest and useful provenance. This package reports the small scope honestly and cannot promise that it qualifies on its own.
