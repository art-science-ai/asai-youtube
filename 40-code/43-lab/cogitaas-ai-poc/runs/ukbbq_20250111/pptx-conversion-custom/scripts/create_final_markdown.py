#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = []
# ///

import re

# Read the extracted text
with open('presentation-text.md', 'r') as f:
    content = f.read()

# Split by slide numbers
slides = re.split(r'<!-- Slide number: (\d+) -->', content)

# Build final markdown
output = []
output.append("# Consumer Surplus Factor (CSF) Study\n")
output.append("## HP KHC - UK: Brown Sauce\n")
output.append("### June 2025\n\n")
output.append("---\n\n")

# Process each slide
for i in range(1, len(slides), 2):
    slide_num = slides[i]
    slide_content = slides[i + 1].strip()

    # Add slide header
    output.append(f"## Slide {slide_num}\n\n")

    # Add slide image
    output.append(f"![Slide {slide_num}](slide-{slide_num.zfill(2)}.jpg)\n\n")

    # Add slide content
    if slide_content:
        output.append(slide_content)
        output.append("\n\n")

    output.append("---\n\n")

# Write final markdown
with open('10.Presentation.md', 'w') as f:
    f.write(''.join(output))

print("✓ Created 10.Presentation.md with inline images")
