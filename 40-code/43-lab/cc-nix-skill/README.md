# Claude Code Nix Skill

**Goal**: Create a proper Claude Code skill for Nix ecosystem by extracting and documenting the underlying API methods from the mcp-nixos MCP server, following gtd-cc architectural patterns.

## Quick Overview

This repository contains:
- **mcp-nixos**: A production-ready MCP server with 18 Nix tools (the source of truth for API methods)
- **nix-gtd skill**: The target skill that documents and uses Nix APIs directly
- **(Appendix)**: The mcp-to-skill-converter approach that proved inadequate for our goals

**`★ Insight ─────────────────────────────────────`**
The key insight is that instead of creating a simple skill wrapper around an MCP server (which adds unnecessary complexity), we should document the actual API methods that mcp-nixos uses internally. This provides:
- Direct API knowledge without MCP dependency
- Educational value for users learning NixOS APIs
- Lightweight implementation with progressive disclosure
- Following proper gtd-cc skill patterns
`─────────────────────────────────────────────────`

## Understanding the Nix APIs

After analyzing the mcp-nixos implementation, we've identified four distinct API sources:

### 1. **NixOS Elasticsearch API**
The backbone for searching NixOS packages, options, and programs.
- **Base URL**: `https://search.nixos.org/backend`
- **Authentication**: Basic auth with credentials (`aWVSALXpZv`, `X8gPHnzL52wFEekuxsfQ9cSh`)
- **Channels**: Dynamic indices (e.g., `latest-44-nixos-unstable`, `latest-44-nixos-25.05`)
- **Query Types**: Packages, options, programs with specific Elasticsearch query structures

### 2. **Home Manager HTML Parsing**
Configuration options are extracted from the official documentation.
- **URL**: `https://nix-community.github.io/home-manager/options.xhtml`
- **Method**: BeautifulSoup parsing of `<dt>` elements
- **Pattern**: Option names in anchor IDs like `opt-programs.git.enable`

### 3. **nix-darwin HTML Parsing**
Similar to Home Manager, but for macOS Nix configurations.
- **URL**: `https://nix-darwin.github.io/nix-darwin/manual/index.html`
- **Method**: Same BeautifulSoup approach as Home Manager

### 4. **NixHub Version API**
Historical package version information.
- **Base URL**: `https://nixhub.io/api`
- **Endpoints**: `/packages/{name}/versions`, `/find/{name}/{version}`

## Proposed Skill Architecture

### Plugin Structure
```
plugins/nix/
├── .claude-plugin/plugin.json          # Plugin manifest
├── commands/                           # Thin wrapper commands
│   ├── nix-search.md                   # Search packages/options
│   ├── nix-home.md                     # Home Manager configs
│   ├── nix-darwin.md                  # nix-darwin configs
│   └── nix-version.md                 # Package version history
├── agents/                            # Autonomous executors
│   └── nix-research-agent.md           # Multi-step Nix research
└── skills/
    └── nix-gtd/                       # Main skill
        ├── SKILL.md                    # Progressive disclosure overview
        ├── workflows/                  # Detailed procedures
        │   ├── search-nixos-packages.md
        │   ├── search-home-options.md
        │   ├── search-darwin-options.md
        │   └── get-package-versions.md
        └── references/                 # API documentation
            ├── nixos-elasticsearch-api.md
            ├── home-manager-html-structure.md
            ├── nix-darwin-html-structure.md
            └── nixhub-version-api.md
```

### Key Design Principles

1. **Progressive Disclosure**
   - SKILL.md: ~100 tokens (metadata only)
   - Workflows: ~3-5k tokens (loaded when needed)
   - References: On-demand API details

2. **Direct API Access**
   - No MCP server dependency
   - Document actual HTTP requests
   - Code examples for each API

3. **Educational Focus**
   - Users learn NixOS APIs directly
   - Clear error handling patterns
   - Best practices for each API source

## Implementation Plan

### Phase 1: Create Plugin Structure
1. Initialize the nix plugin with proper manifest
2. Create skill directory with SKILL.md
3. Set up workflow and reference directories

