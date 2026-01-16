## Problem: Performance drops as context grows 

- Context Poisoning: Ex: Gemini playing Pokemon hallucinated an item + tried to re-use it
- Context Distraction: Ex: Gemini favored repeated actions over new plans as context > 100k tok
- Context Confusion: Ex: Models perform worse with more tools, esp if tools are similar
- Context Clash: Ex: Models perform worse if back-to-back tool calls contradict each other

## Solution: Context engineering
*Context engineering is the delicate art and science of filling the context window with just the right information for the next step.* - Andrej Karpathy


### Offload context
- Use file system for notes (see: [Drew’s post](https://www.dbreunig.com/2025/06/26/how-to-fix-your-context.html), [Anthropic multi-agent](https://www.anthropic.com/engineering/built-multi-agent-research-system)).
- Use file system (e.g., [todo.md](http://todo.md)) to plan/track progress (see: [Manus](https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus)).
- Use file system read/write tok-heavy context (see: [Manus](https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus)).
- Use files for long-term memories (see: Ambient Agents [course](https://academy.langchain.com/courses/ambient-agents/)/[repo](https://github.com/langchain-ai/agents-from-scratch)).

### 
**

Reduce context

  

Summarize agent message history (see: [Drew’s post](https://www.dbreunig.com/2025/06/26/how-to-fix-your-context.html), Claude Code).

Prune irrelevant parts of message history (see: [Drew’s post](https://www.dbreunig.com/2025/06/26/how-to-fix-your-context.html)).

Summarize / prune tool call outputs (see: [open-deep-research](https://github.com/langchain-ai/open_deep_research)).

Summarize / prune at agent-agent handoffs (see: [Cognition](https://cognition.ai/blog/dont-build-multi-agents#a-theory-of-building-long-running-agents)).

But, care careful of information loss (see: [Cognition](https://cognition.ai/blog/dont-build-multi-agents#a-theory-of-building-long-running-agents) and [Manus](https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus))!

**

**

Retrieve context

  

Mix of retrieval methods + re-ranking (see: Varun’s [take](https://x.com/_mohansolo/status/1899630246862966837?ref=blog.langchain.com) from Windsurf).

Systems to assemble retrievals into prompts (see: [Preempt](https://lexfridman.com/cursor-team-transcript) in Cursor).

Retrieve relevant tools based upon tool descriptions (see: [Drew’s post](https://www.dbreunig.com/2025/06/26/how-to-fix-your-context.html)).

**

**

Isolate context

  

Split context across multi-agents (see: [Drew’s post](https://www.dbreunig.com/2025/06/26/how-to-fix-your-context.html), [Anthropic](https://www.anthropic.com/engineering/built-multi-agent-research-system)).

But, be careful (see: [Cognition](https://cognition.ai/blog/dont-build-multi-agents#a-theory-of-building-long-running-agents)/[Walden Yan](https://x.com/jxnlco/status/1945490018127987092))! 

Multi-agents make conflicting decisions (see: [Cognition](https://cognition.ai/blog/dont-build-multi-agents#a-theory-of-building-long-running-agents)/[Walden Yan](https://x.com/jxnlco/status/1945490018127987092)).

Sub-agents lower risk if avoid decisions (see: [open-deep-research](https://github.com/langchain-ai/open_deep_research)).

**

**

Cache Context

  

Cached input tokens for Claude-sonnet 10x cheaper!

Cache agent instructions, tool descriptions to prefix.

Add mutable context / recent observations to suffix.

**