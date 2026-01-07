#!/usr/bin/env python3
"""Add Colab badges to Jupyter notebooks. Run from repository root."""

import json
import subprocess
from pathlib import Path


def git(*args):
    """Run git command and return output."""
    return subprocess.check_output(['git'] + list(args)).decode().strip()


def confirm(message):
    """Ask for confirmation. Returns True/False/'all'/'quit'."""
    while True:
        response = input(f"{message} [y/n/a/q]: ").lower().strip()
        if response == 'y': return True
        if response == 'n': return False
        if response == 'a': return 'all'
        if response == 'q': return 'quit'


def add_colab_badge(notebook_path, repo_root, user, repo, branch):
    """Add or update Colab badge in notebook."""
    rel_path = notebook_path.relative_to(repo_root)

    with open(notebook_path) as f:
        nb = json.load(f)

    url = f"https://colab.research.google.com/github/{user}/{repo}/blob/{branch}/{rel_path}"
    badge = {
        "cell_type": "markdown",
        "metadata": {},
        "source": [f"[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)]({url})\n"]
    }

    cells = nb.get('cells', [])
    has_badge = cells and 'colab-badge' in str(cells[0])

    if has_badge:
        cells[0] = badge
        print("  ✓ Updated\n")
    else:
        cells.insert(0, badge)
        print("  ✓ Added\n")

    with open(notebook_path, 'w') as f:
        json.dump(nb, f, indent=1)
        f.write('\n')


def main():
    # Get repo info
    repo_root = Path(git('rev-parse', '--show-toplevel'))
    remote = git('config', '--get', 'remote.origin.url')
    user, repo = remote.split('github.com')[-1].strip(':/.git').split('/')
    branch = git('rev-parse', '--abbrev-ref', 'HEAD')

    print(f"Repository: {user}/{repo}")
    print(f"Branch: {branch}\n")

    # Find notebooks
    notebooks = [nb for nb in repo_root.rglob('*.ipynb')
                 if not any(p.startswith('.') for p in nb.parts)]

    if not notebooks:
        print("No notebooks found.")
        return

    print(f"Found {len(notebooks)} notebook(s)\n")

    # Process each notebook
    auto_yes = False
    processed = 0

    for i, nb_path in enumerate(notebooks, 1):
        rel_path = nb_path.relative_to(repo_root)
        print(f"[{i}/{len(notebooks)}] {rel_path}")

        # Check if badge exists
        with open(nb_path) as f:
            has_badge = 'colab-badge' in f.read()

        status = "exists" if has_badge else "missing"
        print(f"  Badge: {status}")

        # Confirm
        if not auto_yes:
            response = confirm("Process?")
            if response == 'quit':
                print("Quitting...")
                break
            if response == 'all':
                auto_yes = True
            if not response and response != 'all':
                print("  Skipped\n")
                continue

        # Process
        add_colab_badge(nb_path, repo_root, user, repo, branch)
        processed += 1

    print(f"✓ Done! Processed {processed}/{len(notebooks)}")


if __name__ == "__main__":
    main()