### Phase 2: Document Core Workflows
1. **search-nixos-packages.md**
   - Elasticsearch query construction
   - Channel resolution logic
   - Result formatting examples

2. **search-home-options.md**
   - HTML parsing strategy
   - Option name patterns
   - Common use cases

3. **search-darwin-options.md**
   - macOS-specific options
   - Comparison with Home Manager
   - Platform considerations

4. **get-package-versions.md**
   - NixHub API usage
   - Version history interpretation
   - Cross-referencing with channels

### Phase 3: Create Commands and Agents
1. Thin wrapper commands that reference workflows
2. Autonomous agent for complex multi-step research
3. Integration examples and use cases

## API Details Extracted from mcp-nixos

### NixOS Elasticsearch Query Patterns

**Package Search**:
```json
{
  "query": {
    "bool": {
      "must": [{"term": {"type": "package"}}],
      "should": [
        {"match": {"package_pname": {"query": "python", "boost": 3}}},
        {"match": {"package_description": "python"}}
      ],
      "minimum_should_match": 1
    }
  }
}
```

**Option Search**:
```json
{
  "query": {
    "bool": {
      "must": [{"term": {"type": "option"}}],
      "should": [
        {"wildcard": {"option_name": "*search*"}},
        {"match": {"option_description": "search"}}
      ],
      "minimum_should_match": 1
    }
  }
}
```

### Channel Resolution Logic
Channels are dynamically discovered by testing Elasticsearch indices:
- Test patterns: `latest-{gen}-nixos-{version}` where gen ∈ [43, 44, 45] and version ∈ ["unstable", "25.05", "25.11"]
- Fallback mappings for common channels
- Validation via `_count` endpoint

### HTML Parsing Patterns

Both Home Manager and nix-darwin use similar structures:
```python
# Parse <dt> elements with anchor IDs
soup = BeautifulSoup(response.content, "html.parser")
dts = soup.find_all("dt")

for dt in dts:
    anchor = dt.find("a", id=True)
    if anchor and anchor.get("id", "").startswith("opt-"):
        option_name = anchor.get("id")[4:]  # Remove "opt-" prefix
```

## Benefits of This Approach

1. **No External Dependencies**: Skill works without MCP server
2. **Educational Value**: Users learn actual NixOS APIs
3. **Performance**: Direct HTTP calls, no extra layers
4. **Flexibility**: Easy to extend with additional Nix tools
5. **Maintenance**: Simpler than maintaining MCP bridge

## Development Commands

```bash
# Create plugin structure
mkdir -p plugins/nix/{commands,agents,skills/nix-gtd/{workflows,references}}

# Create plugin manifest
cat > plugins/nix/.claude-plugin/plugin.json << 'EOF'
{
  "name": "nix",
  "version": "1.0.0",
  "description": "NixOS, Home Manager, and nix-darwin expertise",
  "author": {"name": "Claude Code Nix Skill"},
  "components": [
    {
      "type": "skill",
      "name": "nix-gtd",
      "path": "skills/nix-gtd"
    }
  ]
}
EOF

# Install in Claude Code
cp -r plugins/nix ~/.claude/skills/
```

---

## Appendix: MCP-to-Skill Converter Approach (Deprecated)

The following section documents the initial approach using the mcp-to-skill-converter, which was ultimately abandoned in favor of direct API documentation.

### Why This Approach Didn't Work

1. **Added Complexity**: Introduced unnecessary MCP server dependency
2. **Opaque Implementation**: Users couldn't learn the actual APIs
3. **Context Inefficiency**: Still required loading tool definitions
4. **Maintenance Overhead**: Required both skill and MCP server

### Original Instructions

*(The original README content has been moved here for reference)*

The goal is to create a Claude Code skill for Nix by converting the existing mcp-nixos MCP server using the mcp-to-skill-converter.

## Quick overview

This repository contains:
- **mcp-nixos**: A production-ready MCP server with 18 Nix tools (package search, version history, Home Manager, nix-darwin support)
- **-mcp-to-skill-converter**: A converter tool that transforms any MCP server into a Claude Code skill with progressive disclosure (90% context savings)

