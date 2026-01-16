---
marp: true
theme: rose-pine-moon
# rose-pine-moon | cogitas | gaia
---

# The Art and Science of AI - for Cogitaas
by Nikhil Maddirala
11 December, 2025

---

## Agenda
1. The **Science** of how AI works
2. The **Art** of using AI
3. AI Agents for Business (Cogitaas Perspective)

<!--
Full Presentation Outline:

1. The Science of how AI works
    1.1 Ancient dreams: Myths, magic, machines
    1.2 The birth of AI: Dartmouth 1956
    1.3 Rule-based era (1950s-2000s): GOFAI, Expert Systems, Logic
    1.4 Learning machines (1990s-2010s): ML, Statistical approaches
    1.5 Deep learning revolution (2010s): Neural networks, GPUs
    1.6 Generative era (2020s): Transformers, LLMs, Agents

2. The Art of using AI
    2.1 Prompt engineering for LLMs
    2.2 Augmented LLMs: system prompts, retrieval, tools
    2.3 AI workflows: prompt chaining, sequential, parallel
    2.4 AI agents: autonomous orchestration of workflows

3. AI Agents for Business (Cogitaas Perspective)
    3.1 AI Agents' Role and Impact in Business
    3.2 Implementing AI Agents in Business
    3.3 AI Agent Applications for Cogitaas

-->

---
## About me

* **15 years in AI/ML:** Lead Product Manager at Meta and Adobe building AI/ML products for billions of users; Fortune 500 AI consultant at Deloitte
* **Academic foundation:** Degrees in computer science, business, logic, and philosophy from ivy league universities
* **AI educator and mentor:** Teaching the science of how AI works and the art of using AI effectively @ Art and Science of AI

<!--
- Career progression: Started with MSc Logic thesis (2012) on rule-based vs computational linguistics → scaled AI products → strategic consulting
- Interdisciplinary education enables unique perspective bridging technical depth with business strategy and philosophical foundations
- Educator role: Help people build their own AI products and solutions, not just understand theory
- Personal details create connection and show well-rounded personality beyond just professional credentials
-->

---

## 1. The Science of how AI works

- 1.1 Ancient dreams: Myths, magic, machines
- 1.2 The birth of AI: Dartmouth 1956
- 1.3 Rule-based era (1950s-2000s): GOFAI, Expert Systems, Logic
- 1.4 Learning machines (1990s-2010s): ML, Statistical approaches
- 1.5 Deep learning revolution (2010s): Neural networks, GPUs
- 1.6 Generative era (2020s): Transformers, LLMs, Agents

<!--
This section traces AI's evolution from ancient myths to modern generative systems
- Historical arc: Dreams → Birth → Rules → Learning → Deep Learning → Generation
- Each era builds on previous foundations while introducing paradigm shifts
- Focus on what changed, why it mattered, and how it led to today's AI capabilities
-->

---

### 1.1 Ancient dreams: myths, magic, machines
![bg left:45%](mechanical-turk.jpg)

* **Myths & legends:** Ancient dreams of artificial life: Greek *Talos*, Jewish *Golem*, and Indian *Yantras* guarding treasures
* **Engineering foundations:** From ancient calculating devices to modern computers laid the foundations for AI
* **The Turing test precursor:** Mechanical Turk foreshadowed modern questions about machine intelligence and human deception

<!--
- Universal stories: Talos protected Crete, the Golem defended Prague. Indian Yantras guarded Buddha's relics
- From ancient abacuses to Babbage's analytical engine, mechanical computation evolved over millennia, laying the foundation for Turing's universal machines
- The Mechanical Turk raised fundamental questions about machine intelligence that echo in today's AI debates
-->

---

### 1.2 The birth of AI: Dartmouth 1956
![bg right:45% 115%](dartmouth-1956-conference.jpg)

* *We propose that a 2-month, 10-man study of artificial intelligence be carried out during the summer of 1956 at Dartmouth College*
* *An attempt will be made to find how to make machines use language, form abstractions and concepts, solve kinds of problems now reserved for humans, and improve themselves.*
* *We think a significant advance can be made ... if a carefully selected group of scientists work on it together for a summer.*

<!--

- The 1956 Dartmouth workshop was the moment AI became an organized field
- Organized by the founding fathers: Claude Shannon, John McCarthy, Nathaniel Rochester, and Marvin Minsky
- They believed machines could simulate human intelligence in just one summer
- While optimistic about the timeline, this meeting established AI as an academic discipline
- This quote is from the original funding proposal that started it all
-->

---

![bg fit](ai-rules-ml.webp)

<!--

- This diagram shows the relationship between AI, ML, and rule-based approaches
- Machine learning is a subset of AI that learns from data
- Traditional rule-based systems use explicit programming
- Both approaches have their place depending on the problem
-->

