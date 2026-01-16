## post-hackathon update
- New name
	- deep-crawl
	- deep-knowledge
- TODO
	- WP post
		- deep-research is now deep-crawl
		- Metamate is launching a 1st party Deep Research feature. To avoid confusion, this project will be called deep-crawl going forward.
		- Try out Metamate Deep Research: https://fb.workplace.com/groups/3983815748613534/posts/3984066705255105
		- Note from Metamate team's Stephen: 
		- Thanks for all the exploratory work and prototyping on deep research! It has deeply (pun intended) inspired our 1p Deep Research solution!
		- Ref: D78568588
	- Update wiki
	- Command UI changes
		- agent-name
		- alias
	- Code changes


## hackathon project
- Architecture - high level
	- Query handling to confirm with user
		- Understand user query
		- Get root docs
	- Planning
		- Generate initial query
		- Get root docs
			- Pers
		- Build knowledge graph - search and crawl
		- Scoped retrieval
		- Generate report outline
			- TLDR
			- Introduction
			- Key topic 1
			- Key topic 2
			- Key topic 3
			- References
	- Topic writing - parallel
		- Generate search query
		- Augment knowledge graph - search and crawl
		- Scoped retrieval 
		- Write content
		- Reflect
			- Review content to see if more topic queries are needed
			- Reflect on our existing content, identify the key knowledge gap and generate a follow-up search query
	- Finalize report
- Tools
	- MetamateAgentThinkTool
	- MetamateAgentCodingPythonTool
	- MetamateAgentAnalyticsDaiqueryQueryTool.php
	- AnalyticsExecuteScubaQueryTool.php
- Refs
	- https://github.com/langchain-ai/local-deep-researcher


### Snippets
##### Test RAG input - unformatted
```txt
[{"url":"https:\/\/www.internalfb.com\/intern\/wiki\/Metamate\/stan\/","title":"Metamate\/Stan Scripts","type":"Wiki Page","ref_count":3},{"url":"https:\/\/www.internalfb.com\/intern\/wiki\/Metamate\/Commands\/","title":"https:\/\/www.internalfb.com\/intern\/wiki\/Metamate\/Commands\/","type":"unknown","ref_count":2},{"url":"https:\/\/www.internalfb.com\/intern\/wiki\/Metamate\/stan\/Sandbox\/","title":"Metamate\/stan\/Script Sandbox","type":"Wiki Page","ref_count":2},{"url":"https:\/\/fb.workplace.com\/groups\/metamate.feedback\/posts\/463465282778752\/?comment_id=463636396094974","title":"Why not use Hack instead of Stan for Metamate?","type":"Workplace Post","ref_count":2},{"url":"https:\/\/www.internalfb.com\/intern\/wiki\/AI4P\/Development_Guide\/Metamate_RAG\/#alacorn","title":"AI4P\/Development Guide\/Using RAG with Metamate","type":"Wiki Page","ref_count":2},{"url":"https:\/\/www.internalfb.com\/intern\/wiki\/Metamate\/Templates\/Tutorial\/","title":"https:\/\/www.internalfb.com\/intern\/wiki\/Metamate\/Templates\/Tutorial\/","type":"unknown","ref_count":1},{"url":"https:\/\/www.internalfb.com\/intern\/wiki\/AlacornGuide\/FAQs\/#q-i-have-tested-queries","title":"https:\/\/www.internalfb.com\/intern\/wiki\/AlacornGuide\/FAQs\/#q-i-have-tested-queries","type":"unknown","ref_count":1},{"url":"https:\/\/www.internalfb.com\/intern\/wiki\/AlacornGuide\/n00b_Lab\/#lab","title":"https:\/\/www.internalfb.com\/intern\/wiki\/AlacornGuide\/n00b_Lab\/#lab","type":"unknown","ref_count":1}] what's the vision for metamate deep research?
```

##### Test RAG - formatted
```txt
[{"url":"https://www.internalfb.com/intern/wiki/Metamate/stan/","title":"Metamate/Stan Scripts","type":"Wiki Page","ref_count":3},{"url":"https://www.internalfb.com/intern/wiki/Metamate/Commands/","title":"https://www.internalfb.com/intern/wiki/Metamate/Commands/","type":"unknown","ref_count":2},{"url":"https://www.internalfb.com/intern/wiki/AI4P/Development_Guide/Metamate_RAG/#alacorn","title":"AI4P/Development Guide/Using RAG with Metamate","type":"Wiki Page","ref_count":2},{"url":"https://www.internalfb.com/intern/wiki/Metamate/stan/Sandbox/","title":"Metamate/stan/Script Sandbox","type":"Wiki Page","ref_count":2},{"url":"https://fb.workplace.com/groups/metamate.feedback/posts/463465282778752/?comment_id=463636396094974","title":"Why not use Hack instead of Stan for Metamate?","type":"Workplace Post","ref_count":2},{"url":"https://en.wikipedia.org/wiki/Ackermann_function","title":"https://en.wikipedia.org/wiki/Ackermann_function","type":"unknown","ref_count":1},{"url":"https://www.internalfb.com/intern/wiki/Unicorn/Docs_V2_(in_progress)/Tooling/DevX_(local_index_testing)/","title":"https://www.internalfb.com/intern/wiki/Unicorn/Docs_V2_(in_progress)/Tooling/DevX_(local_index_testing)/","type":"unknown","ref_count":1},{"url":"https://docs.google.com/document/d/1TpO96BxE7v5UelPuRLZZO3mF0LkBmVsIHHXy6kIkKLU/edit?tab=t.vh5eyq1xl8bg","title":"Knowledge discovery hackathon","type":"Google Doc","ref_count":0}] what's the vision for metamate deep research?
```


##### Test RAG - formatted - small
```txt
[{"url":"https://www.internalfb.com/intern/wiki/Metamate/stan/","title":"Metamate/Stan Scripts","type":"Wiki Page","ref_count":3},{"url":"https://www.internalfb.com/intern/wiki/Metamate/Commands/","title":"https://www.internalfb.com/intern/wiki/Metamate/Commands/","type":"unknown","ref_count":2}, {"url":"https://docs.google.com/document/d/1TpO96BxE7v5UelPuRLZZO3mF0LkBmVsIHHXy6kIkKLU/edit?tab=t.0#heading=h.qou1vj6695ax","title":"Knowledge discovery hackathon","type":"Google Doc","ref_count":0}] what's the vision for metamate deep research?
```

run scoped retrieval with these urls:

https://docs.google.com/document/d/1TpO96BxE7v5UelPuRLZZO3mF0LkBmVsIHHXy6kIkKLU/edit?tab=t.vh5eyq1xl8bg

https://www.internalfb.com/intern/wiki/AI4P/Development_Guide/Metamate_RAG/

Answer the question: what's the vision for metamate deep research?




# END