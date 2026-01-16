# Building Effective Agents

**Source:** [Anthropic Engineering](https://www.anthropic.com/engineering/building-effective-agents)
**Published:** December 19, 2024
**Authors:** Erik Schluntz and Barry Zhang

---

## Introduction

Anthropic has collaborated with numerous teams developing LLM agents. The most successful implementations leverage "simple, composable patterns" rather than intricate frameworks.

This guide shares lessons learned from customer implementations and internal agent development, offering developers practical strategies for effective agent construction.

## What Are Agents?

The term "agent" has multiple definitions. Some organizations describe agents as fully autonomous systems operating independently over extended periods using various tools. Others refer to more prescriptive implementations following predefined workflows.

Anthropic categorizes these variations as **agentic systems** while distinguishing between two architectural types:

- **Workflows**: LLMs and tools orchestrated through predefined code paths
- **Agents**: Systems where LLMs dynamically direct their own processes and tool usage, maintaining control over task accomplishment

Additional details appear in Appendix 1, which explores domains where customers have found particular value.

## When (and When Not) to Use Agents

When developing LLM applications, prioritize simplicity and increase complexity only when necessary. Agentic systems often trade latency and cost for improved performance—weigh this tradeoff carefully.

Workflows provide predictability for well-defined tasks, while agents excel when flexibility and model-driven decision-making are required at scale. For many applications, optimizing single LLM calls with retrieval and contextual examples suffices.

## When and How to Use Frameworks

Several frameworks facilitate agentic system implementation:

- [Claude Agent SDK](https://platform.claude.com/docs/en/agent-sdk/overview)
- [Strands Agents SDK by AWS](https://strandsagents.com/latest/)
- [Rivet](https://rivet.ironcladapp.com/) - drag-and-drop GUI workflow builder
- [Vellum](https://www.vellum.ai/) - GUI tool for building and testing workflows

These frameworks simplify standard tasks like LLM calls and tool chaining. However, they often introduce abstraction layers that obscure underlying prompts and responses, complicating debugging and tempting unnecessary complexity.

Start by using LLM APIs directly—many patterns require only a few lines of code. If using frameworks, understand the underlying implementation, as incorrect assumptions about internal mechanics represent a common error source.

See the [cookbook](https://github.com/anthropics/anthropic-cookbook/tree/main/patterns/agents) for sample implementations.

## Building Blocks, Workflows, and Agents

This section explores production patterns for agentic systems, progressing from foundational augmented LLMs to autonomous agents.

### Building Block: The Augmented LLM

Agentic systems fundamentally consist of LLMs enhanced with augmentations such as retrieval, tools, and memory. Modern models actively leverage these capabilities—generating search queries, selecting appropriate tools, and managing information retention.

![The augmented LLM](01-augmented-llm.png)

Focus on two implementation aspects: tailoring capabilities to specific use cases and providing clear, well-documented interfaces. The [Model Context Protocol](https://www.anthropic.com/news/model-context-protocol) enables integration with third-party tools through a simple [client implementation](https://modelcontextprotocol.io/tutorials/building-a-client#building-mcp-clients).

For the remainder of this guide, assume each LLM call has access to these augmented capabilities.

### Workflow: Prompt Chaining

Prompt chaining decomposes tasks into sequential steps, with each LLM call processing the previous output. Programmatic checks ("gates") on intermediate steps ensure the process remains on track.

![The prompt chaining workflow](02-prompt-chaining.png)

**When to use:** This workflow suits tasks decomposable into fixed subtasks, trading latency for higher accuracy by simplifying individual LLM calls.

**Examples:**
- Generating marketing copy, then translating it
- Writing document outlines, validating them, then drafting the full document

### Workflow: Routing

Routing classifies inputs and directs them to specialized tasks. This enables separation of concerns and more specialized prompts, preventing optimization for one input type from degrading performance on others.

![The routing workflow](03-routing.png)

**When to use:** Routing works well for complex tasks with distinct categories handled separately, where accurate classification is achievable via LLMs or traditional algorithms.

**Examples:**
- Directing different customer service queries (general questions, refunds, technical support) into separate processes
- Routing straightforward questions to efficient models and complex ones to capable models

### Workflow: Parallelization

LLMs can work simultaneously on tasks with aggregated outputs. This manifests in two variations:

- **Sectioning**: Breaking tasks into independent parallel subtasks
- **Voting**: Running identical tasks multiple times for diverse outputs

![The parallelization workflow](04-parallelization.png)

**When to use:** Parallelization proves effective when divided subtasks can run in parallel for speed, or when multiple perspectives improve confidence. For complex tasks, separate LLM calls handling individual considerations often outperform single-call approaches.

**Examples:**

*Sectioning:*
- Implementing guardrails where one instance processes queries while another screens for inappropriate content
- Automating evaluations where separate calls assess different performance aspects

*Voting:*
- Reviewing code for vulnerabilities across multiple prompts
- Evaluating content appropriateness with different aspects or vote thresholds

### Workflow: Orchestrator-Workers

A central LLM dynamically breaks down tasks, delegates them to worker LLMs, and synthesizes results.

![The orchestrator-workers workflow](05-orchestrator-workers.png)

**When to use:** This suits complex tasks with unpredictable subtasks. Unlike parallelization, it's flexible—subtasks are determined dynamically by the orchestrator based on specific inputs.

**Examples:**
- Coding products making complex multi-file changes
- Search tasks gathering and analyzing information from multiple sources

### Workflow: Evaluator-Optimizer

One LLM generates responses while another provides evaluation and feedback iteratively.

![The evaluator-optimizer workflow](06-evaluator-optimizer.png)

**When to use:** This workflow excels with clear evaluation criteria where iterative refinement provides measurable value. It suits situations where human feedback demonstrably improves LLM responses and where LLMs can provide useful feedback—similar to iterative human writing processes.

**Examples:**
- Literary translation where evaluators identify initially-missed nuances
- Complex search tasks requiring multiple rounds for comprehensive information gathering

### Agents

Agents emerge in production as LLMs mature in key capabilities: understanding complex inputs, reasoning and planning, reliable tool use, and error recovery. Agents start with human commands or discussion, then operate independently, potentially consulting humans for additional information. During execution, agents must obtain "ground truth" from their environment each step (tool results, code execution outputs) to assess progress. They can pause for feedback at checkpoints or blockers, with tasks typically terminating upon completion or after reaching stopping conditions.

While sophisticated, agent implementation remains straightforward—typically just LLMs using tools based on environmental feedback in loops. Tool design and documentation deserve careful attention. (See Appendix 2 for tool development best practices.)

![Autonomous agent](07-autonomous-agent.png)

**When to use:** Agents suit open-ended problems where required steps are unpredictable and fixed paths cannot be hardcoded. The LLM operates across many turns, requiring trust in its decision-making. Autonomy makes agents ideal for scaling trusted-environment tasks.

Autonomy entails higher costs and potential compounding errors. Extensive sandboxed testing with appropriate guardrails is recommended.

**Examples:**
- Coding agents resolving [SWE-bench tasks](https://www.anthropic.com/research/swe-bench-sonnet) involving multi-file edits
- ["Computer use" reference implementation](https://github.com/anthropics/anthropic-quickstarts/tree/main/computer-use-demo) where Claude uses computers to accomplish tasks

![High-level flow of a coding agent](08-coding-agent-flow.png)

## Combining and Customizing These Patterns

These building blocks are not prescriptive. They represent common patterns developers can shape and combine for different use cases. Success requires measuring performance and iterating implementations. Increase complexity "only when it demonstrably improves outcomes."

## Summary

LLM success involves building the *right* system for your needs, not the most sophisticated one. Start with simple prompts, optimize through comprehensive evaluation, and add multi-step agentic systems only when simpler approaches fall short.

When implementing agents, follow three core principles:

1. Maintain **simplicity** in your agent's design
2. Prioritize **transparency** by explicitly showing planning steps
3. Carefully craft your agent-computer interface (ACI) through thorough tool **documentation and testing**

Frameworks accelerate initial development, but reduce abstraction layers and build with basic components as you move to production. These principles enable agents that are powerful, reliable, maintainable, and trusted.

### Acknowledgements

Written by Erik Schluntz and Barry Zhang, drawing on experiences building agents at Anthropic and valuable customer insights.

## Appendix 1: Agents in Practice

Customer work has revealed two particularly promising agent applications demonstrating the practical value of discussed patterns. Both require conversation and action, have clear success criteria, enable feedback loops, and integrate meaningful human oversight.

### A. Customer Support

Customer support combines familiar chatbot interfaces with tool-enhanced capabilities. It naturally fits open-ended agents because:

- Support interactions follow conversation flows while requiring external information and actions
- Tools integrate customer data, order history, and knowledge base articles
- Refunds and ticket updates can be handled programmatically
- Success is clearly measurable through user-defined resolutions

Several companies demonstrate viability through usage-based pricing models charging only for successful resolutions, showing confidence in agent effectiveness.

### B. Coding Agents

Software development shows remarkable potential for LLM features, evolving from code completion toward autonomous problem-solving. Agents prove particularly effective because:

- Code solutions are verifiable through automated tests
- Agents iterate using test feedback
- The problem space is well-defined and structured
- Output quality is objectively measurable

In Anthropic's implementation, agents solve real GitHub issues in the [SWE-bench Verified](https://www.anthropic.com/research/swe-bench-sonnet) benchmark from pull request descriptions alone. Though automated testing verifies functionality, human review remains essential for ensuring solutions meet broader system requirements.

## Appendix 2: Prompt Engineering Your Tools

Tools are likely important to any agentic system. [Tools](https://www.anthropic.com/news/tool-use-ga) enable Claude to interact with external services and APIs by specifying their structure and definition. Claude includes a [tool use block](https://docs.anthropic.com/en/docs/build-with-claude/tool-use#example-api-response-with-a-tool-use-content-block) in API responses when invoking tools. Tool definitions deserve as much prompt engineering attention as overall prompts.

Multiple ways exist to specify identical actions. You might represent file edits as diffs or complete rewrites; return code in markdown or JSON. While cosmetically different, some formats are significantly harder for LLMs to produce. Diffs require pre-knowing line counts; JSON requires escaping newlines and quotes.

Suggestions for tool format decisions:

- Provide sufficient tokens for the model to "think" before getting stuck
- Keep formats close to naturally-occurring internet text
- Eliminate formatting "overhead" like maintaining accurate line counts or string-escaping

Invest as much effort in agent-computer interfaces (ACI) as in human-computer interfaces (HCI):

- Put yourself in the model's position. Is tool usage obvious from descriptions and parameters? A quality tool definition includes example usage, edge cases, input format requirements, and clear boundaries from other tools
- Improve parameter names and descriptions for clarity—write excellent docstrings as you would for junior developers. This matters especially with similar tools
- Test model tool usage: run many examples in the [workbench](https://console.anthropic.com/workbench) and iterate based on observed mistakes
- [Poka-yoke](https://en.wikipedia.org/wiki/Poka-yoke) tools by changing arguments to prevent mistakes

When building the [SWE-bench](https://www.anthropic.com/research/swe-bench-sonnet) agent, Anthropic spent more time optimizing tools than the overall prompt. They found models made mistakes with tools using relative filepaths after changing directories. Fixing this required always using absolute filepaths—after which the model performed flawlessly.
