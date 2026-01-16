
# Metadata
- Note type: #reference
- Medium: #youtube
- Source: https://www.youtube.com/playlist?list=PLfaIDFEXuae2LXbO1_PKyVJiQ23ZztA0x
- Internal links
	- [[Art and Science of AI]] 
	- [[Retrieval Augmented Generation (RAG)]]

# Summary

Retrieval Augmented Generation (RAG) can be broken down into four distinct modules, each of which can be further optimized by various techniques:

- **Query handling**: Re-constructing the user's query into a more suitable form for retrieval, e.g. query decomposition, step-back querying.
- **Indexing**: Storing and organizing the knowledge base such that it is optimized for retrieval, e.g. semantic chunking, hierarchical indexing.
- **Retrieval**: Retrieving the most relevant information from the knowledge base to answer the user's query, e.g. filtering and re-ranking.
- **Generation**: Using the retrieved information to generate the most useful response to the user's query, e.g. evaluating the generated responses and re-retrieve or re-generate response.


![[../assets/image/RAG from scratch by Langchain-1717730557773.jpeg]]

# Main components of [[Retrieval Augmented Generation (RAG)]]

- Query construction: construct the query appropriately
	- Text-to-SQL for relational DB queries
	- text-to-Cypher for Graph DBs
	- self-query retrieval for vector DB queries
- Query translation: translate the question into a form that is better suited for retrieval
	- Problems
	- Solutions
		- Rephrase user query
	- **Multi-query**: convert a single query into multiple queries
	- RAG-Fusion
	- **Query decomposition (break-down)**: break down a query into its component parts, e.g. "what are the latest news articles about the founder of OpenAI?" breaks down into "who was the founder of OpenAI?" and "what are the latest news articles about Sam Altman?"
	- **Step-back (abstraction)**: take a step back and get a more holistic view of the query, e.g. "Where was Sam Altman born?" translates to "What's the personal background of Sam Altman?"
	-  **HyDE**: Create a hypothetical answer document from the query, and use that hypothetical answer document for retrieval so that you search the answer space instead of the query space
- Routing: route the query to the right database when dealing with multiple databases
	- Logical routing
	- Semantic routing
- Indexing
	- Chunk optimization: character based chunking, recursive character based chunking, delimiter based chunking, semantic chunking
	- Multi-representation indexing: Convert documents into compact retrieval units (e.g. document summaries)
	- Specialized embeddings: domain specific embedding models, e.g. ColBERT 
	- Hierarchical indexing: Include hierarchical summary documents together with the raw documents in the vector DB, e.g. RAPTOR
- Retrieval
	- Ranking: rank or filter documents based on relevance, e.g. re-rank, RankGPT, RAG-Fusion
	- Refinement: e.g. CRAG
	- Active retrieval: re-retrieve and / or retrieve from new data sources (e.g. web) if retrieved documents are not relevant
- Generation
	- Active retrieval: use generation quality to inform question re-writing and / or re-retrieval of documents, e.g. Self-RAG, RRR



