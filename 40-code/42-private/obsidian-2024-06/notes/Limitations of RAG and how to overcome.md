[[Retrieval Augmented Generation (RAG)]]

## Classic RAG

Standard RAG ([source](https://gradientflow.com/wp-content/uploads/2023/10/newsletter87-RAG-simple.png)): 
![[../assets/image/Limitations of RAG and how to overcome-1719079218596.jpeg]]

Retrieval Augmented Generation (RAG) can be broken down into four distinct modules, each of which can be further optimized by various techniques:

- **Query handling**: 
- **Indexing**: 
- **Retrieval**: 
- **Generation**: 

![[../Excalidraw/Limitations of RAG and how to overcome 2024-06-22 11.00.53.excalidraw]]

Problems and solutions

- **Query handling**: 
	- Problems
		- User queries may be unclear, ambiguous, or framed in a way that negatively impacts retrieval.
	- Solutions
		- Re-constructing the user's query into a more suitable form for retrieval
		- Query decomposition (break-down): ""
		- Step-back querying (abstraction): 
- **Indexing**: Storing and organizing the knowledge base such that it is optimized for retrieval, e.g. semantic chunking, hierarchical indexing.
	- Problems
		- Index cannot retrieve the right context
		- Required context is spread across too many places
		- Required context needs higher level understanding
		- Classic RAG cannot reason across multiple long documents, e.g. "what are the common themes across all the 10-K's in the past 5 years?"
	- Solutions
		- Advanced chunking: e.g. semantic chunking 
		- Advanced indexing: multi-representation indexing: 
			- storing raw documents separately and creating summaries optimized for search; vector store for summaries and a document store for full documents
		- Advanced indexing: e.g [RAPTOR: Recursive Abstractive Processing for Tree-Organized Retrieval](https://arxiv.org/html/2401.18059v1)
			- clustering similar documents, summarizing each cluster, and recursively building a hierarchical index of document summaries
- **Retrieval**: Retrieving the most relevant information from the knowledge base to answer the user's query, e.g. filtering and re-ranking.
	- Problems
		- Retrieved documents are not helpful for answering the query
		- Choosing the K Value: Determining the optimal number of nearby neighbors (K) to retrieve relevant documents without overwhelming the system with too much or too little data.
	- Solutions
		- Solution: Experiment with different K values to find the balance that best retrieves relevant documents
		- HyDe: Hypothetical document embedding
			- ○Original prompt: What are some considerations when building an LLM agent?
			- ○Reconstructed prompt (Hypothetical Document): This paper explores the key considerations and best practices for designing and implementing LLM-based agents. We discuss topics such as agent architecture, prompt engineering, memory management, and safety considerations. Our analysis provides insights for developers aiming to build robust and reliable LLM agents for various applications.

- **Generation**: Using the retrieved information to generate the most useful response to the user's query, e.g. evaluating the generated responses and re-retrieve or re-generate response.
	- Problems
		- **Hallucination**: Generated response is not grounded in the retrieved context
		- **Irrelevance**: Generated response does not directly answer the question
	- Solutions
		- Monitoring and evaluation pipeline
		- Self-Reflective Retrieval-Augmented Generation (Self-RAG)
		- 