#!/usr/bin/env python3
"""Add Colab badges to Jupyter notebooks."""

import json
import subprocess
import uuid
from pathlib import Path


def git(*args):
    return subprocess.check_output(['git'] + list(args)).decode().strip()


def confirm(msg):
    while True:
        r = input(f"{msg} [y/n/a/q]: ").lower()
        if r in 'ynaq': return r


def main():
    # Get repo info
    root = Path(git('rev-parse', '--show-toplevel'))
    remote = git('config', '--get', 'remote.origin.url')
    branch = git('rev-parse', '--abbrev-ref', 'HEAD')

    # Parse user/repo
    path = remote.split('github.com')[-1].lstrip(':/').rstrip('/')
    if path.endswith('.git'):
        path = path[:-4]
    user, repo = path.split('/')

    print(f"{user}/{repo} [{branch}]\n")

    # Find notebooks
    notebooks = [n for n in root.rglob('*.ipynb') if '.ipynb_checkpoints' not in str(n)]

    if not notebooks:
        print("No notebooks found")
        return

    print(f"Found {len(notebooks)} notebooks\n")

    # Process
    auto = False
    done = 0

    for i, nb in enumerate(notebooks, 1):
        rel = nb.relative_to(root)
        print(f"[{i}/{len(notebooks)}] {rel}")

        # Show status
        if subprocess.run(['git', 'check-ignore', '-q', str(nb)]).returncode == 0:
            print("  Skipped: gitignored, so a Colab badge would 404\n")
            continue

        has = 'colab-badge' in nb.read_text(encoding='utf-8')
        print(f"  Badge: {'exists' if has else 'missing'}")

        # Confirm
        if not auto:
            c = confirm("Process?")
            if c == 'q': break
            if c == 'a': auto = True
            if c == 'n':
                print()
                continue

        # Add badge
        data = json.loads(nb.read_text(encoding='utf-8'))
        url = f"https://colab.research.google.com/github/{user}/{repo}/blob/{branch}/{rel}"
        source = [f"[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)]({url})\n"]

        cells = data.get('cells', [])
        replacing = bool(cells) and 'colab-badge' in str(cells[0])

        if data.get('nbformat_minor', 0) >= 5:
            # nbformat 4.5 wants an id on every cell; keep the one we are replacing.
            # Key order matches how Jupyter writes cells, so rewrites stay diff-free.
            cell_id = cells[0].get('id') if replacing else None
            badge = {
                "cell_type": "markdown",
                "id": cell_id or uuid.uuid4().hex[:8],
                "metadata": {},
                "source": source
            }
        else:
            badge = {"cell_type": "markdown", "metadata": {}, "source": source}

        if replacing:
            cells[0] = badge
        else:
            cells.insert(0, badge)

        nb.write_text(json.dumps(data, indent=1, ensure_ascii=False) + '\n', encoding='utf-8')
        print(f"  ✓ {'Updated' if has else 'Added'}\n")
        done += 1

    print(f"✓ Processed {done}/{len(notebooks)}")


if __name__ == "__main__":
    main()
