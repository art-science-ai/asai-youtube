# Fabric CLI Learning Lab

A learning playground for exploring and understanding the Fabric CLI (https://github.com/danielmiessler/Fabric). This is a hands-on experimental space focused on building basic CLI proficiency through daily usage patterns and practical exploration.

## Setup

### Installation

**Linux (via nix):**

```bash
nix-env -iA nixpkgs.fabric-ai
```

**macOS (via nix - preferred):**

```bash
nix-env -iA nixpkgs.fabric-ai
```

**macOS (via homebrew - fallback if nix not available):**

```bash
brew install fabric
```

### Home Manager Option (Declarative)

For a more reproducible setup with Home Manager, you can configure Fabric declaratively:

```nix
programs.fabric-ai = {
  enable = true;
  enableBashIntegration = true;
  enablePatternsAliases = true;
  enableYtAlias = true;
};
```

### Verification

After installation, verify Fabric is working:

```bash
fabric --version
```

### Download Patterns

Fabric needs to download its patterns before first use. Patterns are stored in `~/.config/fabric/patterns/`:

```bash
fabric --updatepatterns
```

This fetches all available patterns from the Fabric repository. You can list them with:

```bash
fabric --listpatterns
```

### Quick Test

After patterns are downloaded, test Fabric with a simple example:

```bash
echo "test input" | fabric --dry-run -p summarize
```

The `--dry-run` flag shows what would be sent to the model without actually using API credits. Remove it to actually process text:

```bash
echo "Your text here" | fabric -p summarize
```

### Installation Decisions

**Why nix?**

- Nix is the preferred package manager for this environment
- Fabric is available in nixpkgs as `fabric-ai`
- Provides better reproducibility than binary installers
- Works consistently across Linux and macOS

**Why not the curl installer?**

The official install script (`curl -L https://www.fabric.ai/install.sh | sh`) works fine, but using nix keeps everything within the package management system and provides better rollback capabilities.

**Home Manager integration noted**

The `programs.fabric-ai` Home Manager module provides shell integration (bash/zsh), pattern aliases, and convenience features. This wasn't used for the initial installation but is documented for future reference.

## Phase Progress

- [x] **Phase 1: Setup & Installation** - Fabric CLI installed and documented
- [ ] **Phase 2: Pattern Exploration** - Learn available patterns and create catalog
- [ ] **Phase 3: Hands-On Practice** - Run commands and document examples
- [ ] **Phase 4: Use Case Discovery** - Identify personal applications

## Pattern Overview

Fabric has over 230 available patterns for text processing and AI workflows. Patterns are organized into categories:

### Text Analysis Patterns
- `summarize` - Condense long text into key points
- `extract_wisdom` - Extract insights and lessons from text
- `analyze_paper` / `analyze_paper_simple` - Analyze academic papers
- `analyze_claims` - Examine claims and arguments
- `analyze_incident` - Review incident reports

### Content Creation Patterns
- `create_5_sentence_summary` - Generate concise summaries
- `create_academic_paper` - Structure academic writing
- `create_aphorisms` - Generate memorable short sayings
- `blog_post` - Create blog content
- `tweet` - Compose social media posts

### Communication Patterns
- `email` - Draft email messages
- `concall_summary` - Summarize meeting notes
- `analyze_email_headers` - Examine email metadata
- `analyze_sales_call` - Review sales conversations

### Development Patterns
- `coding_master` - Code analysis and assistance
- `extract_ingredients` - Pull structured data from text
- `convert_to_markdown` - Transform text to markdown format

### Learning Patterns
- `extract_wisdom` - Extract lessons and insights
- `analyze_interview` - Review interview content
- `create_study_guide` - Generate study materials

## Common Usage Examples

### Basic Pattern Usage

```bash
# Summarize text
cat article.txt | fabric --pattern summarize

# Extract insights from a document
cat notes.md | fabric --pattern extract_wisdom

# Analyze a paper
cat paper.pdf | fabric --pattern analyze_paper_simple
```

### Using with Multiple Patterns

```bash
# Chain patterns together
cat long-document.txt | fabric --pattern summarize | fabric --pattern extract_wisdom
```

### Dry Run Mode

Use `--dry-run` to preview what would be sent to the AI model:

```bash
echo "Your text here" | fabric --dry-run --pattern summarize
```

### Interactive Mode

```bash
# Enter interactive mode for multi-step processing
fabric --interactive
```

## Pattern Discovery Commands

### List All Patterns
```bash
fabric --listpatterns
```

### Get Pattern Help
```bash
fabric --listpatterns | grep -i "summary"
```

### View Pattern Details
Patterns are stored in `~/.config/fabric/patterns/` and can be inspected directly:

```bash
ls ~/.config/fabric/patterns/
cat ~/.config/fabric/patterns/summarize/system.md
```

## Next Steps

### Phase 2: Pattern Exploration
- Explore patterns relevant to your workflow
- Document frequently used patterns
- Create personal pattern reference

### Phase 3: Hands-On Practice
- Test patterns with real data
- Build example command library
- Document edge cases and best practices

### Phase 4: Use Case Discovery
- Identify daily workflows that benefit from Fabric
- Create shell aliases for common operations
- Integrate Fabric into existing workflows
