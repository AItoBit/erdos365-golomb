# Exact provenance

- Project proof code: independently authored in this session with OpenAI Codex assistance for Alexander (AItoBit). No earlier third-party Lean proof copied or imported.
- Mathematical witness: S. W. Golomb (1970), DOI 10.2307/2317020. Full original unavailable; exact witness independently checked and source-access limitation recorded.
- Related earlier formalization: golfyx, Apache-2.0, https://github.com/golfyx/jsp-000301-lean/tree/ead5a5c54079c7b78acb57a6d83f158aa28daea2. README read; Lean proof not inspected or reused.
- Mathlib library: community authors, Apache-2.0, https://github.com/leanprover-community/mathlib4/tree/25730c7c759d108ef87ab70af2342a196760f79d. Reuses prime divisibility, square definitions, finite sets, logarithms, floors, and tactics.
- Lean compiler: Lean contributors, Apache-2.0, https://github.com/leanprover/lean4/tree/470d5ce1400764999581fd26d5d72b00d990b0f4, release v4.35.0-rc3.
- Palomar starter material: PalomarRegistry/PalomarTemplate, Apache-2.0, https://github.com/PalomarRegistry/PalomarTemplate/tree/2891de4c48955af824969a263d31b25e7a9a1406. Reuses `LICENSE`, `scripts/verify-comparator.sh`, and `scripts/validate-formalization.rb` unchanged. Lake, metadata, and CI structure are adapted and filled for this project; no starter mathematical proof is reused.
- Full-preflight workflow: https://github.com/PalomarRegistry/PalomarSubmission/tree/d4e41c1d5b0d114c4859e6e5831dc6d3ad1d0d44. The delivered workflow delegates to this exact revision, with the same `pipeline_commit` and `mode: full`.

All transitive proof-library pins are in `lake-manifest.json`. External paper content is not redistributed. No author endorsement or human expert review is asserted.