The converter will generate a fully functional Nix skill by introspecting the mcp-nixos server and creating the necessary skill structure.

## Prerequisites

Before converting, ensure you have:
- `uv` package manager installed (https://docs.astral.sh/uv/getting-started/)
- Access to both the mcp-nixos and -mcp-to-skill-converter directories

## Step-by-step conversion instructions

### Step 1: Verify the MCP server configuration

The mcp-nixos server needs to be properly configured. Check if there's an existing MCP configuration file:

- Look for `.mcp.json` or `mcp-config.json` in the mcp-nixos directory
- If found, verify it contains the correct server startup command (should use `uv run mcp_nixos` or equivalent)
- If not found, you'll need to create one (see troubleshooting section below)

Expected configuration structure (using relative paths):
```json
{
  "mcpServers": {
    "nixos": {
      "type": "stdio",
      "command": "uv",
      "args": [
        "run",
        "--directory",
        ".",
        "mcp-nixos"
      ]
    }
  }
}
```

The `.mcp.json` already exists in the mcp-nixos directory with relative paths configured. The `--directory` argument uses `.` to reference the mcp-nixos directory itself.

### Step 2: Set up the converter environment

Navigate to the mcp-to-skill-converter directory:

```bash
cd cc-nix-skill/-mcp-to-skill-converter
```

Install the converter's dependencies using uv:

```bash
uv pip install mcp
```

### Step 3: Run the conversion command

Before running the converter, start the mcp-nixos server in a separate terminal:

```bash
cd cc-nix-skill/mcp-nixos
uv run mcp-nixos
```

Then in another terminal, run the converter:

```bash
cd cc-nix-skill/-mcp-to-skill-converter
uv run python mcp_to_skill.py \
  --mcp-config ../mcp-nixos/.mcp.json \
  --output-dir ../nix-skill
```

Flags:
- `--mcp-config`: Path to the mcp-nixos configuration file (relative: `../mcp-nixos/.mcp.json`)
- `--output-dir`: Where the generated skill will be placed (relative: `../nix-skill`)

The converter will:
1. Connect to the running mcp-nixos server
2. Introspect all available tools
3. Generate the skill structure in the output directory

### Step 4: Verify the generated skill structure

After conversion completes, check that the output directory contains:

Required files:
- `SKILL.md` - Skill metadata and instructions (should be ~100 tokens)
- `executor.py` - Python script that handles tool execution
- `mcp-config.json` - Server configuration for the skill
- `package.json` - Dependencies and skill metadata

File purpose:
- **SKILL.md**: Contains skill name, description, and progressive disclosure instructions. Loaded at startup.
- **executor.py**: Dynamically handles tool discovery and execution. Supports `--list`, `--describe <tool>`, and `--call '<json>'` commands.
- **mcp-config.json**: Configuration for connecting to the mcp-nixos MCP server
- **package.json**: Node.js package metadata for the skill

### Step 5: Test the executor locally

Verify that the generated executor can communicate with the MCP server. Make sure the mcp-nixos server is still running (from Step 3).

List all available tools:
```bash
cd cc-nix-skill/nix-skill
uv run python executor.py --list
```

Expected output: A list of all 18 Nix tools (nixos_search, nixos_info, home_manager_search, etc.)

Get detailed information about a specific tool:
```bash
uv run python executor.py --describe nixos_search
```

Expected output: JSON schema showing the tool's parameters and description

Test a tool call (example - search for packages):
```bash
uv run python executor.py --call '{"tool": "nixos_search", "arguments": {"query": "python"}}'
```

Expected output: Search results for packages matching "python"

### Step 6: Integrate the skill into Claude Code

Move the generated skill to Claude Code's skill directory:

```bash
mkdir -p ~/.claude/skills/
cp -r cc-nix-skill/nix-skill ~/.claude/skills/
```

Or configure it in Claude Code settings if using a custom skill path.

Create a `.claude` directory in the skill if you want to add custom configuration:

```bash
mkdir -p ~/.claude/skills/nix-skill/.claude
```

(Optional) Add custom agents or commands by creating files in `.claude/agents/` or `.claude/commands/` directories.

### Step 7: Test the skill in Claude Code

Open Claude Code and verify the skill loads:

1. Type `/help` to see if `nix-skill` appears in available skills
2. Invoke a tool to test: Ask Claude Code to search for a NixOS package
3. Verify that all 18 tools are accessible and responsive

## What the converter generates

The converter creates a Claude Code skill with these characteristics:

Progressive disclosure:
- **At startup**: Only SKILL.md metadata (~100 tokens) - minimal context overhead
- **When invoked**: Full tool instructions are loaded (~5k tokens)
- **During execution**: Tools run externally - zero context cost

Tool categories (all 18 from mcp-nixos):
- NixOS tools (6): nixos_search, nixos_info, nixos_stats, nixos_channels, nixos_flakes_search, nixos_flakes_stats
- Version history tools (2): nixhub_package_versions, nixhub_find_version
- Home Manager tools (5): home_manager_search, home_manager_info, home_manager_stats, home_manager_list_options, home_manager_options_by_prefix
- nix-darwin tools (5): darwin_search, darwin_info, darwin_stats, darwin_list_options, darwin_options_by_prefix

Data sources:
- NixOS packages/options: search.nixos.org Elasticsearch API
- Version history: NixHub.io API
- Home Manager options: Official documentation (HTML parsing)
- nix-darwin options: Official documentation (HTML parsing)

## Troubleshooting

### Issue: Converter can't find or connect to MCP server

**Solution**: The mcp-nixos server needs to be running when the converter introspects it.

Terminal 1 - Start the server:
```bash
cd cc-nix-skill/mcp-nixos
uv run mcp-nixos
```

Terminal 2 - Run the converter (in another terminal):
```bash
cd cc-nix-skill/-mcp-to-skill-converter
uv run python mcp_to_skill.py \
  --mcp-config ../mcp-nixos/.mcp.json \
  --output-dir ../nix-skill
```

Both terminals must be open simultaneously.

### Issue: MCP configuration file not found

**Solution**: The `.mcp.json` file already exists in the mcp-nixos directory with relative paths. Verify it exists:

```bash
ls -la cc-nix-skill/mcp-nixos/.mcp.json
```

If it doesn't exist, create it with relative paths:

```bash
cat > cc-nix-skill/mcp-nixos/.mcp.json << 'EOF'
{
  "mcpServers": {
    "nixos": {
      "type": "stdio",
      "command": "uv",
      "args": [
        "run",
        "--directory",
        ".",
        "mcp-nixos"
      ]
    }
  }
}
EOF
```

### Issue: executor.py shows "no such file or directory"

**Solution**: Make sure you're in the correct directory when running the executor. Use relative paths and the correct working directory:

```bash
cd cc-nix-skill/nix-skill
uv run python executor.py --list
```

Verify that mcp-config.json exists and has the correct relative paths set.

### Issue: Executor returns empty tool list

**Solution**: Verify the mcp-nixos MCP server is running and accessible. Check server logs for errors.

## Additional resources

- **mcp-nixos documentation**: See `/Users/nikhilmaddirala/repos/cc-nix-skill/mcp-nixos/README.md`
- **Converter documentation**: See `/Users/nikhilmaddirala/repos/cc-nix-skill/-mcp-to-skill-converter/README.md`
- **Nix expertise guide**: See `/Users/nikhilmaddirala/repos/cc-nix-skill/mcp-nixos/.claude/agents/nix-expert.md`

## Expected outcome

After following these steps, you'll have:
- A fully functional Claude Code skill named "nix-skill"
- Access to all 18 Nix tools through a progressive disclosure pattern
- Minimal context overhead (90% reduction vs. preloading all tools)
- Ability to search packages, get version history, and configure Nix environments

### Key Takeaway

While the mcp-to-skill-converter is useful for some MCP servers, for Nix ecosystem tools, it's better to document the underlying APIs directly. This provides more value to users and follows the gtd-cc architectural patterns more effectively.