#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = [
#   "pyyaml>=6.0",
# ]
# ///

"""
Directory Indexer - CLI tool for creating markdown index files with YAML frontmatter
"""

import argparse
from pathlib import Path
from typing import List, NamedTuple
from datetime import datetime
import yaml


class FileItem(NamedTuple):
    """File or directory metadata"""
    path: str  # Relative path from target directory
    size: int  # Size in bytes
    modified_time: float  # Modified time (mtime timestamp)
    item_type: str  # 'file' or 'dir'


def index_directory(target_dir: Path, output_dir: Path) -> None:
    """
    Index a directory and create markdown files with YAML frontmatter
    """
    print(f"Indexing directory: {target_dir}")
    print(f"Output directory: {output_dir}")

    # Create output directory if it doesn't exist
    output_dir.mkdir(parents=True, exist_ok=True)

    # Traverse directory and collect items
    items = traverse_directory(target_dir)

    print(f"\nFound {len(items)} items")

    # Generate markdown files
    generate_markdown_files(items, target_dir, output_dir)

    print(f"\nIndexing complete!")


def traverse_directory(target_dir: Path) -> List[FileItem]:
    """
    Recursively traverse target directory and collect file/directory metadata
    """
    items = []

    for item in target_dir.rglob("*"):
        try:
            relative_path = str(item.relative_to(target_dir))

            # Skip if it's the target directory itself
            if relative_path == ".":
                continue

            stat = item.stat()
            item_type = "dir" if item.is_dir() else "file"

            file_item = FileItem(
                path=relative_path,
                size=stat.st_size,
                modified_time=stat.st_mtime,
                item_type=item_type
            )

            items.append(file_item)

        except PermissionError as e:
            print(f"Warning: Permission denied for {item}: {e}")
            continue

    return items


def generate_markdown_files(items: List[FileItem], target_dir: Path, output_dir: Path) -> None:
    """
    Generate markdown files with YAML frontmatter for each item
    Preserves existing markdown body content when updating files
    """
    for item in items:
        # Sanitize path for filename (replace slashes with dashes)
        safe_filename = item.path.replace("/", "-").replace("\\", "-")
        md_file = output_dir / f"{safe_filename}.md"

        # Format modified date as ISO string
        modified_date = datetime.fromtimestamp(item.modified_time).isoformat()

        # Create YAML frontmatter
        frontmatter = {
            "path": item.path,
            "size": item.size,
            "modified_date": modified_date,
            "type": item.item_type
        }

        # Check if file already exists
        if md_file.exists():
            # Read existing file to preserve markdown body
            try:
                with open(md_file, "r") as f:
                    content = f.read()

                # Split on first '---' separator to extract body
                parts = content.split("---", 2)

                if len(parts) >= 3:
                    # Has frontmatter and body - preserve body
                    body = parts[2].lstrip()
                else:
                    # Malformed or no body - start fresh
                    body = ""

            except Exception as e:
                print(f"Warning: Could not read existing file {md_file}: {e}")
                body = ""

        else:
            # New file - empty body
            body = ""

        # Write markdown file with YAML frontmatter
        with open(md_file, "w") as f:
            f.write("---\n")
            yaml.dump(frontmatter, f, default_flow_style=False)
            f.write("---\n")
            # Write preserved body (or empty if new file)
            if body:
                f.write(body)


def main():
    """
    Main entry point - parse arguments and run indexing
    """
    parser = argparse.ArgumentParser(
        description="Index a directory into markdown files with YAML frontmatter"
    )

    parser.add_argument(
        "target_dir",
        type=str,
        help="Target directory path to index"
    )

    parser.add_argument(
        "--output-dir",
        type=str,
        default=".",
        help="Output directory for markdown files (default: current working directory)"
    )

    args = parser.parse_args()

    # Convert to Path objects
    target_dir = Path(args.target_dir).resolve()
    output_dir = Path(args.output_dir).resolve()

    # Validate target directory exists
    if not target_dir.exists():
        print(f"Error: Target directory does not exist: {target_dir}")
        return 1

    if not target_dir.is_dir():
        print(f"Error: Target path is not a directory: {target_dir}")
        return 1

    # Run indexing
    try:
        index_directory(target_dir, output_dir)
        return 0
    except Exception as e:
        print(f"Error during indexing: {e}")
        return 1


if __name__ == "__main__":
    exit(main())
