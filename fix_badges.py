#!/usr/bin/env python3
"""Add Colab badges to Jupyter notebooks."""

import json
import subprocess
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
        has = 'colab-badge' in nb.read_text()
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
        data = json.loads(nb.read_text())
        url = f"https://colab.research.google.com/github/{user}/{repo}/blob/{branch}/{rel}"
        badge = {
            "cell_type": "markdown",
            "metadata": {},
            "source": [f"[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)]({url})\n"]
        }

        cells = data.get('cells', [])
        if cells and 'colab-badge' in str(cells[0]):
            cells[0] = badge
        else:
            cells.insert(0, badge)

        nb.write_text(json.dumps(data, indent=1) + '\n')
        print(f"  ✓ {'Updated' if has else 'Added'}\n")
        done += 1

    print(f"✓ Processed {done}/{len(notebooks)}")


if __name__ == "__main__":
    main()
