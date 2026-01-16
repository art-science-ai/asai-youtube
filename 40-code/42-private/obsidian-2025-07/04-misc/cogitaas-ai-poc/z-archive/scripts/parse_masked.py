#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = [
#   "pandas",
# ]
# ///
import os
import json
import zipfile
from pathlib import Path
import pandas as pd

source_dir = Path(
    "Agentic AI - Documents/Data_Sharing/masked_examples/masked_example_1"
)
target_base = Path("parsed_data/Masked_Example")
target_base.mkdir(parents=True, exist_ok=True)

for file_path in source_dir.iterdir():
    if file_path.is_file():
        name = file_path.stem.replace(" ", "_")
        subdir = target_base / name
        subdir.mkdir(exist_ok=True)
        ext = file_path.suffix.lower()

        if ext == ".csv":
            df = pd.read_csv(file_path)
            df.to_json(subdir / "data.json", orient="records")
            tool_used = "pandas"
            output_desc = "data.json: JSON representation of the CSV data"
        elif ext == ".pbix":
            with zipfile.ZipFile(file_path, "r") as z:
                bytes_read = z.read("Report/Layout")
                s = bytes_read.decode("utf-16-le")
                json_obj = json.loads(s)
            with open(subdir / "data.json", "w") as f:
                json.dump(json_obj, f, indent=2)
            tool_used = "zipfile and json"
            output_desc = "data.json: JSON representation of the report layout"
        else:
            continue  # skip unknown files

        readme_content = f"""# Parsing {file_path.name}

## Process
The file was parsed using {tool_used} to extract and convert the data.

## Tools Used
- {tool_used}: For parsing and converting the file content.

## Output Files
- {output_desc}
"""
        (subdir / "readme.md").write_text(readme_content)