---

### 1.3 Rule-based era (1950s-2000s): GOFAI, Expert Systems, Logic

![bg left fit](email-spam.png)

* Symbolic AI / "Good Old-Fashioned AI" (GOFAI)
* **Example:** Spam filter with explicit rules: "If email contains 'Nigerian prince', then mark as spam"
* Other examples: Deep Blue chess computer, video game AI
* **Pro:** Interpretable, logical, predictable
* **Con:** Brittle—can't handle ambiguity or "common sense"

<!--

- Rule-based AI: Programmers manually write every rule the system follows
- Spam example: Write hundreds of rules for spam keywords, but spammers adapt by changing wording
- Deep Blue (1997): Beat chess champion Kasparov using brute-force search of millions of moves, not understanding
- The brittleness problem: A single unexpected situation breaks the system because you can't program rules for everything
- Video game AI: Enemies follow scripted behavior patterns—predictable but never truly adaptive
-->

---

### 1.4 Learning machines (1990s-2010s): ML, Statistical approaches

![bg right fit](ml-vs-classical.png)

* Shift from "programming rules" to "learning patterns"
* **Example:** House price prediction learns from 10,000 past sales (bedrooms, location, size → price); Gmail spam filters, Netflix recommendations, fraud detection
* **Requirement:** Feature engineering (telling the AI what to look for)

<!--

- The paradigm shift: instead of programming rules, we train models on data
- House price example: Instead of programming "if 3 bedrooms then $X", the model learns the price pattern from thousands of real sales
- You still had to tell it what to look for: "use bedrooms, square footage, location" (feature engineering)
- Examples: Gmail learns from millions of spam examples. Netflix learns your preferences from viewing patterns
-->

---

### 1.5 Deep learning revolution (2010s): Neural networks, GPUs
![bg left fit](deep-learning.png)

* Neural Networks with many layers (Deep Neural Networks)
* **Example:** Handwritten digit recognition learns patterns directly from pixel images—no feature engineering!
* **Key Drivers:** Big Data + GPUs enabled training on millions of examples
* AlphaGo defeats world champion, FaceID, Siri voice recognition

<!--

- MNIST example: Show image of handwritten digits (0-9). Deep learning automatically learns "what makes a 7 look like a 7" from raw pixels
- Traditional ML required you to tell it "look for loops, straight lines, curves." Deep learning discovers these features on its own
- 2012 watershed moment: AlexNet crushed ImageNet competition, proving deep learning superiority
- AlphaGo's 2016 victory over Lee Sedol showed AI mastering intuition, not just calculation
- These applications are now in everyone's pocket (FaceID, Siri) - impossible with rule-based or traditional ML
-->

---

### 1.6 Generative era (2020s): Transformers, LLMs, Agents

![bg right fit](01-rlhf-process.png)

* **Large Language Models (LLMs):** Predict next word by learning from billions of web pages
* **Breakthrough:** 2017 Transformer architecture made this possible ("Attention is All You Need")
* **Passing the Turing test:** For the first time, AI can have natural human conversations!

<!--

- LLMs like GPT, Claude, and Gemini learn language patterns from massive internet data (books, websites, code)
- Unlike previous AI, they can write coherent essays, explain complex topics, debug code, and translate with context awareness
- The Transformer "attention mechanism" lets AI understand which words relate to each other across long passages
- ChatGPT moment (Nov 2022): First time mainstream users could have natural conversations with AI—passed Turing test
- Latest frontier: AI agents can now plan multi-step solutions, use tools, and work autonomously toward goals
- Real impact: GitHub Copilot shows 30-50% productivity gains for developers
-->

---

## 2. The Art of using AI
* 2.1 Research Assistant: Our Complete Example
* 2.2 Augmented LLMs: Enhanced Research Assistant
* 2.3 AI workflows: Orchestrated Research Assistant
* 2.4 AI agents: Autonomous Research Intelligence

---

### 2.1 Research Assistant: Our Complete Example

* Task: "Research the top AI companies"
* This example will show how AI evolves from simple prompts to autonomous agents to solve this business intelligence task.
* Limitations of vanilla LLMs: demo of `ollama` with `Google Gemma` 

<!--
- Live demo of ollama and limitations of lack of context, etc.
-->

---

### 2.2 Augmented LLMs: Enhanced Research Assistant

![bg right:45% 175%](01-augmented-llm.png)

* **Retrieval:** Access to market reports, company filings, funding databases for AI companies
* **Tools:** Financial data APIs, news search, earnings report analysis for market intelligence
* **Memory:** System prompt maintains "technology analyst specializing in AI market intelligence" role

<!--

