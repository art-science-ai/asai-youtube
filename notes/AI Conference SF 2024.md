# Misc
Analyze these notes I took from the AI Conference SF 2024. Extract the key overall themes, and provide a bullet point list of key points under each theme. For each key point under the themes, please also refer to examples of the theme from the individual sessions.

# Article
- Infrastructure and hardware challenges: Enhancing AI Efficiency through Neuroscience and Hardware Innovations
- The Rise of Open-Source AI and Democratization of AI
	- Llama Models and Open Ecosystem
	- Challenges and Opportunities in Open-Source AI
- The Importance of Knowledge Graphs for Retrieval-Augmented Generation (RAG)
- Agentic AI Systems and Their Applications
- Ethical, Legal, and Regulatory considerations in AI 
- Cool tidbits
	- Digital Twin by Nokia




# Networking notes
- sherif Adobe creative cloud ai for brand creation  
- yahoo eng working on knowledge graphs - francesco  
- German marketing firm buying ads  
- Mission driven ai for suicide prevention - David Thorne  
- Salad folks for distributed ai inference on home gpus -  
- conference speakers - review all and shortlist  
- Locofy ceo  
- Legal speaker  
- Nokia speaker  
- [x] AI alliance Dave - get involved through meta

# Session notes
## Llama, Open Intelligence for All
### About
Talk type: keynote

Speakers 
- Joe Spisak, Product Director, Generative AI, Meta

Description
Generative AI has brought about a new wave of innovation unlike we’ve ever seen before and with hundreds of millions of downloads of Llama models to date, the startup ecosystem building on Llama and this new wave of innovation fueled by open models. But where does all of this go? Joe Spisak, Product Director at Meta talks about how open generative AI has had incredible impact and how you can leverage the Llama ecosystem to build cutting edge generative AI agents at scale including hands-on, engaging content that gives attendees an understanding of the latest Llama models, how to access and use them, develop using system level safety components and ultimately what the future may look like.

### Notes
Llama use cases  
- llm  
- Image generation  
- Creator tools ai studio  
  
Age of exponential ai growth chart  
  
AI evolution : classic ai > Gen ai > AGI  
  
AI landscape chart - sequoia  
- platforms, consumer, prosumer, enterprise  
  
10x growth of llama - token volume  
- evolution of llama 1 to 3.1 from Feb 23 to Jul 24  
- In addition to core models, other stuff below  
- Core models: pretrained and instruction tuned  
- System guardrails : model and inference guardrails, cybersecurity evaluation  
  
Upgraded smaller models  
- high context length, tool use, multi lingual  
- Large model used as teacher for distillation and synthetic data generation  
- Fine tuning of large model  
- Terms changed: outputs can now be used to build other models. Previously license restricted this  
  
Training at unprecedented scale  
- >15T tokens  
- 16k H100 GPU s  
  
State of the art performance  
  
Extensive human evaluation  
- very expensive  
  
Partner ecosystem  
- requires distributed inference. Not easy or cheap.  
  
Get hands on  
  
Llama agentic apps  
- recipes, tools and APIs open source on github  
  
Llama stack  
- standard tools to work with llama for RAG, function calling etc memory  
  
Meta ai available across consumer surfaces  
- chat, search, web, ray ban, quest

## AI-Powered Startups: How Microsoft Azure is Fueling the Next Wave of Innovation
### About
AI-Powered Startups: How Microsoft Azure is Fueling the Next Wave of Innovation

 Tue Sep 10, 2024

 9:30 AM - 9:50 AM

 City View

 436 Attending

 6 Questions

 Remove from AgendaLike sessionTake notes

Speaker

