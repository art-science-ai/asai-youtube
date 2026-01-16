# Master service agreement

**This agreement** is between:

**Client:** [Client name]
**Consultant:** [Your business name]

---

## 1. Overview of engagement

As part of this engagement, the Consultant will design, develop, and operate custom AI agents tailored to the business needs of the Client.

---

## 2. How AI agents work

An AI agent includes two major components:

### 2.1 Foundation models

The reasoning engine — generally closed-source, cloud-hosted, GPU-backed systems (e.g., Claude, Gemini, GPT) from providers like Anthropic, Google, and OpenAI. These models:

- Perform text interpretation, planning, and reasoning
- Handle large-context understanding
- Provide structured outputs for downstream code

### 2.2 Custom AI agent code

Agent logic built by the Consultant that:

- Designs workflows and decision trees
- Integrates client data sources
- Handles tool-calling, automation, and routing
- Ensures reproducible behavior and predictable outputs

The combined system = LLM (cloud) + Agent Code (custom).

### 2.3 Why cloud providers are used

- State-of-the-art models are typically closed-source and require specialized GPU clusters
- Open-source models exist but are usually too large for traditional local hardware

---

## 3. Data processing and infrastructure

### 3.1 Where computation happens

- **LLM computation:** Via secure APIs on third-party cloud providers
- **Agent code execution:** On the Consultant's local development environment (laptop/desktop/server) during development. After development, this typically transitions to the Client's environment.

### 3.2 Cloud provider data-use policy

- Most providers allow disabling model-training usage, which means the provider will not use customer data for any model training
- The Consultant will always ensure that client data is configured to not be used for model training
- For more information, see [Anthropic's policy](https://privacy.claude.com/en/articles/10023580-is-my-data-used-for-model-training) and [OpenAI's policy](https://help.openai.com/en/articles/5722486-how-your-data-is-used-to-improve-model-performance)

### 3.3 Consultant's internal data-handling policy

- Client data is used only for delivering services
- No long-term storage except as needed for active development unless otherwise agreed
- Client may request deletion of data at any time

### 3.4 Client-specific data processing requirements

- [Specify any client-specific data processing requirements, or state "None"]

---

## 4. Ownership of assets and intellectual property

- All data, documents, specifications, and assets provided by the Client will be owned by the Client
- All custom AI agent code, reusable frameworks, prompts, workflows, and tooling (pre-existing or created by the Consultant) will be owned by the Consultant
- The Client receives a perpetual, non-exclusive internal-use license to the delivered agents and their outputs
- AI-generated outputs: Final deliverables created through the AI agent as specified in the SOW are owned by the Client
- AI models and foundation systems remain the property of their respective third-party providers

---

## 5. Fees and expenses

### 5.1 Fees

Client agrees to pay the fees set forth in each statement of work ("SOW"). All fees are in US Dollars.

### 5.2 Invoicing and payment

Consultant will invoice Client in accordance with the payment schedule in each SOW. Payment is due within Net-30 days of the invoice date.

### 5.3 Late fees

Overdue payments will accrue interest at the rate of 1.5% per month (or the maximum rate permitted by law, whichever is lower).

### 5.4 Expenses

- Third-party AI service costs (e.g., OpenAI, Anthropic API usage) are [included in / excluded from] the fees
- Cloud infrastructure costs are [included in / excluded from] the fees
- Any other expenses will be specified in the SOW

---

## 6. Confidentiality and liability

### 6.1 Confidentiality

Both parties will treat shared information as confidential and use it solely for the engagement. If the Client requires Consultant to sign a separate NDA, the parties agree that such NDA will govern confidentiality only. All other business terms (including IP ownership, fees, liability, etc.) remain governed by this agreement.

Confidentiality obligations do not apply to information that:

- Is or becomes public without breach of this agreement
- Was already known to the recipient before disclosure
- Is independently developed
- Is required to be disclosed by law

### 6.2 Liability and disclaimers

**Client acknowledges and agrees that:**

- Services are provided "as-is" with no warranties of specific business outcomes
- AI-generated outputs may contain inaccuracies, errors, or "hallucinations"
- AI model performance may vary over time as models are updated by their providers
- AI systems cannot guarantee 100% uptime or reliability
- External API providers may change pricing, rate limits, or terms of service
- AI outputs are tools to assist human decision-making, not replacements for professional judgment

**Limitation of liability:**

- Consultant's total liability under this agreement will not exceed the total fees paid by Client in the twelve (12) months preceding the claim
- Consultant is not liable for lost profits, data, or business opportunities
- Consultant is not liable for consequential, indirect, or punitive damages
- Consultant is not liable for damages arising from Client's misuse of AI systems
- Consultant is not liable for damages caused by third-party AI service providers or model updates

---

## 7. Term and termination

### 7.1 Term

This agreement commences on the effective date and continues until terminated by either party.

### 7.2 Termination for convenience

Either party may terminate this agreement with [30] days written notice.

### 7.3 Termination for cause

Either party may terminate this agreement immediately if the other party breaches a material term and fails to cure within [15] days.

### 7.4 Effect of termination

Upon termination, Client will pay for all services performed and expenses incurred. Sections 4 (IP), 6 (Confidentiality and liability), and 8.2 (Independent contractor) survive termination.

---

## 8. Miscellaneous

### 8.1 Independent contractor status

The Consultant acts as an independent contractor, not an employee. This agreement does not create a partnership, joint venture, or employment relationship.

### 8.2 Assignment

Neither party may assign this agreement without the other party's prior written consent, except to a successor in merger or acquisition.

### 8.3 Governing law

This agreement is governed by the laws of [State/Jurisdiction]. Any disputes will be resolved in the courts of [City, State].

### 8.4 Entire agreement

This agreement, including the SOWs, constitutes the entire agreement between the parties and supersedes all prior discussions.

---

**IN WITNESS WHEREOF**, the parties have executed this agreement as of the date first written below.

**Client:** [Client signature]

**Name:** [Printed name]
**Title:** [Title]
**Date:** [Date]

**Consultant:** [Consultant signature]

**Name:** [Printed name]
**Title:** [Title]
**Date:** [Date]