- Financial APIs access real-time stock data, market cap, revenue figures
- News search tracks company announcements, product launches, strategic moves
- Earnings analysis extracts insights from quarterly reports and investor calls
- System prompt ensures consistent technology analyst perspective
- Based on 'Building Effective Agents' by Anthropic Engineering (Dec 2024)
-->

---

### 2.3 AI workflows: Orchestrated Research Assistant

* **Orchestrator-Workers (2.3a):** Central LLM breaks down research tasks, delegates to specialized workers, synthesizes results
* **Parallelization (2.3b):** Multiple workers research AI companies, financials, products, partnerships simultaneously for speed
* **Evaluator-Optimizer (2.3c):** Sequential cycle checks research quality, fills gaps, refines analysis for accuracy
* **Key insight:** Workflows provide predictable, efficient research through predefined orchestration patterns

<!--

- Orchestrator assigns parallel research tasks to specialized workers
- Each worker focuses on their domain expertise (financials, products, partnerships)
- Parallel execution speeds up AI market research significantly vs sequential approach
- Synthesis step ensures all findings are integrated into coherent market analysis
- Based on 'Building Effective Agents' by Anthropic Engineering (Dec 2024)
-->

---

![bg fit](05-orchestrator-workers.png)

---

### 2.3a AI workflows: Orchestrator-Workers for AI market analysis

* **Orchestrator assigns parallel research tasks:**
  * Worker 1: Research major AI companies (OpenAI, Anthropic, Google)
  * Worker 2: Analyze financial performance and market valuation
  * Worker 3: Compare product portfolios and technological capabilities
  * Worker 4: Track funding rounds and strategic partnerships
* **Synthesis:** Combines findings into comprehensive AI market analysis

---

![bg fit](04-parallelization.png)

---

### 2.3b AI workflows: Parallel analysis for comprehensive AI market insights

* **Parallel execution speeds research significantly:**
  * Worker 1: Researches AI companies simultaneously
  * Worker 2: Analyzes financial data in parallel
  * Worker 3: Evaluates product capabilities concurrently
  * Worker 4: Tracks partnerships at same time
* **Benefit:** 4x faster than sequential research for comprehensive AI market coverage

---

![bg fit](06-evaluator-optimizer.png)

---

### 2.3c AI workflows: Sequential verification and refinement for AI intelligence

* **Evaluator-Optimizer cycle for quality assurance:**
  * **Evaluator:** Checks AI market research completeness, accuracy, bias
  * **Optimizer:** Fills data gaps, refines analysis, improves insights
  * **Iteration:** Continues until research meets quality standards
* **Outcome:** High-quality, verified AI market intelligence for strategic decisions


---

![bg fit](07-autonomous-agent.png)

---

### 2.4 AI agents: Autonomous Research Intelligence

* **Autonomous agent:** Research assistant decides its own investigation strategy
* **Agent capabilities:** Plans research approach, discovers emerging trends, adapts strategy
* **Full research cycle:**
  * Identifies emerging AI companies beyond the major players
  * Follows strategic data trails (acquisitions, talent movements, regulatory changes)
  * Detects market shifts and technology trends before they become obvious
* Research assistant now can: Conduct sophisticated, adaptive AI market intelligence

<!--

- Agent discovers emerging AI companies through research (e.g., specialized startups)
- Follows data trails like venture capital funding, talent migration, patent filings
- Adapts research strategy based on initial market findings
- Goes beyond basic research to provide predictive market insights
- Based on 'Building Effective Agents' by Anthropic Engineering (Dec 2024)
-->

---



![bg fit](open-deep-research-agent.png)


<!--
- First explain chatgpt deep reserach
- Then explain that this is an open source version of the same
-->
---

## 3. AI Agents for Business (Cogitaas Perspective)
* 3.1 AI Agents' Role and Impact in Business
* 3.2 Implementing AI Agents in Business
* 3.3 AI Agent Applications for Cogitaas

<!--
Mapping slides to Cogitaas QA questions:

3.1 AI Agents' Role and Impact in Business: Q3, Q8 (myths, what AI agents are not, hype) + parts of Q1/Q2 (corporate applicability)
3.2 Implementing AI Agents in Business: Q5, Q7, Q8, Q9 (financial benefits, implementation approach, ROI prioritization)
3.3 AI Agent Applications for Cogitaas: Q4, Q6 (concrete use cases - EDA, presentations, Q&A agents, pipeline automation)
-->

---

### 3.1 AI Agents' Role and Impact in Business

* **AI Agents' Role in Business:** Automate repetitive work, enhance productivity, enable focus on higher impact tasks
* **Business Impact:** Improve quality and quantity of deliverables; enable new AI-powered solutions (e.g. AI customer service chatbot)
* **Myth Debunking:** Not plug-and-play, requires iterative development to build useful workflows and agents tailored to your business context

<!--

