---
source-title: RAG From Scratch: Part 2 (Indexing)
source-url: https://youtube.com/watch?v=bjb_EMsTDKI

source-mediatype: video
source-platform: YouTube

source-youtube-video-id: bjb_EMsTDKI
source-youtube-channel-id: UCC-lyoTfSrcJzA1ab3APAgw
source-youtube-channel-name: LangChain
---

## Summary (AI)
TLDR: The video is the second in a series on building a system from scratch, focusing on indexing. Indexing involves loading external documents into a retriever to find related documents based on input questions. This is done by transforming text documents into numerical representations for easier searching. Different methods like sparse vectors and embedding models are used for this purpose.

Key points:
- Indexing involves loading external documents into a retriever to find related documents based on input questions.
- Documents are transformed into numerical representations to establish relevance or similarity.
- Methods like sparse vectors and embedding models are used for efficient searching.
- Embedding models compress documents into fixed-length vectors to capture semantic meaning.
- Code walkthrough showcases how to compute tokens, embed documents, and compare them using cosine similarity.
- Documents are split, embedded, and indexed in a Vector store for retrieval.
- Retrieval involves searching the Vector store for relevant documents based on input questions.

## Video description
Error retrieving description for video bjb_EMsTDKI

## Video transcript
hi this is Lance from Lang chain this the second video in our series rack from scratch focused on indexing so in the past video you saw the main kind of overall components of rag pipelines indexing retrieval and generation and here we're going to kind of Deep dive on indexing and give just a quick overview of it so the first aspect of indexing is we have some external documents that we actually want to load and put into what we're tring to call a retriever and the goal of this retriever is simply given an input question I want to fish out documents that are related to my question in some way now the way to establish that relationship or relevance or similarity is typically done using some kind of numerical representation of documents and the reason is that it's very easy to compare vectors for example of numbers uh relative to you know just free form text and so a lot of approaches have been developed over the years to take text documents and compress them down into a numerical representation that then can be very easily searched now there's a few ways to do that so Google and others came up with many interesting statistical methods where you take a document you look at the frequency of words and you build what they call sparse vectors such that the vector locations are you know a large vocab of possible words each value represents the number of occurrences of that particular word and it's spse because there's of course many zeros it's a very large vocabulary relative to what's present in the document and there's very good search methods over this this type of numerical representation now a bit more recently uh embedding methods that are machine learned so you take a document and you build a compressed fixed slank representation of that document um have been developed with correspondingly very strong search methods over embeddings um so the intuition here is that we take documents and we typically split them because embedding models actually have limited context windows so you know on the order of maybe 512 tokens up to 8,000 tokens or Beyond but they're not infinitely large so documents are split and each document is compressed into a vector and that Vector captures a Mantic meaning of the document itself the vectors are indexed questions can be embedded in the exactly same way and then a numerical kind of comparison in some form you know using very different types of methods can be performed on these vectors to fish out relevant documents relative to my question um and let's just do a quick code walkr on some of these points so I have my notebook here I've installed here um now I've set a few API keys for lsmith which are very useful for tracing which we'll see shortly um previously I walked through this this kind of quick start that just showed overall how to lay out these rag pipelines and here what I'll do is I'll Deep dive a little bit more on indexing and I'm going to take a question and a document and first I'm just going to compute the number of tokens in for example the question and this is interesting because embedding models and LMS more generally operate on tokens and so it's kind of nice to understand how large the documents are that I'm trying to feed in in this case it's obviously a very small in this case question now I'm going to specify open eye embeddings I specify an embedding model here and I just say embed embed query I can pass my question my document and what you can see here is that runs and this is mapped to now a vector of length 153 6 and that fixed length Vector representation will be computed for both documents and really for any documents so you're always kind of computing this fixed length Vector that encodes the semantics of the text that you've passed now I can do things like cosine similarity to compare them and as we'll see here I can load some documents this is just like we saw previously I can split them and I can index them here just like we did before but we can see under the hood really what we're doing is we're taking each split we're embedding it using open eye embeddings into this kind of this Vector representation and that's stored with a link to the rod document itself in our Vector store and next we'll see how to actually do retrieval using this Vector store
