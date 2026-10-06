"""Read-only source and metadata checks for this fixed project."""
from pathlib import Path
import json
import re

root = Path(__file__).resolve().parent.parent
sources = [p for p in root.rglob('*.lean') if '.lake' not in p.parts and '.git' not in p.parts]
for path in sources:
    assert not path.is_symlink(), f'Source symlink: {path}'
    text = path.read_text()
    assert text.splitlines()[0] == 'module', f'Missing module header: {path}'
    assert len(text.splitlines()) <= 10000, f'Line cap: {path}'
    assert not re.search(r'\b(sorry|admit|axiom|unsafe|native_decide)\b', text), f'Forbidden shortcut: {path}'
challenge = root / 'Challenge.lean'
assert challenge.stat().st_size <= 102400
assert len(challenge.read_text().splitlines()) <= 1000
cfg = json.loads((root / 'comparator.json').read_text())
assert cfg['definition_names'] == []
assert cfg['theorem_names'] == ['Erdos365.golomb_pair', 'Erdos365.square_question_false']
assert cfg['permitted_axioms'] == ['propext', 'Quot.sound', 'Classical.choice']
assert not re.search(r'TEMPLATE:', (root / 'formalization.yaml').read_text())
assert (root / 'LICENSE').is_file()
assert (root / 'lake-manifest.json').is_file()
assert sum((root / x).exists() for x in ['lakefile.toml', 'lakefile.lean']) == 1
print(f'Project checks passed: {len(sources)} Lean modules; fixed two-theorem configuration.')