- AI agents are not overhyped for long-term impact but overestimated in short-term (1-year) gains
- Myths: Fully autonomous, replaces all jobs; debunked by need for human oversight and edge cases
- Path: Iterative development with prompt tuning, multi-agent systems; difficulties include hallucinations
- Not all analytics should be sold as Gen AI agents; Gen AI suits creative tasks, not all predictive work
- AI agents enhance productivity by automating repetitive work, allowing focus on higher impact tasks
- Key difference from basic AI: Agents can autonomously orchestrate workflows, make decisions, and use tools - not just respond to prompts
-->

---

### 3.2 Implementing AI Agents in Business

* **Identify Opportunities:** Map repetitive workflows consuming significant time (reporting, data cleaning, customer queries)
* **Prioritize by ROI:** Compare current effort vs. AI agent implementation effort - target high-impact, low-complexity workflows first
* **Start Small, Iterate:** Build proof-of-concept for one workflow, measure results, refine, then scale to similar tasks
* **Timeline Reality:** Expect 3-6 months for initial wins, 1-2 years for deep integration - not overnight transformation

<!--

- Opportunity identification: Audit team activities - what tasks are done weekly/monthly that follow patterns? Examples: monthly reports, data preprocessing, responding to common client questions
- Look for "copy-paste" workflows, template-based work, or tasks where people say "I do this same thing every week"
- ROI calculation framework: (Hours saved per month × hourly cost) vs. (Development time + maintenance cost)
- High-impact examples: A report taking 8 hours/month with 2 hours to automate = 48:1 annual ROI
- Low-hanging fruit: Workflows with clear inputs/outputs, minimal edge cases, structured data
- Avoid initially: Highly creative work, workflows requiring deep judgment, tasks with frequent exceptions
- POC approach: Pick one specific use case (e.g., "automate weekly sales summary report"), build minimal solution, test for 1 month, measure time savings
- Iteration: If POC works, expand to similar workflows (monthly reports, quarterly reports), then tackle more complex cases
- Timeline reality: First automated workflow in month 1-2, refined system by month 3-6, organization-wide adoption takes 1-2 years as culture shifts
- Set expectations: This is iterative transformation, not flip-a-switch automation
-->

---

### 3.3 AI Agent Applications for Cogitaas

* **Data Pipeline Automation:** Streamlines ETL processes, data cleaning, and routine reporting tasks
* **Exploratory Data Analysis:** AI agents assist in data profiling, anomaly detection, and pattern discovery across client datasets
* **Presentation Generation:** Automates slide creation, visualizations, and executive summary writing from analytical findings
* **Client Question Answering:** AI agents retrieve insights from historical reports and datasets to answer ad-hoc client queries

<!--

- EDA: AI can automatically profile new datasets, flag data quality issues, suggest relevant visualizations, and identify initial trends before human analysis
- Specific tools: Claude can analyze CSV/Excel files, generate Python/R code for exploration, create preliminary charts
- Presentation: AI generates first drafts of client decks including executive summaries, charts, and key insights from analytical work
- Example workflow: Feed AI your analysis results → it creates PowerPoint slides with appropriate visualizations → analyst refines messaging
- Q&A Agent: Build a RAG system over past client deliverables so new analysts can quickly find "How did we approach pricing for similar CPG client?"
- Reduces onboarding time and leverages institutional knowledge
- Pipeline automation: AI writes data transformation scripts, automates routine monthly reports, handles repetitive data cleaning
- Frees analysts to focus on interpretation and strategy rather than data wrangling
- Key insight: These are augmentation use cases, not replacement - AI handles repetitive/mechanical work, humans drive strategy and client relationships
-->


---

## Thank you!
Any questions?

---

## References

- [Art and Science of AI Podcast](https://artscienceai.substack.com/)
- [Building Effective AI Agents \ Anthropic](https://www.anthropic.com/engineering/building-effective-agents)
- [langchain-ai/open_deep_research](https://github.com/langchain-ai/open_deep_research)
- [Artificial Intelligence: Objective or Tool in the 21st-Century Higher Education Strategy and Leadership? | MDPI](https://www.mdpi.com/2227-7102/15/6/774)
- [Traditional AI vs Supervised Machine Learning vs Deep Learning- How to Pick | by Devansh | The Modern Scientist | Medium](https://medium.com/the-modern-scientist/traditional-ai-vs-supervised-machine-learning-vs-deep-learning-how-to-pick-f2017b0fd1d7)
- [What is RLHF?](https://www.analyticsvidhya.com/blog/2023/05/reinforcement-learning-from-human-feedback/)
- [How spam detection taught us better tech support | Google Cloud Blog](https://cloud.google.com/blog/topics/developers-practitioners/how-spam-detection-taught-us-better-tech-support)
