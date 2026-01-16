# Nikhil's AI consulting terms of service template

---

## 1 Overview of engagement

As part of this engagement, Nikhil will design, develop, and operate custom AI agents tailored to the business needs of [ Client Name ] (hereafter "the Client").

---

## 2 How AI agents work

An AI agent includes two major components:

### 2.1 Foundation models

The reasoning engine — generally closed-source, cloud-hosted, GPU-backed systems (e.g., Claude 4.5, Gemini 3, GPT-5.1) from providers like Anthropic, Google, and OpenAI. These models:

- Perform text interpretation, planning, and reasoning
- Handle large-context understanding
- Provide structured outputs for downstream code

### 2.2 Custom AI agent code

Agent logic built by Nikhil that:

- Designs workflows & decision trees
- Integrates client data sources
- Handles tool-calling, automation, and routing
- Ensures reproducible behavior and predictable outputs

The combined system = LLM (cloud) + Agent Code (custom).

### 2.3 Why cloud providers are used

- State-of-the-art models are typically closed-source and require specialized GPU clusters
- Open-source models exist but are usually too large for traditional local hardware

---

## 3 Data processing and infrastructure

### 3.1 Where computation happens

- LLM computation: Via secure APIs on third-party cloud providers
- Agent code execution: On Nikhil's local development environment (laptop/desktop)

### 3.2 Cloud provider data-use policy

- Most providers allow disabling model-training usage, which means the provider will not use customer data for any model training
- Nikhil will always ensure that client data is set to not be used for model training

### 3.3 Nikhil's internal data-handling policy

- Client data is used only for delivering services
- No long-term storage except as needed for active development unless otherwise agreed
- Client may request deletion of data at any time

### 3.4 Client specific data processing requirements

- This engagement does not include any other client-specific data processing requirements.


---

## 4 Ownership of assets and intellectual property

- All data, documents, specifications, and assets provided by the Client will be owned by the Client.
- All custom AI agent code, reusable frameworks, prompts, workflows, and tooling created or pre-existing will be owned by Nikhil
- Client receives a perpetual, non-exclusive internal-use license to the delivered agents and their outputs
- AI-generated outputs: Final deliverables created through the AI agent as specified in the SOW are owned by the client
- AI models and foundation systems remain the property of their respective providers

---

## 5 Fees, payment, and duration

- This engagement does not require any fees or payment

---

## 6 Confidentiality, liability and disclaimers

### 6.1 Confidentiality

Both parties will treat shared information as confidential and use it solely for the engagement. Confidentiality survives the completion of the project.

### 6.2 Liability and contractor status

- Nikhil acts as an independent contractor, not an employee
- Services provided "as-is" with no warranties of specific business outcomes
- No liability assumed for AI model decisions, third-party platform behaviors, or client actions
- Total liability: Limited to fees paid in the preceding 12 months

### 6.3 Disclaimers

- AI-generated outputs may contain inaccuracies, errors, or "hallucinations"
- AI services are provided "as-is" without guarantees of accuracy or reliability
- Model behavior may change over time as providers update their systems
- AI outputs are tools to assist human decision-making, not replacements for professional judgment

---