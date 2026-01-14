# AI Agent Rules

## General guidelines
- CRITICAL: Always read the README.md, AGENTS.md, and CONTRIBUTING.md in the root directory of the project.

## Markdown 
- Use sentence case for headings.
- Avoid using bold and italics formatting anywhere.
- Avoid using numbered lists for bullet points; use unordered lists instead.
- Avoid using too many header levels. Use nested bullet points instead.


## Tools and Environment
This system uses **uv for Python** and **nix for CLI tools**, with special handling for packages that require system libraries.

### Python scripts (via uv)
- All parsing scripts use uv's inline metadata format for dependency-free execution:
- To run one-off python tools, use `uvx` and `uv run`
- When writing one-off python scripts, always make them executable with in-line script metadata such that they can be run self contained with `uv run --script`. For example:
```python
#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = [
#   "httpx>=0.27.0",
#   "rich>=13.0.0",
# ]
# ///
import httpx
from rich import print

response = httpx.get("https://api.github.com")
print(f"[green]Status: {response.status_code}[/green]")
```

```bash
# Run scripts directly (uv handles dependencies automatically)
./scripts/parse_pptx.py "path/to/file.pptx"

# One-off Python tools
uvx python-pptx --help
```

### CLI tools (via nix)

Use nix for command-line tools without installation:

```bash
# One-off CLI tool usage
nix run nixpkgs#csvtool --help
nix run nixpkgs#pandoc --version
```

### Handling system library dependencies

Some Python packages (markitdown, numpy, pandas) have C extensions requiring system libraries like `libstdc++.so.6`. On NixOS or containerized environments, these aren't always available.

**Standard pattern for scripts with C extensions:**

```bash
nix shell nixpkgs#stdenv.cc.cc.lib --command bash -c "
  export LD_LIBRARY_PATH=$(nix eval --raw nixpkgs#stdenv.cc.cc.lib)/lib:\$LD_LIBRARY_PATH &&
  rm -rf ~/.cache/uv/environments-v2/parse-*-* &&
  ./scripts/parse_pptx.py 'path/to/file.pptx'
"
```

**What this does:**
1. `nix shell nixpkgs#stdenv.cc.cc.lib` - provides the C++ standard library
2. Sets `LD_LIBRARY_PATH` - makes the library findable at runtime
3. Clears uv cache - forces rebuild with the library visible
4. Runs the script - executes in the library-enabled environment

**Common system libraries:**
- `nixpkgs#stdenv.cc.cc.lib` - C++ standard library (libstdc++.so.6)
- `nixpkgs#zlib` - Compression library
- `nixpkgs#openssl` - SSL/TLS library

**Fallback option:** Use pure Python alternatives (e.g., python-pptx instead of markitdown) when system libraries aren't available.



