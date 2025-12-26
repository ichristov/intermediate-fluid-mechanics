#!/usr/bin/env python3
"""Strip widget and animation outputs from Jupyter notebooks while keeping other outputs."""
import sys
import json

def strip_widget_outputs(notebook_path):
    with open(notebook_path, 'r', encoding='utf-8') as f:
        nb = json.load(f)

    modified = False

    # Strip widget metadata at notebook level
    if 'metadata' in nb and 'widgets' in nb['metadata']:
        del nb['metadata']['widgets']
        modified = True

    # Process each cell
    for cell in nb.get('cells', []):
        # Strip widget metadata at cell level
        if 'metadata' in cell and 'widgets' in cell['metadata']:
            del cell['metadata']['widgets']
            modified = True

        # Strip widget and animation outputs
        if 'outputs' in cell:
            new_outputs = []
            for output in cell['outputs']:
                if 'data' in output:
                    data = output['data']

                    # Check if this output contains any widgets
                    widget_keys = [
                        'application/vnd.jupyter.widget-view+json',
                        'application/vnd.jupyter.widget-state+json',
                        'application/vnd.jupyter.widget-model+json',
                    ]

                    has_widget = any(key in data for key in widget_keys)

                    # If output has a widget, skip the entire output
                    if has_widget:
                        modified = True
                        continue

                    # Otherwise, check for HTML/JS/video to strip
                    keys_to_remove = [
                        'text/html',
                        'application/javascript',
                        'video/mp4',
                        'video/webm'
                    ]

                    for key in keys_to_remove:
                        if key in data:
                            del data[key]
                            modified = True

                    # Keep output only if it still has data
                    if data:
                        new_outputs.append(output)
                    else:
                        modified = True
                else:
                    # Keep non-data outputs (like stream)
                    new_outputs.append(output)

            cell['outputs'] = new_outputs

    if modified:
        with open(notebook_path, 'w', encoding='utf-8') as f:
            json.dump(nb, f, indent=1, ensure_ascii=False)
            f.write('\n')
        return 1  # Signal that file was modified

    return 0

if __name__ == '__main__':
    exit_code = 0
    for notebook in sys.argv[1:]:
        if strip_widget_outputs(notebook):
            exit_code = 1
    sys.exit(exit_code)
