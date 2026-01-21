#!/usr/bin/env python3

import os
import re
import shutil
from pathlib import Path

def main():
    """
    Translates command files from the ai-agents format to the gemini-cli format.
    """
    # Get the project root directory (assuming the script is in _scripts)
    project_root = Path(__file__).parent.parent

    src_dir = project_root / "dotfiles/ai-agents/.config/ai-agents/commands"
    dest_dir = project_root / "dotfiles/gemini/.gemini/commands"

    # Clean and recreate the destination directory
    if dest_dir.exists():
        shutil.rmtree(dest_dir)
    dest_dir.mkdir(parents=True)

    # Find all markdown files in the source directory
    for src_file in src_dir.glob("*.md"):
        base_name = src_file.stem
        dest_file = dest_dir / f"{base_name}.toml"

        print(f"Translating {src_file} to {dest_file}")

        with open(src_file, "r") as f:
            lines = f.readlines()

        # Extract description and prompt content
        description = ""
        prompt_content = ""
        in_front_matter = False
        in_body = False

        for line in lines:
            if line.strip() == "---":
                if not in_front_matter:
                    in_front_matter = True
                else:
                    in_front_matter = False
                    in_body = True
                continue

            if in_front_matter and line.startswith("description:"):
                description = line.split("description:", 1)[1].strip()
            
            if in_body:
                prompt_content += line

        # Remove leading/trailing whitespace from prompt
        prompt_content = prompt_content.strip()

        # Replace !`command` with !{command}
        prompt_content = re.sub(r'!`([^`]+)`', r'!{\1}', prompt_content)

        # Write to the destination file
        with open(dest_file, "w") as f:
            f.write(f"# In: {dest_file.relative_to(project_root)}\n")
            f.write(f"# This command will be invoked via: /{base_name}\n\n")
            f.write(f'description = "{description}"\n\n')
            f.write('prompt = """\n')
            f.write(prompt_content)
            f.write('\n"""\n')

    print("Translation complete.")

if __name__ == "__main__":
    main()