![Annie Pearl's profile](blob:https://whova.com/e41f7478-c18f-4fdf-8907-0ec9118df0e9)

Annie Pearl

Corporate Vice President, Azure Experiences and Ecosystems

Microsoft

Send MessageView Profile

Join Annie Pearl for an exclusive insight into how Microsoft is reshaping startup ecosystems with cutting-edge AI. In this session, she will explore key patterns in AI adoption among startups leveraging Azure services and reveal how Microsoft is empowering the next wave of AI-driven innovation. Discover what Azure uniquely offers to startups at every stage of their journey, from ideation to scaling advanced AI solutions. 

Session takeaways: 

- Microsoft enables startups to build AI at any stage, from inception to the most sophisticated models in the world. 
    
- How Microsoft works with Founders through Founders Hub, the premier destination for startups seeking personalized guidance, free credits, and services tailored to their business needs.

### Notes
Microsoft copilot for productivity and azure for cloud  
  
Copilot stack to unlock produxvitiy for your organization  
- e.g. Github copilot  
- Copilot studio - build your own copilot to embed into your website or application  
  
Azure to help orgs build ai solutions  
Stack high level to low  
- azure ai services - like making api call. Eg. Goodcall using speech recognition api  
- azure ml: next level of stack. Fine tuning models.  
- Azure ai infra: bottom of stack.  
  
Examples of startups  
- gretel for Healthcare secure ai  
- xx nixtla built foundation model for time series analysis using azure ai infra. For stock market, supply chain etc. Use azure to host and serve model.

## Fireside Chat with Peter Norvig and Alfred Spector
### About
Fireside Chat with Peter Norvig and Alfred Spector

 Tue Sep 10, 2024

 9:50 AM - 10:15 AM

 City View

 534 Attending

 8 Questions

Future

 Remove from AgendaLike sessionTake notes

Speaker

![Peter Norvig's profile](blob:https://whova.com/49157b91-948d-4f05-9d40-c175a5c43493)

Peter Norvig

Director of Research

Google

Send MessageView Profile

![Alfred Spector's profile](blob:https://whova.com/799a71e1-81cf-439e-b64c-1d0cbbb545e5)

Alfred Spector

Visiting Scholar

MIT

Send MessageView Profile

Join us for an exclusive fireside chat with AI luminaries Peter Norvig and Alfred Spector. These pioneering computer scientists will discuss the latest AI developments of 2024 and share their visions for the future. From recent breakthroughs to what’s coming next, Norvig and Spector will offer unique insights into the evolving landscape of artificial intelligence and its potential impact on society. Don’t miss this opportunity to hear from two of the most influential minds in the field as they explore the cutting edge of AI technology.


### Notes
What's unexpected about conversational ai?
- thought it would be very specialized to topics as opposed to general purpose conversations 
- Will there be emergent ai? Thought no. But that's what's happened now. 

Data is helping scale ai

Book about data science by the two speakers:  Data Science in Context: Foundations, Challenges, Opportunities
- having a model not enough to do something useful. Bulk of project is on top of the model. They created a rubric for what all to build on top of model. 

Rubric for data science projects 
- do you need the data? Consider cost, regulatory issues, etc. 
- Is there a model? Some things are not predictable. Eg. Interest rates. 
- Can you be dependable? And resilient? Meeting reliability, security, privacy etc. People will abuse the systems. Do we understand the system?
- Is the application understandable? Developers should understand how to modify. Users should understand. Third parties should be able to audit. 
- Reproducible. Transferable to human understanding. 
- Do we understand the objectives. What are we optimizing for? Eg. Travel recommendation - price, enjoyment, fairness, etc. 
- Failure resistance. More important for waymo. Less important for Facebook ads. 


What changed since the book? Goals are key
- focus on the objectives now. Data and algorithms are progressing. We need to understand our goals. LIKE Piyush conversation about advertising AI. 
- We need philosophy to help us understand the objectives. Is buying more products the objective? We need to focus on longer term objectives for us as humanity 
- Spector says liberal arts education is key to thinking about goals. Need to understand various tradeoffs and implications for humanity and society. 
- Regulation of ai is important. Eg. California bill by Newsom. 
- We need to be extremely precise in how we define goals for AI. E.g. Say "it's better to let 10 guiltily men go free than one innocent man hanged". We need to think this through as society and align and input this into the AI. 
- Maybe some software building needs to be regulated. Eg I can't just build a bridge or a road without licensing. R
- Need countries to cooperation on this. Else actors who want to defy regulation just move to another country 
- Rather than regulating ai in general, we can regulate at the application layer. Eg. Regulating self driving cars very different than regulating ai advertising 

What's new and what's next
- spector's combination hypothesis : mix of people interested in semantics, syntax, data driven methods etc. Combination of approaches will push the bar forward. So far ML alone has pushed things forward. But we may hit a wall with that. Eg we want to access structured knowledge bases with RAG. 
- Norvig most excited about education application area. Individualized tutors tailored to personal learning needs. But need to rethink why we learn what we learn. Eg why do we learn calculus when computer can do it much better? We learn it to learn rigorous reasoning and multi step thinkin. Would data science and programming be more valuable for this purpose? Again, we need clarity on the goals and objectives. 

--

Note to Piyush 
At an AI conference talk by Peter Norvig. He says now that AI data and algorithms are so advanced, the most important thing we should focus on are the goals we give to the AI. Reminded me of your point about AI in advertising. 

## Why Knowledge Graphs are Necessary for Enterprise AI
### About
Speaker
Philip Rathle, CTO, Neo4j

Knowledge graphs add explicit knowledge to GenAI in a format that is easily understood by humans and enhances enterprise machine decisions. They are rapidly emerging as a useful & often necessary component of GenAI, complementing what is otherwise a world of statistical reasoning rooted in inferred concepts. Knowledge graphs make GenAI more dependable, transparent, and secure across a wide variety of use cases, opening the door further for GenAI adoption. This talk presents a framework for how to think about knowledge graphs for any use case. You will hear up-to-date learnings from this evolving field, including design patterns & examples derived from working with many of the world’s largest organizations. You will come away with an understanding of how knowledge graphs can play the role of left brain to the right brain that is the universe of LLM + vectors-- in an enterprise landscape where many use cases call for the use of both hemispheres.

### Notes
How is genai like web search?  
- ask question, return answer  
  
Evolution of web search  
- 1990s - full text indexing era  
- 2000s and Google: page rank graph search  
- 2010s google's next innovation - knowledge graphs. "Things not strings"  
- 2020s - AI search. Gemini. Combining knowledge graph with llms.  
  
Organizations are really struggling to implement genai projects  
- go to production barriers of hallucinations  
  
Graph RAG  
- incorporatea knowledge graphs to break the production barrier  
  
Benefits of graph rag  
- better answers.  
- Better explainable. More deterministic.  
- easier development - really?  
  
NM: this combines deterministic features of knowledge graphs with non deterministic features of llms.

## Fireside Chat with Robert Nishihara and Mark Chen
### About
Speaker
Robert Nishihara, Co-Founder, Anyscale
Mark Chen, Head of Frontiers Research, OpenAI

Join us for an unprecedented meeting of minds at The AI Conference 2024! This event will feature an exclusive Fireside Chat with two luminaries in the field of artificial intelligence:

Robert Nishihara, Co-founder of Anyscale, and Mark Chen, Head of Frontiers Research at OpenAI.


### Notes
Biggest breakthroughs
- Unsupervised learning and architecture improvement 
- Data explosion 

## VC Perspectives on AI
### About
Speaker
Kenn So
Author
Generational

Alex Kayyal
Partner
Lightspeed Venture Partners

Kanu Gulati
Partner
Khosla Ventures

Shravan Narayen
Partner
IVP

A panel of venture investors discuss AI trends they’re focused on, feedback on where they see AI investments within their portfolio, and their approaches to investing in the space.

### Notes
Intro
- Alex. Lightsoeed. Enterprise focused firm. He focuses on application layer. Former Salesforce employee. 
- Kanu. Khosla. General fund. Focus on tech moat that can translate to business moat. 
- Shravan. Ivp. 

Most exciting opportunities and how they choose
- Alex. Founders with deep insight into the business problem and solution rather than just tech. E.g. CV to prevent health and safety accidents in factory floors with monitoring and alerts. Excited about major shifts in verticals such as legal. 
- Kanu. Excited about applications across industries and functions. Focus on imagining the future rather than today's problems. Eg. remaining RPA by using AI. Excited about what's next beyond llms - investing in symbolic techniques etc. 
- Shravan. Focus on infra, general purpose infra. excited about how ai feeds human curiosity 

Trends and evolution in AI 
- Kanu. Evolution on gpt 2 onwards. Excited about creative writing experience and code generation. Think about use cases enabled by future models like gpt5
- Shravan. Originally skeptical of ChatGPT's impact on business. Surprised with the rush for adoption. 
- Alex. Need to balance the magical experience of ChatGPT with the skepticism. Security, privacy, trust are really critical. 

Tooling and infrastructure. What's new?
- Shravan. We're still discovering how to build and scale ai applications. Not much is still in production at scale in large enterprises, so we still don't have good examples to learn from. Need to wait for applications to scale to better understand infra pain points and challenges 
- Kanu. Don't invest in problems that can be solved by model providers (eg maybe rag, fine tuning), but need problems that are large enough in TAM. 

Use cases of interest 
- Alex. look for tasks that can be automated. E.g. Healthcare notes automated. 
- Kanu. Copilot vs autopilot distinction. Think of self driving cars vs github copilot. 
- Kanu. Look for data flywheel 

Risks in evaluation of ai investments
- Alex. Rate of change very fast. Number of new entrants very high. Need to keep up w new advancements. Incumbents vs startups - incumbents also moving fast these days. 
- Shravan. Now it's easier than ever to start a company but perhaps harder than ever to scale a company, especially due to production scaling challenges, competition, etc. 
- Kanu. 

Hot takes
- Alex. We're going to see a new wave of trillion dollar companies that are built and scaled very quickly. 
- Kanu. Rate of advancement very high. Focus on building companies for future ai not today ai 
- Shravan. Copilot is not a good product category. It just fixes poor ux. Good products don't need copilot. 

## The New Relationship Between Machines and People
### About
Speaker
Lariena Yee
Chair of the McKinsey Technology Council
McKinsey & Company

AI has the potential to have a profound impact on business – but how will that change our lives? Lareina Yee explores the current and future impact of AI on business, and more importantly, what that means for the people building and using AI. Join McKinsey & Company for thought-provoking questions on AI’s potential benefits and impact.

### Notes
Ai has 4.4 trillion dollar economic opportunity in the long term 
- openai valuation >80B; 13 ai startups >1B; 400% vc investment increase 
- Genai can transform industries 
- Marketing and sales, software development, customer operations, and one more function accounts for 75% of the total 4.4tn
- E.g. Role of sales rep will completely be transformed by AI. What is the best next up sell or pitch for any account. 

People and organizations change their journeys 
- use > co-create > understand and trust 
- As tech develops, people journeys and trust needs to develop 
- How to drive trust across organization in something new like this? How to bring people along. 
- How do we get people to use ai and incorporate into their workflows? How to get people comfortable with the reconfigirations of their jobs as co-pilots?

Key questions
- how to we design solutions that give people super powers?
- How to take the toil out of work and give people time back for joy?
- How to identify the new skills and capabilities  needed for the AI transformed economy 
- How do we think about equity and access in AI?
- How do we rethink whole systems and processes not just task automation?
- How can ai enhance people's creativity and imagination 

## Transforming Generative AI Through Neuroscience
Christy Maver, VP Marketing, Numenta

Massive increase in AI compute needs
- hardware performance improvement not growing fast enough to keep pace with ai demand 
- We need new software innovation to bridge this gap 
- Human brain uses only 20 watts and should be the inspiration 

Why brains are so efficient 
- neurons are sophisticated sparse computers. Much more complex than ANN neurons 
- Brains dynamically route compute as needed. Brain can dynamically activate a tiny portion of neurons needed to process any given input. Tiny percentage of neurons active at any given time. 
- We can apply these two concepts to make brains more efficient 

Numenta overview 
- scientific mission: understanding how brain works
- Engineering mission : apply the understanding to AI advancements 
- "thousand brains theory" published on above theory in 2021
- Demonstrated power and performance improvements based on theory. 

Transforming ai through neuroscience 
- translating neuroscience to cs. New architecture, data structures and algorithms. 
- Improved inference, model development and hardware 
- NM: they claim to have demonstrated 100x improvements in all areas. But I'd that's true they should be the most valuable company in the world. 

## Revolutionizing the Future of Digital Twins with AI
Atefeh Mohajeri Moghaddam, AI/ML Research Scientist, Nokia Bell Labs

What is digital twin?
- digital representation of physical world
- Eg. Industrial warehouse. Create dynamic 3d model of changing environment. Real time monitoring and control. 
- E.g. Sports arena. Transition smoothly from one camera view to other. View game from a specific seat or viewpoint without a good camera angle. 

How to do this?
- create neural radiance fields (NeRF) for 3d modeling 
- use existing camera views to simulate camera views that don't exist by training neural networks 
- In warehouse, fly a drone periodically to update information, and use the trained neural network to simulate angles and views that don't exist. You can view from any angle you want or can imagine!
- NM: this sounds really cool for Metaverse 

## Advanced RAG Panel
### About
Speaker
Christy Bergman
AI Developer Advocate

Ofer Mendelevitch
Head of Developer Relations
Vectara

Prashanth Rao
AI Engineer
Kùzu, Inc

Marwan Sarieddine
AI Engineer
Anyscale Inc.

Join our panel of experts as they explore advanced RAG (Retrieval-Augmented Generation) techniques. Discover how the integration of information retrieval and generative models is enabling AI systems to generate contextually rich and coherent responses and be truly useful in production applications.

### Notes
Is long context making rag obsolete?  
- no, latency issues. Needle in Haystack issues. Relevancy issues. Etc.  
- Long context is a tool for RAG.  
- Long context with caching may be substitute for RAG.  
  
Which rag techniques are most excited about?  
- hybrid and multimodal rag.  
- Agentic rag. Add capabilities like query break down, context understanding, tool usage, function calling, etc.  
- Graph rag. Combination is really powerful. Provides the right deterministic context.  
- LLM as a judge for evaluating model outputs  
  
Biggest challenges of implementing rag  
- trust and privacy. How to build a RAG that guards against data leakage.  
- Retrieval is a bigger challenge than the llm part. Finding the relevant context and indexing it such that it can be found.  
- Build vs buy. People think it's really easy to build and maintain, but there's a lot of complexity. Many people shouldn't be building the entire rag stack but focus just on their use case.  
-

## ALLY: LLM-based Assistive Recommendation
### About
Speaker
Konstantina Christakopoulou
Senior Research Engineer
Google DeepMind

Large Language Models (LLMs) have demonstrated impressive capabilities for natural language understanding and generation. What if we power recommender systems with LLMs that can reason through user activities on the platform, and can help plan recommendations accordingly? Equipped with UXR insights that people use nuanced language to describe their long-term interest journeys, and they want more user agency in their recommender platforms, we pinpoint a combination of LLMs and personalization as a key ingredient for the next generation of assistive recommendation. In this talk, we will introduce a novel LLM-based journey service that allows to uncover the personalized nuanced user interests, needs and goals of users, i.e., their interest journeys, through fine-tuning and prompt-tuning LLMs. We will discuss research findings from this work on LLMs for better user understanding, and will provide insights on LLM-based long-term planning to assist user journeys. Finally, we will provide challenges and opportunities across our long quest of integrating LLMs into user facing products to transform the user experience.

### Notes
What is ally?  
- google brain moonshot idea  
- Aligning recommendations with people's long term goals  
- Companion recommender ally to assist users life long journey  
- User interests change from finding wineries in Napa to improving golf swing to finding relaxing music to listen to  
  
How to do this? Problems with today's rec systems  
- existing recommendations focused on short term goals like what movie to watch of what restaurant to eat at. But users pursue interest for long time like hobbies skills travel etc. Journeys can last days, weeks, months or years.  
- recommender systems today don't offer interpret ability and control  
- User interests are captured as embeddings or knowledge graph entities. Disconnect from users own understanding.  
  
Solutions  
- personalized user interest clusters. Nm: this sounds similar to embeddings  
-

## Startup showdown
Andi: AI search  
- consumer AI search is a stpping stone to bigger opportunities like developer API and enterprise plans  
  
Deep Keep: empowering LLMs with security and trust


## AI Legal Issues - A Tech General Counsel Turned GPT App Developer Breaks It Down
### About
Speaker
Cecilia Ziniti
Attorney & General Counsel; Founder & CEO
GC AI

This talk will explain copyright, fair use, and legal issues for AI, and how to navigate them in development. Hear from a three-time general counsel and now AI application developer on the legal challenges and opportunities, and how to both protect yourself and move fast. The presentation will explore the latest legal cases including NYT v OpenAI, and discuss the implications for intellectual property rights. Attendees will learn the legal challenges in AI, with dozens of real-word examples of cases I've litigated or been involved in at companies from Replit, to Amazon, to Cruise. Exciting times!

### Notes
Copyright law is in the US constitution 
- to protect authors and inventors in arts and sciences 
- this enabled US to be one of the big exporters of IP in the world 

What is copyright?
- exclusive rights granted to authors to reproduce, to distribute copies, to publicly display or perform, to create derivatives of their works. 
- Doing any of the above without permission of rights holder is copyright infringement

Actors in AI copyright 
- rights holder
- Publisher of work
- Model trainer
- User using model 

What is fair use?
- exception to copyright based on four factor test. 
- 1 purpose of use. Transformative use test. This is the most significant of 4 factors in AI use.
- 2 nature of work
- 3 amount and substantiality of portion used 
- 4 effect of use on market and value of original 

Nyt v openai 
- Nyt text is a significant percentage of common crawl corpus used to train gpt. 
- Openai response : fair use based on factor 1 primarily. Training is fair use. 
- This case will set precedent for AI. 
- Speaker believes we'll find an economic solution of some royalty payouts. 

Music cases. Suno. Udio. 
- record labels going after training itself rather than the outputs. Nyt case was going after outputs. 

Suggestions for AI model training
- open internet is generally okay. Just don't ignore robots or login screens etc. 
- Know your data 
- Document what you do
- Work with lawyers from the beginning 
- Pass the smell test 
- Control the narrative

NM Qs
- how would economic solution work? How to know when the work has been "played"

## Building an Advanced Knowledge Assistant
### About
Speaker
Jerry Liu
Co-Founder
LlamaIndex

A huge promise for LLMs is being able to answer questions and solve tasks of arbitrary complexity over an arbitrary number of data sources. The world has started to shift from simple RAG stacks, which are mostly good for answering pointed questions, to agents that can more autonomously reason over a diverse set of inputs, and interleave retrieval and tool use to produce sophisticated outputs.

Building a reliable multi-agent system is challenging. There's a core question of developer ergonomics and production deployment - what makes sense outside a notebook setting. In this talk we outline some core building blocks for building advanced research assistants, including advanced RAG modules, event-driven workflow orchestration, and more.

### Notes
Knowledge assistant needs ETL solution  
- parsing and processing complex documents. Off the shelf parsers are not good. E.g. Tables charts images etc. Need genai native parser.  
  
Naive rag struggles w complex questions that need summarization etc.  
- need agentic system to address this  
- Similar to things covered in langchain rag from scratch series

## Transforming a Global Company’s Customer Success Experience with AI: Lessons from Square’s Journey
### About
Speaker
Giorgia Dell'Orco
operations and strategy leader
Square

As Generative AI makes the speedy transition from hype to adoption, customer support functions have quickly emerged as ground zero for the technology, providing business leaders with a straightforward starting point towards using AI to drive real business value. But in order to build effective AI-powered CS solutions that drive positive outcomes for your customers, you need to overcome several problems that might have been easy to sweep under the rug before, but suddenly become thrust into the spotlight by AI adoption.

In this talk, we’ll explore the unique challenges, learnings, and successes of Square’s journey toward launching AI-powered support, including practical lessons in overhauling internal and external information architecture and knowledge bases to make them AI-ready; navigating build vs. buy and policy decisions; and how to approach problems when “the hard tech suddenly becomes the easy part.

### Notes

Objective  
- give time back to sellers to run their business.  
  
Challenges  
- sellers want phone support right away for urgent issues  
  
Process  
- understand every step of seller journey, jtbd, and pain points  
  
Simplified journey  
- customer contacts advocate  
- Advocate searches for information to answer customer questions. Takes 25% of call time  
- Advocate is helping seller resolve the issue and understand best practices. 45% of time.  
- Advocate writes case summary at end. 15% of time.  
  
Build vs buy  
- depending on use case, consider factors such as  
- How common is use case across industry?  
- How is my ability to build in terms of cost, time to market, maintenence etc.  
- Am I able to reuse the solution across different use cases in my company?  
  
Search augmentation


## The Role of Sparsity in ML
### About
Speaker
Nir Shavit
Professor of Electrical Engineering and Computer Science
MIT

Our brain executes very sparse computation, allowing for great speed and energy savings. Deep neural networks can also be made to exhibit high levels of sparsity without significant accuracy loss. As their size grows, it is becoming imperative that we use sparsity to improve their efficiency. This is a challenging task because the memory systems and SIMD operations that dominate todays CPUs and GPUs do not lend themselves easily to the irregular data patterns sparsity introduces. This talk will survey the role of sparsity in neural network computation, and the parallel algorithms and hardware features that nevertheless allow us to make effective use of it.

### Notes
Human brain is very efficient at sparse computation 
- human cortex is much more compute efficient 
- brain vs gpus. We're building the wrong thing because we don't know the right algorithms 
- Llama 405b needs 11 80GB gpus just to hold in memory 

Quantization and sparsification does a good job, but not good enough 

Neural tissue computation is
- sparse in both connectivity and activity 
- Has locality of reference - all the weights are cached in hardware 
- We need to mimic this in silicon 


## Innovating with Stability AI and AMD: The Power of SD3 and Cloud GPU Integration
### About
Speaker
Prem Akkaraju
CEO
Stability AI

Nick Ni
Sr. Director of Product Marketing, AI
AMD

Join Prem Akkaraju, CEO of Stability AI and Nick Ni, AMD Sr. Director of Product Marketing of AI, dive into the latest breakthrough SD3 technology. This session will showcase SD3-based applications and highlight innovative advancements powering this cutting-edge technology. Discover how Stability AI, in collaboration with AMD, is pushing the boundaries of AI capabilities by enabling SD3 on cloud GPUs and AI PCs and learn how their partnership is driving the future of AI technology.

### Notes
Stable diffusion is one of the most widely used image models
- discussed new features of stable diffusion such as editing existing photographs, improvements in realism, photos for brand advertising 

Enterprise value prop
- safety and integrity 
- Datasets are safe to begin with 
- Filters for safety - celebrities, political figures etc. 

Amd strategy 
- shifting towards ai 
- everything from cloud to embedded 
- Verticals from tech to automotive with custom architecture 


## AI Regulatory Panel SB 1047 & Beyond
### About
Speaker
Ion Stoica
Professor in the EECS Department
University of California at Berkeley

Scott Wiener
Senator
California

Priya Anand
Reporter
The San Francisco Standard

### Notes
Lot of controversy about this bill
- hand raise shows most attendees against the bill, but many still undecided or unknown
- Ion vs Scott debate

Bull origin story by Scott 
- representative for San Francisco and San Mateo counties 
- Excited about ai but concerned about potential harm
- Started sharing early drafts of bill for early feedback. Engaging with startups, big companies, academics, etc. Then released draft for public. 
- Since April lot of attention and feedback. 

Bill outline 
- safety measures to guardrail against catastrophic risk
- If you train very powerful models, there are risks. Bill does not seek to eliminate risk, but taking reasonable steps to reduce risk. Bill does not ask developers to certify that model is risk free. bill requires companies to honor their public commitment to safety testing models. 
- Catastrophic risk is massive risk to critical infrastructure, cyber crime with 500M+ damages, biological weapons etc. If such risk is identified, companies controlling models should shut them down. 

Ion: why this bill is harmful 
- Not against safety or regulation, but concerned that bill will hurt safety and innovation 
- Criteria for liability based on training cost (>100M) or fine tuning (>10M). Lot of companies will hit this threshold and opens them up to liability. This is an artificial threshold that will make people choose between safety and performance. Safety will actually cost more. Eg safer cars are more expensive. Why can't we have regulations like car industry with crash tests etc. 
- Open source developers will move outside California. That's not a safer world. Response : this is wrong, Bill is triggered by doing business in California, not by training models in California 

Is this beurocratizing ai? Like dmv of ai?
- Dmv requires license to drive a car. Else it's illegal to drive. That's not what this bill does. That's what Sam altman proposed as regulatory capture. 
- Bill is not micromanaging how safety testing work. Based on evolving external standards. 

Liability concern 
- Liability created in the bill is very narrow. Only AG can sue. Only for Catastrophic risk. Only if safety testing was not done. 
- Liability already exists under existing law. So why this additional bill? This bill clarifies the boundaries of liability. 


NM thoughts 
- NM: this seems like a very minor issue, not clear why the benefits or risks of this bill are significant at all
- You can probably just get insurance that covers this. This may be a good business opportunity to sell insurance. 

## Open Source AI: Status, Opportunities, and Challenges from the Enterprise Perspective
### About
Speaker
Anthony Annunziata
Director of AI Open Innovation
IBM and IBM lead for AI Alliance

Open source and open science in generative AI have advanced greatly in the past 2 years, with open capabilities now approaching parity with proprietary systems, and a flourishing researcher and developer ecosystem innovating across the stack, from new tuning methods to infrastructure optimizations to agentic application frameworks and beyond. Still, there is a lot to do: from domain-specific safety and evaluation of AI systems, to democratizing methods of tuning, to ensuring highly capable open models can be integrated and deployed efficiently in a variety of use cases and contexts. The enterprise perspective is especially illuminating, where almost all large companies have targets to adopt generative AI, but where the divide between proof of concept and production is often still large. I’ll present a perspective on the path ahead to achieve widespread adoption of generative AI in companies and how IBM’s open source AI contributions and the AI Alliance of more than 100 leading AI technology and research organizations are enabling this path.

### Notes
Slide on open source ai predictions right vs wrong 

Defining open source ai
- minimum definition : open weights and documentation 
- Broader definition - needs more architecture and data openness 

Key challenges
- data: 

## Building an AI-Driven Company with Agents
### About
Speaker
João Moura
Founder
crewAI

AI is unlocking new frontiers for businesses, and leveraging its potential is no longer optional. When we embarked on building CrewAI, a framework for creating AI Agents, we didn’t just anticipate a shift in how we work; we experienced a transformation. This talk will delve into the journey of how AI Agents have become a catalyst for growth, not only within our company but also for our customers.

Through concrete, real-world examples, we’ll explore how AI Agents autonomously navigate complex tasks, streamline workflows, and spark innovative solutions. You'll gain insights into the foundational elements that make these agents reliable and powerful, and how you can implement them into your own projects. This is more than a narrative—it's a guide to harnessing AI as a driving force in your business strategy.

### Notes
Benefits of agents 
- real time actions 
- task specialization with multi agents 

Building crew ai company with agents - marketing crew
- marketing crew. Input idea about conference speaking gig. Search internet, social media, his past experiences, generate draft 
- 10x more drafts, more posts, more growth 

Lead qualifications crew 
- lead form responses - analyze answers, internet, crm, output use cases, talking points etc. 

Crew demo - customer support data analysis 
- agents setup - see slide 
- Chart specialist is a coding agent 

## Behavior Models for Interactive AV Forecasting and Planning
### About
Speaker
Rowan McAllister
Staff Research Scientist
Waymo

Behavior prediction and motion planning are critical elements for deploying embodied AI and robots into the real world with other agents. We present an overview of Waymo's research in data-driven behavior prediction and motion planning algorithms for autonomous driving.

### Notes
Behavioral modeling 
- inputs : world state, agent state history, traffic lights state, road network 
- Output : for no agents around us, predict k different trajectories and their positions over the time steps 
- Uses neural networks 

Behavior prediction with transformers
- instead of special human encoding for each input, use an overall scene encoder 

Joint future prediction 
- previous approaches modeled individual futures and ran successive inferences. New approach is to predict future for all vehicles jointly. Prediction is in joint space. 

LLM usage
- discrete motion tokens. Tokens are arrows / directions. Better than predicting positions. 

Imitation learning vs reinforcement learning 
- Imitation learning suffers with out of distribution data. Rl is better in those cases. 
- combination of both has the best results 

Symbolic representation vs end to end tokenization
- use both 

## Getting started with GraphRAG
### About
Speaker
Alison Cossette
Data Science Strategist and Podcast Host
Neo4j

Learn about the power of GraphRAG (Graph Retrieval Augmented Generation) to improve the accuracy, relevance, and quality of LLM responses. While LLMs offer great potential, they can face challenges with lack of domain knowledge and hallucination. GraphRAG helps overcome these challenges by integrating vector search with knowledge graphs and data science techniques to improve context, semantic understanding, and personalization while facilitating real-time updates. In this session, we will cover GraphRAG through a real-world practical example, from creating a starter knowledge graph with a vector index to identifying and implementing useful GraphRAG patterns in a GenAI application.

### Notes
How to get started using knowledge graph with RAG for grounding responses

What are graph components 
- nodes that represent entities 
- Relationships between nodes. Directed. 
- Properties. For both nodes and relationships. Descriptions can be embeddings. 

Graph rag patterns
- text 2 Cypher queries 
- Vector search with graph context. Helps retrieve more relevant vectors. 
- Graph vectors. Use graph embeddings for retrieval. 
- Agent's and multi step. 
- Graph filtering. 

Getting started 
- think about your data. draw your data. 
- Use neo4j knowledge graph builder. Supports text, docs, websites, etc. Use graph enhancer to deduplicate, clean up etc. 

## Building Agents Panel
### About
Speaker
Alex Chao
Product Lead
Microsoft

Shelby Heinceke
Senior AI Research Manager
Salesforce

Anna Marie Clifton
Head of Product
Zapier

Discover the key principles and methodologies in designing and implementing intelligent agents with our distinguished panel. The panelists will share their experiences in developing various types of agents and discuss the challenges and solutions to building robust, production-ready agentic systems.

### Notes
How have you approached shift to agents.  
- Anna: agents is a big step forward. Model what the user wants to do, then instruct the llm to do it. Offloading cognitive load from user to agent. Thinking procedurally is an important skill - but not everyone can do this - Agent's can interpolate this.  
- Shelby. Agents enable more than just content generation, they perform tasks. Enable mukti step workflows with thoughts and actions.  
  
Importance of function calling and tools.  
- Shelby. llm needs to create procedures. Salesforce training models specialized in function calling. Tiny giant is one. Small and fast. On Berkeley function calling leader board.  
- Zapier. More tools you give an agent, less accurate in selecting the right tool. Zapier has thousands of tools. Need to enable user to constrain set of tools. Can also use multi agent workflows where one agent specializing in planning and tool selection.  
  
Multi agent workflows  
- each agent should specialized in one thing. Need to set up the right specializations. Like microservices architecture in software.  
  
Implications for users  
- Accuracy is currently pretty low for agents. Need human in loop. Like draft and review workflow. Choose low risk use cases.  
  
What new superpowers can users get?  
- zapier. Monitor your entire Slack / email / etc. and alert for what is important.  
- Some superpower use cases are too expensive. E.g. Monitor everything in your awareness and internet to alert you for what's interesting to you.  
  
Next Gen models impact  
- Shelby. Smaller and more specialized models needed for efficiency and cost. Good for specialized tasks. More ambiguous tasks will need bigger model. Need a good routing system.  
  
Challenges  
- getting Datasets for training action models.

## AI in Healthcare Panel
### About
Speaker
Shiva Amiri
Partner, VP - Head of AI and Data Intelligence
Pivotal Life Sciences

Bharath Ramsundar
CEO
Deep Forest Sciences
Send Message

Alaa Youssef
Postdoctoral Researcher
Stanford AIMI Center - Stanford University School of Medicine

Dr. Abraham Stern
Product Manager
NVIDIA

Witness the transformative potential of AI in revolutionizing healthcare. Learn how AI is accelerating the identification of novel therapeutic targets, optimizing drug candidate selection, and improving patient outcomes. The panelists will also discuss the challenges and opportunities in integrating AI into healthcare systems and drug discovery and ensuring its safe and ethical use. Don’t miss this opportunity to learn about the future of AI-driven healthcare innovation.

### Notes
What are people excited about?
- near term technology : generative models for de novo design for drug discovery
- longer term: ai models with simulation of physics and chemistry and biology 
- building systems around ai to constrain it with physics and chemistry constraints for generative use cases

Challenges or opportunities 
- multimodal models very valuable for healthcare because Healthcare data is broad 