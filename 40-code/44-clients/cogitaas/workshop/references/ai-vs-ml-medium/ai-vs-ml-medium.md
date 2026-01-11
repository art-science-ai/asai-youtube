# Traditional AI vs Supervised Machine Learning vs Deep Learning: How to Pick

**Source:** [The Modern Scientist (Medium)](https://medium.com/the-modern-scientist/traditional-ai-vs-supervised-machine-learning-vs-deep-learning-how-to-pick-f2017b0fd1d7)
**Published:** January 10, 2024
**Author:** Devansh

---

## Executive Summary

Thanks to the explosion in AI, we have seen an outbreak of new techniques to solve various problems. While a net positive, this leads to confusion within AI teams on how to best tackle problems. This article presents a framework for picking between traditional AI, Supervised Machine Learning, and Deep Learning when delivering solutions.

### Quick Comparison

- **Traditional AI**: The most secure, understandable, and performant. However, good implementations require defining rules, making it unfeasible for many use cases.
- **Supervised Machine Learning**: Middle ground between AI and Deep Learning. Good when you have domain insight but can't create concrete rules.
- **Deep Learning**: Opaque and costly, but necessary for very unstructured data where identifying rules is difficult or impossible.

**Important Note:** One is not better than the other, nor are they mutually exclusive. Modern AI pipelines use all three techniques together—traditional AI for data extraction and feature engineering, ML and DL for model development.

## The AI/ML/DL Landscape

### Key Definitions

**Traditional AI systems** are developed by analyzing the system and creating rules around it. These rules are explicitly programmed, significantly boosting transparency and computational efficiency (no expensive training). However, since rules must be defined beforehand, traditional AI is hampered in adaptation scope.

**Machine Learning** came to prominence because it matches information era requirements:
- Cheap computation + large data volumes make ML feasible
- Human expert time is expensive—identifying complex rules isn't cost-effective

**Deep Learning** automates the feature extraction process, eliminating manual human intervention. However, DL requires more data points than traditional ML to improve accuracy.

## Factor 1: Availability of Data

Without access to high-quality, high-volume data, ML and DL are generally infeasible. When data is scarce, traditional AI is your only effective option—assuming you have domain expertise to create rules.

![Data Availability Decision Framework](01-data-availability-framework.png)

### The Low-Quality Data Dilemma

If you have complex systems where you can't create explicit rules, **consider giving up and finding better ways to spend resources**. Not every problem should be solved with automated decision-making.

However, if you have **high volumes of low-quality data**, ML can work if your situation meets these three properties:

1. **Domain experts available** to ground your ML work with context
2. **Enough data** to test assumptions about imputation and structure
3. **Time and flexibility** to run experiments without fast-release constraints

This should be treated as a stopgap. Always ramp up data-gathering and ingesting capabilities—that's the only sustainable path forward.

## Factor 2: Understanding of Domain

To create effective rules, you need deep system understanding. Good domain knowledge makes traditional AI perform amazingly.

### The NetHack Challenge Example

The NetHack Challenge compared symbolic AI vs reinforcement learning agents. Results showed:

> The margin of victory was significant, with the top symbolic agent beating the top neural agent by a factor of almost 3 in the median score... we might see almost an order of magnitude improvement in the median score between the best symbolic and neural agents.

Key findings:
- **Symbolic agents excelled at**: Defining strategy-like subroutines, keeping full game state in memory, incorporating external knowledge
- **Neural agents struggled with**: Hierarchical RL (open problem), discovering strategy patterns in large action spaces with sparse rewards, maintaining information in memory without direct reward association

**Takeaway:** If you can create good rules, traditional AI works wonders.

### ML's Role in Low Domain Understanding

Without good domain understanding, traditional AI is infeasible. This is ML's strength—it significantly cuts down on expert time by converting domain insights into features that guide the model without explicit relationships.

## Practical Decision Framework

### When to Use Traditional AI
- High domain understanding exists
- Rules are explicitly definable
- Need interpretability and transparency
- Have limited data
- Require computational efficiency

### When to Use Supervised Machine Learning
- Moderate domain understanding
- Can identify features but not rules
- Have moderate amounts of quality data
- Can afford training time and computational resources
- Need better than rule-based performance

### When to Use Deep Learning
- Very unstructured data (images, raw text, audio)
- Difficult/impossible to extract meaningful features manually
- Large volumes of quality data available
- Have significant computational resources
- Can tolerate some "black box" nature of results

## Key Insights

**Multiple techniques coexist:** Even modern ML pipelines use traditional AI (regex, probability distributions, clustering) for data extraction, feature engineering, and pipeline monitoring to enable effective DL deployment.

**Cost-benefit analysis is critical:** High-quality data availability doesn't mean you should use ML or DL. ROI must align with product and engineering team baselines and cutoffs.

**Domain expertise matters:** The combination of domain experts and ML engineers often outperforms pure technical approaches. Expert guidance prevents wasted exploration and speeds discovery.
