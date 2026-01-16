---
id: 8f4a2366-24d7-11ef-b7c7-3f1022b4971b
---

# LLMs Turn Every Question Into an Answer
Tags: #Omnivore

[Read on Omnivore](https://omnivore.app/me/ll-ms-turn-every-question-into-an-answer-18ff3087dd5)
[Read Original](https://every.to/chain-of-thought/llms-turn-every-question-into-an-answer)


## Content
[ ![](https://proxy-prod.omnivore-image-cache.app/84x24,sgwXMkmq-FqseYZAcYK7ZllpdQHHjHnOKEWG_WLlobHo/https://d24ovhgu8s7341.cloudfront.net/static/every-logo.png) ](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vIiwicG9zaXRpb24iOjB9) 

[ Chain of Thought ](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vY2hhaW4tb2YtdGhvdWdodCIsInBvc2l0aW9uIjoxfQ==) 

## [Part two: Language models as text expanders](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vY2hhaW4tb2YtdGhvdWdodC9sbG1zLXR1cm4tZXZlcnktcXVlc3Rpb24taW50by1hbi1hbnN3ZXIiLCJwb3NpdGlvbiI6M30=) 

by [Dan Shipper](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vQGRhbnNoaXBwZXIiLCJwb3NpdGlvbiI6NH0=)

![](https://proxy-prod.omnivore-image-cache.app/600x0,scAhNC55FEhU7ZB5Z5fc1hoa4ycAfDCx1LEU6BXqTquw/https://d24ovhgu8s7341.cloudfront.net/uploads/post/cover/3122/F-Cover.png) 

DALL-E/Every illustration.

#### Sponsored By: Reflect

This essay is brought to you by [Reflect](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vcmVmbGVjdC5hcHAvP3V0bV9zb3VyY2U9ZXZlcnlcdTAwMjZ1dG1fbWVkaXVtPXNwb25zb3JzaGlwXHUwMDI2dXRtX2NhbXBhaWduPW1heTIwMjQiLCJwb3NpdGlvbiI6NSwiYWR2ZXJ0aXNlbWVudF9pZCI6Njg2fQ==), an ultra-fast notes app with an AI assistant built in directly. Simplify your note-taking with Reflect's advanced features, like custom prompts, voice transcription, and the ability to chat with your notes effortlessly. Elevate your productivity and organization with Reflect.

[Try Reflect](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vcmVmbGVjdC5hcHAvP3V0bV9zb3VyY2U9ZXZlcnlcdTAwMjZ1dG1fbWVkaXVtPXNwb25zb3JzaGlwXHUwMDI2dXRtX2NhbXBhaWduPW1heTIwMjQiLCJwb3NpdGlvbiI6NiwiYWR2ZXJ0aXNlbWVudF9pZCI6Njg2fQ==) 

_This is the second in a five-part series I’m writing about redefining human creativity in the age of AI. Read my first piece about_ [_language models as text compressors_](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vY2hhaW4tb2YtdGhvdWdodC93aGF0LWNhbi1sYW5ndWFnZS1tb2RlbHMtYWN0dWFsbHktZG8iLCJwb3NpdGlvbiI6OH0=)_, and my prequel about_ [_how LLMs work_](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vY2hhaW4tb2YtdGhvdWdodC9ob3ctbGFuZ3VhZ2UtbW9kZWxzLXdvcmsiLCJwb3NpdGlvbiI6OX0=)_._

_Was this newsletter forwarded to you?_ [_Sign up_](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vYWNjb3VudCIsInBvc2l0aW9uIjoxMH0=) _to get it in your inbox._

---

You can’t get energy for free. It can be neither created nor destroyed, just moved around. 

That's more or less what computers were able to do with text on their own for a long time. Barring a disk failure, text was always conserved, often moved around, sometimes crudely transformed. 

But they almost never created it. Other than doing a spell check, if you were seeing text on a computer, it was probably because some human, somewhere, had typed it.

Language models changed this entirely. 

Now, you and I can type a few sentences into ChatGPT and watch it expand, character by character, line by line, into something new—composed out of thin air, just for you. Language models take your text and stretch it into a different shape, like glass heated and blown through a tube. 

What had previously been an inert collection of bits—a line of characters extending across a screen—is now something different, something potentially alive. When you feed a piece of text to a language model, the text is like an acorn turning into a tree. The acorn itself contains instructions for the tree it will become, and the language model becomes rich dirt, water, and warm summer sun.

In short, language models are free energy for text. Let’s talk about how we can use that function for creative purposes.

Transform the way you take notes with [Reflect](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vcmVmbGVjdC5hcHAvP3V0bV9zb3VyY2U9ZXZlcnlcdTAwMjZ1dG1fbWVkaXVtPXNwb25zb3JzaGlwXHUwMDI2dXRtX2NhbXBhaWduPW1heTIwMjQiLCJwb3NpdGlvbiI6MTEsImFkdmVydGlzZW1lbnRfaWQiOjY5MX0=), the ultra-fast notes app with a baked-in AI assistant. Whether you're jotting down ideas or organizing detailed information, Reflect's custom prompts and voice transcription make the process a breeze. You can even chat with your notes, making your workflow more dynamic and efficient. Reflect adapts to your needs, offering unparalleled convenience. Elevate your productivity today.

[Try Reflect](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vcmVmbGVjdC5hcHAvP3V0bV9zb3VyY2U9ZXZlcnlcdTAwMjZ1dG1fbWVkaXVtPXNwb25zb3JzaGlwXHUwMDI2dXRtX2NhbXBhaWduPW1heTIwMjQiLCJwb3NpdGlvbiI6MTIsImFkdmVydGlzZW1lbnRfaWQiOjY5MX0=) 

## A world where every question contains an answer

Language models create a world where every question can be expanded into an answer. 

This is critical for creativity because asking questions is a uniquely human thing to do. 

Apes, for example, share many human characteristics, including their social nature and a proto-culture that allows them to pass some of what they learn on to their offspring. But they are different from humans in at least one important respect: Apes don’t ask questions. 

Question-asking creates room for answers, and answers create room for more questions. This is the first step to getting new ideas and building new things.

Over the centuries, if an answer to a question exists, it’s become increasingly findable for the questioner. Books can answer questions so long as you have the wherewithal to search through them. Google brought us even closer: Many of our most common questions became just a search query away. 

But there are certain of humanity’s answers that have heretofore remained stubbornly unGoogleable. Google only has answers to questions that have already been asked and answered before. For example, try Googling “does Dan Shipper express any skepticism about AI?” I bet you’ll have a difficult time finding a succinct answer.

Language models love questions like this, though:

[![](https://proxy-prod.omnivore-image-cache.app/600x0,sw82Gmd-0WzK7JNcuVVoLDlf1WUzR_5Un30J4tKlJ6WQ/https://d24ovhgu8s7341.cloudfront.net/uploads/editor/posts/3122/optimized_AD_4nXejHQrZPd7XdqkgTxhN29RhLKp5hSNmDtKURkHj_wP3E8nsbaqjPzH4Hxn1V6V5HQS-9IS64uqhlEyTWJ_s-Y6i_6d2SFeqK-gIiubikssXj-4Cn4LWnUo7.png)](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZDI0b3ZoZ3U4czczNDEuY2xvdWRmcm9udC5uZXQvdXBsb2Fkcy9lZGl0b3IvcG9zdHMvMzEyMi9vcHRpbWl6ZWRfQURfNG5YZWpIUXJaUGQ3WGRxa2dUeGhOMjlSaExLcDVoU05tRHRLVVJrSGpfd1AzRThuc2JhcWpQekg0SHhuMVY2VjVIUVMtOUlTNjR1cWhsRXlUV0pfcy1ZNmlfNmQyU0ZlcUstZ0lpdWJpa3NzWGotNENuNExXblVvNy5wbmciLCJwb3NpdGlvbiI6MTR9)

_All screenshots courtesy of the author._

They expand any question into an answer. Because language models always predict what comes next in a sequence, the question itself points to the beginning of its answer. 

Anyone who spends time around children and listens to the ceaseless questions they ask will know why this is so important. In the past, a question implied a quest to find an answer. Today, questions are answers already—all they need is expansion through language models. 

Let’s talk about some of the most useful kinds of expansions.

## Language models as comprehensive expanders

If you want to get a comprehensive understanding of any broad domain of human knowledge, language models can help. Comprehensive expansions from language models are a lot like your own personal Wikipedia written in real time about whatever topic you care most about. 

“Tell me about the history of kings in the Roman Empire.” 

“What do I do if I find a tick on my arm?”

“What are the top strategies for pricing negotiations with enterprise customers?”

Comprehensive expansions are high-level basic explainers, not modified for any specific intended audience, but pitched to everyone.

These questions could be answered with varying levels of speed and quality prior to ChatGPT, but, I would argue, ChatGPT and other AI models are far better resources. First, because they’re fast. And second, because you can ask follow-up questions.

Which gets us to the next kind of expansion: contextual expansions.

[Subscribe to Every](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vc3Vic2NyaWJlIiwicG9zaXRpb24iOjE1fQ==)

## Language models as contextual expanders

Information becomes knowledge when it is fitted into a particular context. ChatGPT excels at expanding a question into an answer that is most relevant for a specific amount of attention, background knowledge, sensibility, and circumstance.

A large part of creative work is about consuming the raw input you need in order to do your work. Often this includes reading primary sources that are difficult to understand. But AI can expand a specific question about a source into an article written just for you. 

I actually used Claude in this way in order to prepare for [my interview with LinkedIn cofounder Reid Hoffman](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vY2hhaW4tb2YtdGhvdWdodC9yZWlkLWhvZmZtYW4tb24taG93LWFpLW1pZ2h0LWFuc3dlci1vdXItYmlnZ2VzdC1xdWVzdGlvbnMiLCJwb3NpdGlvbiI6MTZ9). I asked it to explain one of the main points of Austrian philosopher Ludwig Wittgenstein’s philosophy of language classic _Tractatus Logico Philosophicus_:

[![](https://proxy-prod.omnivore-image-cache.app/600x0,smg9sD2E60QhTE_WbCXQq5oqMF5sK2xyqAYkndr_o6q4/https://d24ovhgu8s7341.cloudfront.net/uploads/editor/posts/3122/optimized_Wittgenstein's%20picture%20theory%20of%20meanins%20which%20he%20presented%20in%20his%20early%20work%20Tractatus.png)](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZDI0b3ZoZ3U4czczNDEuY2xvdWRmcm9udC5uZXQvdXBsb2Fkcy9lZGl0b3IvcG9zdHMvMzEyMi9vcHRpbWl6ZWRfV2l0dGdlbnN0ZWluJ3MlMjBwaWN0dXJlJTIwdGhlb3J5JTIwb2YlMjBtZWFuaW5zJTIwd2hpY2glMjBoZSUyMHByZXNlbnRlZCUyMGluJTIwaGlzJTIwZWFybHklMjB3b3JrJTIwVHJhY3RhdHVzLnBuZyIsInBvc2l0aW9uIjoxN30=)

This is a good, comprehensive expansion of my question. But it’s high-level and abstract. If I want something more tuned to who I am, I can ask a follow-up, like:

[![](https://proxy-prod.omnivore-image-cache.app/600x0,so4rwQlgqZ9h3MhDbrhpQcTT6HdgxUdJhU9F9v5SR2uA/https://d24ovhgu8s7341.cloudfront.net/uploads/editor/posts/3122/optimized_facts.%20They%20are%20the%20simplest,%20mos%20basic%20statements%20we%20can%20make%20about%20the%20world%20that%20can.png)](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZDI0b3ZoZ3U4czczNDEuY2xvdWRmcm9udC5uZXQvdXBsb2Fkcy9lZGl0b3IvcG9zdHMvMzEyMi9vcHRpbWl6ZWRfZmFjdHMuJTIwVGhleSUyMGFyZSUyMHRoZSUyMHNpbXBsZXN0LCUyMG1vcyUyMGJhc2ljJTIwc3RhdGVtZW50cyUyMHdlJTIwY2FuJTIwbWFrZSUyMGFib3V0JTIwdGhlJTIwd29ybGQlMjB0aGF0JTIwY2FuLnBuZyIsInBvc2l0aW9uIjoxOH0=)

You could answer this question yourself by Googling, but AI brings the best of what you need to know to bear all at once in the form that’s right for you. (If you didn’t find Claude’s explanation useful, you can always ask it to rephrase the answer in a way that clicks with your brain instead of mine.)

This is more important than it might seem. 

When I was in third grade, I had designs on writing a novel, so I wanted to learn creative writing. There was only one problem: My mom couldn’t find any creative writing classes for kids my age. They didn’t exist, except for older kids. And my parents didn’t know enough themselves to teach me.

There’s an incredible amount of power in being able to expand a question like, “How can I level-up my creative skills? I’m 9 years old,” into an age-appropriate answer for kids. 

This doesn’t just apply to factual expansions. AI is also quite good at creative expansions.

## Language models as creative expanders

When I’m looking for a metaphor or a simile in my writing, the first thing I do is go to ChatGPT or Claude and ask it to output 20 of them. 

For example, in my [piece](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vY2hhaW4tb2YtdGhvdWdodC95b3UtaGF2ZS1uby1jaG9pY2UtYnV0LXRvLXJlYWQtdGhpcz9zaWQ9NDc4MTYiLCJwb3NpdGlvbiI6MTl9) about about Robert Sapolsky’s free-will book _Determined_, I wrote:

> “I fucking love Robert Sapolsky, a Stanford neuroscientist whose books on biological behavior and stress, _Why Zebras Don’t Get Ulcers_, _A Primate’s Memoir_, and _Behave_, are some of the best science writing I’ve ever read. He is, in my opinion, the poet laureate of neurobiology. He is at once rigorous and humanistic, sardonic and compassionate, literary and scientific.

> So you must be able to imagine my conflicting feelings upon learning that he wrote a new book (yay!) about free will (yuck!) called _Determined_. It’s like Scott Alexander writing a 10,000-word essay on the correct way to hang toilet paper. It’s like Annie Dillard writing a new book on whether or not a hot dog is, in fact, a sandwich. It’s like Bill Simmons writing a trilogy about whether Die Hard is really a Christmas movie. (Okay, okay, I’d read that.)”

Guess where those similes came from? An entertaining 20-minute-long session with Claude, during which it helped me both identify what I was feeling about Sapolsky’s book and find a few great similes to express it clearly.

Creative expansions are the truly generative part of generative AI. They make it easy to traverse a space of possibilities. 

You can go one word at a time, like generating a simile. But you can also create entire stories from a simple prompt. Many of the parents I know are already using ChatGPT on voice mode to create custom stories for their children, weaving in characters from pop culture with their kids’ lives and interests to create stories that are made just for them. 

The ability to cheaply explore creative possibilities is one of the most important uses of language models for creative work. It’s not entirely effortless on our part: We do have to put our taste to work—ask for what we’re looking for, and recognize it when we get it. But it does a lot of the legwork for us. 

It’s easier for humans to edit than it is to generate, and we don’t always have the energy to filter through all of the possibilities we might want to in order to find the precise word, the brightest idea, or the best plot twist. Creative expansions help us map the possibility space so we can bring the best of what we find back to our work. 

## Compressing and expanding

Many of the expansion operations I wrote about earlier in this piece serve a similar purpose as the [compression operations](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vY2hhaW4tb2YtdGhvdWdodC93aGF0LWNhbi1sYW5ndWFnZS1tb2RlbHMtYWN0dWFsbHktZG8iLCJwb3NpdGlvbiI6MjB9) I wrote about previously. For example, you can answer a question through expansion or contraction. Which should you pick, and why?

Contraction is like squeezing a lemon into lemon juice. At the end of the squeeze, what’s in your cup is likely to only contain what was in the lemon.

Expansion is more unpredictable. Returning to the acorn metaphor: In general, an acorn is going to produce a tree. But the characteristics of that tree will largely depend on the circumstances of the acorn’s growth. There’s a much higher degree of freedom in terms of the final product with an acorn than a squeezed lemon.

Language model compression is more likely to return a factual response based on the prompt you give it, assuming that answer is found in the text you are compressing. When I built [my _Huberman Lab_ chatbot](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vY2hhaW4tb2YtdGhvdWdodC9pLXRyYWluZWQtYS1ncHQtMy1jaGF0Ym90LW9uLWV2ZXJ5LWVwaXNvZGUtb2YtbXktZmF2b3JpdGUtcG9kY2FzdD9zaWQ9NDc4MTgiLCJwb3NpdGlvbiI6MjF9), I inputted the transcripts of his episodes into ChatGPT in each prompt because they keep the model grounded in what he actually said. (This is a common technique called Retrieval-Augmented Generation, or RAG.)

By comparison, language model expansion is more creative and poetic. It’ll do a good job of responding factually to common questions. But it shines when it’s asked to go off the beaten path and find previously unexplored possibilities. 

When I was trying to find similes for my Robert Sapolsky book review, I didn’t load his entire book into ChatGPT. I just tried to express, briefly, what I was feeling: “I’m writing a review of Robert Sapolsky’s book about free will, and I want to find a few similes to express it. I feel bored and excited about it at the same time. Generate 20.”

I let the language model do the rest. After it returned its first 20, I gave it more instructions and had it generate more. 

It wasn’t about answering a precise question about his book. It was about exploring possibilities.

## The new world of text expansion

In a world where computers can expand text, inside of every question hides an answer, and every story is written for you. Text expansion is creative and somewhat unreliable, but that’s what makes it exciting. It is lighting a rocket and watching it shoot into the sky. It is dropping a penny off a bridge and peering over the railing to see what happens. 

We create conditions and then step back to watch the show. It’s an undeniably powerful part of any creative arsenal.

So, go forth and expand! 

We’ll be back next week with the third part of this series: translation.

---

**_Dan Shipper_** _is the cofounder and CEO of Every, where he writes the_ [_Chain of Thought_](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vY2hhaW4tb2YtdGhvdWdodCIsInBvc2l0aW9uIjoyMn0=) _column and hosts the podcast_ [AI & I](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vb3Blbi5zcG90aWZ5LmNvbS9zaG93LzVxWDFuUlRhRnNmV2RtZGo1SldPMUciLCJwb3NpdGlvbiI6MjN9). _You can follow him on X at_ [_@danshipper_](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vdHdpdHRlci5jb20vZGFuc2hpcHBlciIsInBvc2l0aW9uIjoyNH0=) _and on_ [_LinkedIn_](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vd3d3LmxpbmtlZGluLmNvbS9pbi9kYW5zaGlwcGVyLyIsInBvc2l0aW9uIjoyNX0=)_, and Every on X at_ [_@every_](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vdHdpdHRlci5jb20vZXZlcnkiLCJwb3NpdGlvbiI6MjZ9) _and on_ [_LinkedIn_](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vd3d3LmxpbmtlZGluLmNvbS9jb21wYW55L2V2ZXJ5aW5jLyIsInBvc2l0aW9uIjoyN30=)_._

[Join 70,000+ readers of the best tech writing on the internet](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vc3Vic2NyaWJlIiwicG9zaXRpb24iOjI4fQ==)

#### What did you think of this post?

[ Amazing](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vY2hhaW4tb2YtdGhvdWdodC9sbG1zLXR1cm4tZXZlcnktcXVlc3Rpb24taW50by1hbi1hbnN3ZXIvZmVlZGJhY2s%5FcmF0aW5nPWFtYXppbmdcdTAwMjZoYXNoPSVyZWNpcGllbnQuaGFzaCUiLCJwb3NpdGlvbiI6Mjl9) [ Good](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vY2hhaW4tb2YtdGhvdWdodC9sbG1zLXR1cm4tZXZlcnktcXVlc3Rpb24taW50by1hbi1hbnN3ZXIvZmVlZGJhY2s%5FcmF0aW5nPWdvb2RcdTAwMjZoYXNoPSVyZWNpcGllbnQuaGFzaCUiLCJwb3NpdGlvbiI6MzB9) [ Meh](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vY2hhaW4tb2YtdGhvdWdodC9sbG1zLXR1cm4tZXZlcnktcXVlc3Rpb24taW50by1hbi1hbnN3ZXIvZmVlZGJhY2s%5FcmF0aW5nPW1laFx1MDAyNmhhc2g9JXJlY2lwaWVudC5oYXNoJSIsInBvc2l0aW9uIjozMX0=) [ Bad](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vY2hhaW4tb2YtdGhvdWdodC9sbG1zLXR1cm4tZXZlcnktcXVlc3Rpb24taW50by1hbi1hbnN3ZXIvZmVlZGJhY2s%5FcmF0aW5nPWJhZFx1MDAyNmhhc2g9JXJlY2lwaWVudC5oYXNoJSIsInBvc2l0aW9uIjozMn0=) 

#### Thanks to our Sponsor: Reflect

Thanks again to our sponsor [Reflect](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vcmVmbGVjdC5hcHAvP3V0bV9zb3VyY2U9ZXZlcnlcdTAwMjZ1dG1fbWVkaXVtPXNwb25zb3JzaGlwXHUwMDI2dXRtX2NhbXBhaWduPW1heTIwMjQiLCJwb3NpdGlvbiI6MzMsImFkdmVydGlzZW1lbnRfaWQiOjY4M30=), an ultra-fast notes app with an AI assistant built directly in. With features like custom prompts, voice transcription, and effortless note-chatting, Reflect redefines note-taking. Stay organized and boost your productivity. 

[Try Reflect](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiTExNcyBUdXJuIEV2ZXJ5IFF1ZXN0aW9uIEludG8gYW4gQW5zd2VyIiwicG9zdF9pZCI6MzEyMiwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vcmVmbGVjdC5hcHAvP3V0bV9zb3VyY2U9ZXZlcnlcdTAwMjZ1dG1fbWVkaXVtPXNwb25zb3JzaGlwXHUwMDI2dXRtX2NhbXBhaWduPW1heTIwMjQiLCJwb3NpdGlvbiI6MzQsImFkdmVydGlzZW1lbnRfaWQiOjY4M30=)
