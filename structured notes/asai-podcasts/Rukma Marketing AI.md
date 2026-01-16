---
aliases: 
related-notes: 
tags: 

fileClass: class-asai-episode
templater-template: 

asai-episode-id: 
asai-episode-title: 
asai-publish-date: 

asai-episode-link-youtube: https://youtu.be/1koI0Xx29og
asai-episode-link-spotify: https://podcasters.spotify.com/pod/show/art-science-ai/episodes/S2-E8-Mastering-AI-for-Marketing--Rukma-Sen--Google-AI-Product-Marketing-Manager-e2ndjs1
asai-episode-link-apple: 
asai-episode-link-substack: https://artscienceai.substack.com/p/s2-e8-mastering-ai-for-marketing-rukma-sen
---


# Pre-episode Notes

# Editing
Full episode
- [x] Rename studio recording to episode title > generate full episode edit
- [x] Set pace: 1.5s + pause (DO NOT remove filler)
- [x] Intro + outro clips (incl. cutting filler)
- [x] Orientation: Nikhil on left / top
- [x] Remove captions
- [x] Download subtitles
- [x] Export > Normalize audio + remove background noise

Shorts
- [ ] Orientation: Nikhil on left / top
- [ ] Captions > Background, Poppins Bold, medium, boxed, Red highlight > in middle
- [ ] Export > Normalize audio + remove background noise

# Episode Transcript
Nikhil Maddirala (00:10)
Hey, and welcome to the Art and Science of AI, podcast about the science of how AI works and the art of using AI to reimagine your life, business, and society. I'm Nikhil, one of your hosts. I'm an AI product manager, and I love talking about AI.

Piyush (00:28)
I'm Piyush, your other host, and I also love talking about AI. And I'm very, very excited today because we have a special guest joining our podcast today, our very first guest. And there are many reasons why this is a special episode, not the least because Rukma is an amazing, amazing person and very, impressive at what she does. She's an AI marketing manager at Google, but also because Nikhil and Rukma are my best friends. They're actually like family at this point.

Nikhil and Rukma are married to each other. And so we're very, excited about that. And Rukma, thank you so much for joining our podcast and being our first guest. What Nikhil and I want to learn from you today is how you, as a marketer, use AI in your daily life. What are some of the tools that you use? So yeah, we'd love to learn. Because we do this. Before this, I talked a little bit about how I use.

AI in my sales job. So I think that's always very insightful to learn how different people are using AI, specifically LLMs, in their job roles. So please tell us a little bit about that. But before you jump into that, it's going to be a little weird for you to do this for Nikhil and I, because we obviously know who you are and what your background is. But if you don't mind sharing just your brief background journey and how you came to be a marketing manager at Google.

Rukma Sen (01:51)
Yeah, absolutely. Well, first of all, thank you so much for having me on. I'm really excited to chat about AI with the both of you. I was there when you recorded your first podcast, and it was just so exciting to watch that conversation and to see this podcast take off from that has been really awesome. So like you mentioned, I am an AI PMM at Google Cloud right now. I focus on Google Cloud's AI technology specific

lead for developers. So this includes products like Vertex AI, like Google Cloud AI Studio, like Gemini API, and a whole set of kind of open source models and frameworks and things that Google is developing specifically to help developers. Before this, I was working at Chrome OS, where I was focused on marketing for Chrome OS Enterprise, specifically telling kind of the story of, you know, the benefits of things.

like cybersecurity, management, all of that. Previous to that, I was at Square and I started actually my career at Microsoft as a product marketer for cybersecurity incubations. There's a part of me that still loves cybersecurity and I'm hoping to return to it, maybe the intersection of security and AI at some point in time. But in my latest role, I have been lucky.

enough to really get to see some extremely cool products and use cases that one can build with AI and also get to try some of them to apply it in my marketing job and really play around with the prompts and kind of push everything to see the limits of how much can this really help me, where does it break down, how do I fix it, those kinds of things. So super excited to have this chat with you today.

Nikhil Maddirala (03:49)
And you also have some experience with AI prior to your professional experience, right? Back when you were a student, do you want to talk about that?

Piyush (03:49)
Great.

Rukma Sen (03:57)
Yes, that is true. So actually my experience with AI does start when I was in college. I worked as someone who labeled data sets essentially for a lot

machine learning model. This was specifically in the realm of the digital humanities and my advisor was the primary investigator on a project that was trying to use computational methods to analyze medieval manuscripts. So when it comes to an area that's like so kind of specific you need

people who have some subject matter expertise to do data labeling. So actually I spent two summers doing data labeling for medieval manuscripts and could talk for a couple of podcast episodes at least about that. But today we'll focus on AI.

Nikhil Maddirala (04:45)
very cool.

Piyush (04:47)
Sounds great. I'm very excited. Let's jump into it.

Piyush (04:48)
Nikhil and I both would love to learn from you how you as a marketer

use AI in your daily life on your job? And what are the different tools you've come across that you like using? And yeah, just help us understand how you use AI in the world of marketing.

Rukma Sen (05:05)
Yeah, I since these tools, I would say were really launched in a big way on the market, just kind of playing around with ways that it improve my workflow. So I'd be happy to sort of jump a little bit into that. But maybe before we start, we can talk a little bit about what kinds of different skills or capabilities even fall under marketing. Because I think a lot of these pieces, many people with many kinds of jobs would find use for and it's not just

just someone who has an official title of marketing.

Piyush (05:39)
Yeah, actually that's a good one because I was also wondering how does, what is product marketing exactly? Maybe you can start there and how is that different from general marketing?

Rukma Sen (05:50)
That's a good question and I'm laughing a little because product marketing is defined just extremely differently by different companies, even within companies, different teams, different kind of products will have different needs at any given point in time and so product marketing kind of morphs to to fit what is needed at any given point in time. But I would say the headline that I like to think about product marketing as is product marketing owns the story of the product.

and fitting that story or bringing that story to the right audiences. So that's kind of like how I think about it. I'm not sure if that makes sense, if it resonates with you. What do you think?

Piyush (06:35)
Yeah, I mean, that does resonate with me. Can you maybe give me an example? So what would that mean in the context of any of the products that you have worked on before? Like, help me understand what the story was and how you guys found the story and how you brought it alive.

Rukma Sen (06:49)
Yeah, so I'll use the example of Chrome OS where I used to work until just about half a year ago. So Chrome OS for enterprise is a whole set of products. It's a console that makes it easy and simple for IT managers to manage things like access, security, et cetera, all of these pieces that if you're running a company, you need to be able to manage for your employees. So what is the story there?

the answer to that is not so simple like that even just finding out hey what is the story of this product

can be quite interesting. And I actually have a framework I use, which comes from root cause analysis called the 5Y framework, where when I'm having an interview with a product manager or an engineer who has built something, I will kind of keep asking why or trying to get to the root cause until we come up with a very human benefit. So it saves you time and helps you get home to your children or your priorities as a very human benefit.

I made this setting do this thing 20 seconds more quickly and reduced lag time is not so easy to quickly understand that hey this is what the actual benefit is.

Piyush (08:09)
Right.

Rukma Sen (08:10)
It's interesting actually that you mentioned this because I programmed one of the custom GPT options or gems as we've seen internally at Google and was announced at IO, which are basically like custom versions of Gemini that can help you to do this. I programmed one to anytime I say, help me create messaging for insert X product. It keeps asking me why that matters or why that matters to the

audience until it feels good about this is like a human benefit and that is pre -programmed in my system instructions so I told it hey don't stop asking the user why that matters until you get to

Piyush (08:53)
That is very smart. I think this is the first time, Nikhil, have you heard of this type of a use case before where most of the times when we've discussed interactions with GPT or Gemini, it's the user asking the LLM. Rukma, what you've done is you've flipped it on its head. You're making the LLMs ask you questions. That's a very interesting, very innovative approach.

Nikhil Maddirala (09:15)
Yeah, for sure. think because a lot of the times when you interact with AI, it starts giving you answers before fully understanding what it is that you're trying to do or what you want. And often I find that I have to stop it and say, hey, don't go further. Let's clarify this first. But I think this is a really interesting approach where you can ask the AI to know that,

you need to first ask questions to clarify before doing anything. And yeah, would love to learn more about how you're doing that.

Piyush (09:48)
Yeah, mean, that's really, I mean, that's very smart. That's very, I'm gonna do that. That's amazing.

Rukma Sen (09:53)
So this is, funny because we've hit on somewhat of a soapbox topic for me. I'm always telling people, whoever talks to me about LLMs, that getting the LLM to ask you questions is just an infinitely useful thing because when we were in business school, I don't know if you did this at your business school, Piyush, but we had this communications class where they taught us about this Johari window where there's information about yourself that you know, information about you that the other person

knows information the other person has that you don't know information that both of you kind of don't know or kind of I think in a more in a less communications oriented context I think in the data science world it's sometimes called as unknown unknowns so I think interacting with LLMs because it's such a new world there's a lot of unknown

like you don't know what context you need to give it really. It doesn't always know what to ask you. So I think making that unknown unknown piece very explicit that hey keep asking your user questions until you get like an understanding of this A, B, C, D, E, F, G thing is super helpful. Yeah this is...

Nikhil Maddirala (11:08)
This is really interesting. So I have just put this up on the screen of a Johari window. It's a two by two matrix on one axis. It says known to others and not known to others on the other axis is known to self and not known to self. And then the thing that everyone knows is called the arena. The thing that you know, but other people don't know is called the facade.

The thing that other people know that you don't know is called your blind spot and the thing that neither of you know is called the unknown.

Piyush (11:45)
Right, that's a very interesting framework. One of my favorite things in this podcast is learning about these concepts, these frameworks, this Mendel model. So, Rukma, so how do you use the, so my understanding is you try to ask a lot of the questions to the LLMs and the reverse as well. get the LLMs to ask you a lot of questions to uncover the fourth box, the unknown unknowns, because by definition, these are unknown unknowns, right?

Rukma Sen (12:13)
Yeah, that's exactly right. So there's a certain amount that I know I need to tell the LLM, which in this example would be the facade. So I know I have this info, I need to tell it to the LLM. So this is things like adding context by linking a doc or a PDF, giving it some links, telling it to search the web. These are all ways to give it that info.

Piyush (12:20)
Mm

Rukma Sen (12:36)
There's stuff that the LLM is assuming that you wanted to do that you don't know about, that's the blind spot. And then there's stuff that the LLM doesn't know it needs to know and you don't know you need to provide. And that's kind of this like fourth unknown box.

Piyush (12:44)
Right.

Rukma Sen (12:55)
And by giving it instead what I'm calling more like standards of understanding or, you know, like a very clear, like, I need you to know A, B and C before you even attempt an answer in the system instructions. We're basically like trying to shorten that. I don't think it's ever possible to make that unknown window like negative or zero, but just trying to close that gap as much as possible.

Nikhil Maddirala (13:21)
And I think most conversations people have with LLMs, like you start in the arena, which is things that both of you know, and your goal often is to fill in your blind spot. You're like, hey, there's something I don't know and I want this language model to tell me this thing. But the thing is, like the blind spot cannot actually be revealed until the facade also comes out. Like the things that you know that the LLM doesn't know.

Piyush (13:21)
Wow, this is interesting. Go ahead.

Mm

Nikhil Maddirala (13:50)
that it needs to know some context about you. If it doesn't have that, it's not going to be able to like help you fill in your blind spot very well. So to, I think the idea is that to expand, you need to go in both directions. For starting from the thing that everyone knows, both of you need to be sharing information and context with each other for the conversation to expand to new knowledge. And I think that's something people often miss.

Piyush (14:14)
Yeah, this is very interesting, Nikhil. I was reflecting back to our conversation we had when we were talking about, we did a series of episodes on from zero to hero of using LLMs. And we talked about lazy shot prompting, which is what I did to zero shot to few shot, right? So if you use that same framework and then we try and marry that framework with this framework, I think lazy shot or zero shot would be arena where you assume.

certain things that the LLM knows and you know and you just send the prompt. Whereas I guess the facade would be you providing some examples in your prompt. So you're like, hey, LLM, here are some examples of how would you. And then Rukma, I think what you're helping me understand is just going one level beyond what we learned in like the few short examples as well. No, you have to have a back and forth with the LLMs to figure out what your blind spot is.

Nikhil Maddirala (14:52)
Yeah.

Piyush (15:08)
And the way you can do that is by getting the LLMs to ask you questions. So I feel like, Nikhil, this could also be just another tool in our arsenal to better our prompts.

Nikhil Maddirala (15:22)
Okay.

Piyush (15:24)
So yeah, I was saying that this is just another tool in our arsenal. And this tool is basically another way of enhancing our problem. This is very cool, Rukma. This is amazing. sorry. Nikhil and I, have a habit of digressing here and there. But I want to bring this back. So you were explaining how the job of a product marketing manager is to come up with the human story behind the product. And that's not always very easy. There is some art and science to it.

So one of the ways you use AI in your job to come up with this story is to get the LLM to ask you a lot of the questions to figure out more about the product and such. So yeah, let's go ahead. I that's very, very insightful, this way of using the LLMs.

Rukma Sen (16:09)
Yeah, I I also digressed because getting an LLM to ask you questions, think is such an easy thing to do and like really, really helps. But yeah, so going back to kind of how I think about my role, so the several different parts of telling the product story and bringing it to audiences is first you have to understand who your audience is, what do they care about, right? Otherwise, like you're taking it to the wrong audience. You have to understand kind of what your product is

And you as a product marketer, and I think this is true for marketers across the board, whatever product it is you're marketing, you actually do need to understand all of those technical details and things like why latency going down or reliability going up is actually a good thing. And then I would say the third big piece of it is that you really need to have a...

pretty good strategic sense of which channels to use, how to allocate budget, how do we take this fairly amorphous sounding goal, like we want people to love our product and buy it and make it really real with things like ads and...

all of the different kind of media that's available to you. So the way I described it I think is it's already obvious like a lot of this is applicable to anyone who wants to like build something for other people.

I know that's a very broad definition, but I purposely said it that way because you and Nikhil are building this amazing podcast. You're providing all of this information to people, and you're hoping to reach the right people who would be helped by that. To me, that's a traditional marketing problem. I can take that and work with that. I would say these are all the different pieces of my job. I have found help from AI in

nearly every piece from research and competitive analysis to positioning. I just talked to you about how it kind of helps me do messaging and really getting to storytelling to channel allocations to analysis of which channel is working well, what's going wrong, just kind of every little piece of it. And Piyush, you and I have actually even shared some best practices on especially that research piece of it, which is an important component

I think both are jobs where we really need to understand for you, specific people you're selling to. And for me, maybe more like a persona or a specific type of person I'm selling to.

Piyush (18:43)
Yeah, that's very cool. I really like the way you broke down your jobs. You made it sound very easy, but it also sounds very, very difficult. So I'm curious, how do you use, like have you started using AI in all of these different facets of your job? And have LLMs changed your jobs, the way you approach your job, and how do you use it?

Rukma Sen (19:06)
Yeah, I mean, I would say it has like completely transformed how I think about my job. Before I dive into the details, let me just talk about like two ways I think it's transformed my job. So I think earlier I was very much an individual contributor, right? I was like, yeah, I know how to create excellent messaging and I know how to create really strategic like channel plans. Now my job is much more about how do I coach this LLM in the most efficient

effective way to do that for me. it's almost become like my role is much more like figuring out like, what would be the right process here? What would be the right way to set up a team of LLMs where I have like a creator LLM and an evaluation of LLM and whatever.

would that team architecture be? So in a way, even though I'm not a people manager at Google, I almost feel like my job is becoming more people manager and only instead of people, I'm like little bots of the different LLMs.

Piyush (20:11)
That is interesting. I've never ever heard anyone use that phrasing before, but it makes so much sense. Coaching the LLMs. And you're treating the LLMs as your reportees. Yeah, that is so interesting to me. So how do you go about doing that?

Rukma Sen (20:28)
So just a small divergence here, I'll just quickly say, I have noticed, and I don't know if this is replicable, but I have very much noticed that if I give it good feedback, if I'm like, hey, this is going great, can you do X or Y? It tends to be much more excited to work with me. And I think part of the reason that is is because, and I know this from listening to your podcast, is essentially what it's doing is predicting the next word, right? And I think just in its historic data sets,

has this correlation baked in where if someone's saying you're doing a great job it's more likely to produce something that's more interesting related to what it was talking about. anyway, that's a slight divergence.

Piyush (21:10)
that is so interesting to me. Now I'm thinking this could very well be like the third episode in our series of zero to hero prompting, right? Like this is an amazing insight. The fact that the LLM produces a better output if you were to give it feedback on like, hey, you're doing well, or you're coaching it. That's amazing. that's, what has it hurt? Is this adding another line after your prompt, right? It's just good job. That was good.

And if it produces a better output, then that's great.

Nikhil Maddirala (21:41)
So do you? No, go ahead.

Rukma Sen (21:41)
think sorry go ahead I was just thinking that

ethically, like thinking about our children, your daughter, Piyush, like when she grows up, so much of their interaction is going to be with LLMs and ours too, like LLMs, AIs, and just the like human ethics of like, I would never tell a human being like, hey, this is totally wrong, go do it again, right? I would say, great start, like let's think about it again. So I also think there's like some level of like ethics that comes into it. And especially when I think about like, how would I teach any future

or child like how to interact with things like Alexa and all of these assistants and you know Google assistant and stuff so for me it's also just a matter of like I don't want to get into the habit of sounding offhand or rude because it's just like what if I do that to a human by mistake

Piyush (22:33)
Actually, that is also another very insightful perspective. I didn't think about it like that, but now that you have mentioned it, you are right. mean, my two -year -old has started to use, like she understand us interacting with Alexa's and Google. And now I'm thinking, it's not a good thing for them to think that that's how the real world works, that you just ask Google, hey, what is the temperature? And not use please or thank you in your reply, because...

In her mind, it's like, OK, this is what normal looks like. You just order something, and you get a response, and that's it. There's no kindness involved. There's no gratitude involved. But you're talking about that not just in the context of Alexa, but also these LLMs. But in this case, the LLMs actually respond better. Yeah, mean, we can digress into this for much longer, but this is such an insightful perspective. It's just how do we talk to these entities that we know not to be real?

our interaction with these entities influence our children and what impact it has on them. Anyways, like I said, we can go into this rabbit hole for a long time. That is a very, very insightful perspective.

Rukma Sen (23:40)
Nikhil I interrupted you, were saying something?

Nikhil Maddirala (23:43)
I was just asking you, like, if you have specific AI personas that you're making that help you with various tasks and you coach each one of them to do something different, what does this workflow look like for you?

Rukma Sen (23:58)
Yeah, so I'll talk about the team architecture or team design piece I was mentioning. So one kind of architecture that's been working really well for me recently is a content creator kind of agent or bot or what have you, and a content evaluator agent or bot or what have you. And with a little bit of coding, which I think there are low code ways enough that I could also do this. I could actually just create agents and chain them together.

I haven't at the moment because my workflow is working okay just using specific gems on Gemini or custom GPTs. So with the content creation piece of it, I use system instructions to program a bot.

Yeah, so I have a content creation bot and kind of a content evaluation bot. So in my role as a marketer, after kind of I've done all the research, we figured out the positioning, then the time comes to really kind of like bring that positioning to life, right? So you have to create all of this like different content, podcasts, obviously something you guys have like a lot of expertise in, but obviously things like ads, you have graphics, booth copy for events and email,

marketing is everywhere all forms of content can be marketing yeah yeah sure so

Nikhil Maddirala (25:22)
Can you maybe pick one example and walk through the flow that you have?

Rukma Sen (25:28)
The content creation kind of bot that I created recently was specifically for events. So when we have events and we have people go and speak at them, we need to submit things like a title, an abstract, a little piece of like an email blurb where you're inviting people to come.

watch. You would sometimes have short teaser videos, like speaker highlights, all of this kind of different stuff. So I created, I just uncreatively call it my event content creation bot. So I created one and programmed it with system instructions to basically produce this content. And the way it's set up is I like to think about it, at least this has been working well for me in the past in terms of identity, interaction rules,

and tone. So identity is I tell it what it is or who it is. So I'm like, you're an event marketing expert with, you know, X years of experience in selling B2B enterprise technology. You have, if I wanted to have specific expertise in a certain audience or know something about a certain technology, I'll tell it. be like, you know, you're an expert in specifically, for example, Kubernetes or whatever it is.

So I actually recently published an artifact on reforge .com for those of you who might have memberships to reforge, you can take a look there. But I just wanted to show that this is sort of how I use it. like I mentioned, so step one is identity. So I told it you're an expert event content creator with 20 years of experience designing content for engaging trade shows and conferences, et cetera. Then we go into what you see here, which is

interaction rules. So as you'll see, literally the first thing I told it was ask the user for any information you need to create your content most effectively. So just like blanket statement of make sure you do that. And then I go into those like standards of understanding that we were talking about. So I was like, at the minimum, I need you to make sure that you understand the target audience, event goals, and how is it being measured? What are the KPIs here? I'm like, make sure you understand both business and math.

marketing goals as well as competitive presence from any other companies. So what this does and this I've noticed when I actually start interacting with it is sometimes this will lead to one set of questions and whatever answers I give it feels good about and moves on and then generates the content. Sometimes it feels that these standards are not met. So it will keep asking me follow up questions like, okay, you said the target audience was, you know, IT decision makers, but are you specifically talking about

North America or is this like global and it will keep asking me kind of like you know more granular questions which I may not have even considered telling it because I'm my role is global so I don't actually think about regions honestly when I'm designing stuff and the fact that it thought of that and asked me was pretty great for me like it exactly yeah

Piyush (28:40)
That would be an example of uncovering your unknown unknowns. Yeah, that's amazing. Can I ask one question? This is for both Nikhil and Rukma. I've often seen people give an identity to the LLM. Why does that make a difference? I don't believe Nikhil we have talked about this before. Why does giving an identity to the LLM

Nikhil Maddirala (29:04)
It just helps, as far as I understand, contextualize the way in which it's responding to you. the LLM is trained with large amounts of data, right? And it has, it's large amounts of text from different contexts. And if you tell it that you are an expert event creator, like in this case, it will probably use the type of language that is more suitable to that based on its training data, it understands what type of language, what

event creators typically talk about, what their main concerns are, what topics they need to address and how they would talk about them. So you could just ask this same question, right? You could say something like, hey, tell me about San Mateo. I live in San Mateo and this is a pretty vague question. But if you say, hey, imagine you're a real estate agent and tell me about it's San Mateo versus imagine you're a geologist.

Piyush (30:01)
Right.

Nikhil Maddirala (30:02)
and tell me about San Mateo, imagine you're an investor and tell me about San Mateo. Those would give very different kinds of answers.

Piyush (30:10)
makes a lot of sense. Yeah, that's a good example.

Rukma Sen (30:14)
It makes me wonder though that maybe with the level of context I already give this, that this is maybe not a great use case for that identity piece of it. I've never really A -B tested this. Yeah, that would be interesting. Have you A -B tested this ever, Nikhil or Apush, giving it identity versus not?

Piyush (30:35)
So I have been using what I coined a term called lazy shot prompting, which is like not even zero shot. It's like, hey, make this email sound good. Like that's how ridiculous my prompting has been.

Nikhil Maddirala (30:49)
I think the more specific your prompt is, the less important the identity thing becomes. Because if I ask a vague question like, tell me about San Mateo or tell me about Silicon Valley, that's pretty vague and you could approach it in different ways. But if your question already has so much detail that you are providing a target audience, event goals, competitive presence, and then detailing exactly what kind of response you want, I think at that point,

the identity is less impactful and maybe you don't need it, but I think it's super helpful in cases where you may not be specifying as much detail. Like often I might be like brainstorming some startup ideas or like app ideas that I'm building and then I give the AI an identity and I tell it that, here's the role you have to play so that then I don't have to give so much detail every time.

I ask specific questions.

Piyush (31:50)
That makes sense.

Rukma Sen (31:50)
Yeah, that was kind of my suspicion as well that maybe it's not so helpful given I already give it all like all of this info. But moving on, start by

Piyush (31:59)
So Rukma, sorry to interrupt you. This is what you call a content creator bot. When you say the word bot, do you mean a custom GPT or a gem? Is that the same thing as a bot?

Rukma Sen (32:10)
Yes, that's exactly what I'm talking about. I created this particular one in Google AI Studio where you can also create kind of these custom prompts. Part of the reason for that, honestly, is that Google AI Studio is a product I market. So I like to use the products I market and really understand what the experience is. And I have to say Google AI Studio is pretty great and I can recommend it. You can do things like play around with temperature, which obviously changes

the confidence interval for the next word prediction, all of those things. there are different tools really, I think, to create these. And I am fairly tool agnostic. Model -wise, I think I do like Gemini. I think maybe part of it is because I use it so much, but that's kind of one of my favorite models. And Claude is the other one I use a lot.

Piyush (32:52)
Mm

Actually, those are two of my favorites as well. The Gemini Advanced one, one because I have it for free. I don't have to pay the $20 because we as Google employees get it for free. And the Cloud 3 Opus from Anthropic. That one's also really good. So one other question I had is, you said that you have these two bots, a content creator bot and a content evaluator bot. How do these bots talk to each other?

Rukma Sen (33:16)
Yeah, Claude, I really like.

Nikhil Maddirala (33:27)
Can we finish this first and then go to the evaluator? Let's just go through the content creator bot. So you talked about identity, interaction, and then you have something called tone after that.

Rukma Sen (33:30)
Yeah.

So.

Yeah, and I'll point one more thing out in interaction here. I say once you have this info, summarize it and check with the user that you've understood it correctly. So this is kind of my very last guardrail to make sure that I let that it really does understand like what it's being asked to do. Because what I've noticed is when my LLM or my AI really understands the task, almost within the first answer it gives me, I'm like, yeah, this is an excellent answer. So the

The really is just getting it to understand like, this is what I'm actually doing. And then I'm like, yeah, if I say proceed, go ahead and generate it. The tone piece of it, I think, is really only very relevant for something like this, where it's like marketing content and I want it to...

in like a certain brand voice or a certain tone. I don't think tone is extremely relevant if you're just like, you know, using it as an internal thought partner or anything like that. But since I do want this to be something I use externally, I give it some info about appeal to your audience, keep your tone professional but informal. With a custom GPT slash gem that you program to answer to like emails and things, tone can also be

useful because then you can say stuff like hey keep it peer -to -peer at a tech company so that it doesn't generate these like kind of overly formal dear sir blah blah blah which we would never say to our colleagues but yeah this is this is available on reforge and also you know if anyone listening wants to wants to get a hold of this feel free to reach out to me if you don't want to pay for a reforge subscription to get this

Piyush (35:22)
So in this particular instance, this content creator bot is specifically a content creator bot for an event marketing specialty, right?

Rukma Sen (35:32)
Yes, but the only thing that would really need to change to make it a content creator bot for anything else is that identity part of it. The rest of it.

Piyush (35:41)
And can you give me some examples of other types of content creations? Like this is for events, right? What are some other contexts in the case of marketing?

Rukma Sen (35:50)
Email. So I think email is a big one because often you're creating an email funnel, right? So you want to have like five or six emails in a row. Actually, this is something you would probably know very well about Piyush because obviously sales also does outreach often. And every time you're talking to them, you want to like change it up a little bit. You have these decision trees, obviously, right? Like if someone responds to the first one, what's the second email they'll get versus if they don't respond to the first one?

what's the email they'll get, et cetera. So email is like a really good one again, because it's like, can be very processized and very clear kind of what your output is. So I've used it for that a lot. I've also used it in the past for things like if I'm creating a pitch deck and I want to have like, you know, some specific speaker notes, not necessarily what's on the slide that I think humans might do a little bit better even now, because a

of it is about pulling out the highlights and using that human judgment to figure out what is a highlight versus not. Obviously if you give it enough context it can be as good as any human but that might be like a little time consuming in and of itself but speaker notes it does a great job of like if I feed it my highlights and I'm like hey this is what's on the slide create speaker notes for this ask me all the questions it does a great job of that so I think those are three that I use it for quite a lot.

Piyush (37:18)
OK, that's cool. That's very smart. I really like this news. So the other thing I was wondering, I asked earlier. So you said you have two bots. And I want you to explain what the content evaluator bot does. But you also said that they form a team. So how do they interact with each other? Like that part, I'm not very sure.

Rukma Sen (37:38)
Yeah, I mean, honestly, if I put a little more effort into it, could probably figure like automate a way to get them to interact with each other right now. I just simply copy the output of one and paste it into the other. I'm like, hey, that being said.

Piyush (37:49)
I see. OK, OK.

Nikhil Maddirala (37:53)
And we've talked about this in the past. Like there are many like multi -agent workflow frameworks that you can use to easily automate this.

Piyush (38:00)
Yeah, there's one called Crew AI. think they're very popular. They let you create multiple agents.

Nikhil Maddirala (38:05)
I think that's the one we talked about before. Crew and AutoGen are Python frameworks for if you want to code something like this, but there are also no code platforms that you can use. There's Make is a popular one, Vector Shift, think. There are a couple that are coming up. Zapier might let you do it. So there are also no code platforms you can use to chain together multiple agents and have them.

Piyush (38:11)
Mm

But in your use case, Rukma, is there a lot of back and forth? If there isn't, then I imagine it's not too hard to just copy one prompt from the creator to the evaluator and be like, Hey, evaluate this now.

Rukma Sen (38:40)
making a zap for it and honestly like if I start producing content like you know at an even higher level of scale I might end up wanting to zap it but for right now it's just one click right I'm just hitting control C control V and then we're done

Nikhil Maddirala (38:58)
So tell us about the evaluator chatbot. What does that do and what are its instructions?

Rukma Sen (39:04)
Yeah, so I am not going to screen share that one because that is still a little bit of a work in progress. But so far, the way I've set it up is I give it an identity as an expert at analysis. I tell it it's a marketing consultant. It's very good at auditing, analyzing and suggesting improvements, basically. And then the interaction rules are that for any piece of content I paste in, it has to ask

me what are the metrics and what is the call to action. So all marketing, I think in some way is trying to inspire some form of action, right? Either it's like, you know, hit subscribe on Spotify, which might be something you guys are interested in, or it's like come talk to my sales team, which is something I often want people to be doing. Sometimes it's like, you know, go buy Axe body spray. It can be anything, but we're trying to inspire action. So what is that action?

I want the evaluator bot to be very clear about and how we are measuring success or what would be like a very successful way to do this is something I want the evaluator bot to be very clear about. So it asks me questions until it has a good sense of hey, this is the action and this is how we're evaluating it. Once it has that sense, what it does is like an analysis of how well will this piece of content A, make the audience or the reader

or the viewer of that content take that action and I ask it to rate it on a percentage scale. So they tell me like, yeah, with 90 % confidence, this person will do this or with like 80 % confidence, whatever it is. Then it has to suggest three things we could improve in the content to make that number go up. And then the second thing it provides is based on the KPI, measuring or your definition of success, this is what I project will happen versus not.

And then again, it has to produce three things to kind of improve that. I think one thing to note here is that this is much more kind of experimental. Like obviously the estimates and things that comes up with that just kind of out of nowhere for the first few. But then what I can do is after I go use the content at an event, I can come back and tell it, hey, remember you told me it was going to have like X on our metric? Here's what it actually had. Where do you think you

went wrong or what did you miss and then it actually does a really good job evaluating what it itself got wrong it'll be like like maybe I missed out on like X and Y and then I can give it some more info and I'm like you know like here are some other things that happened that could have caused this and then it's like yeah okay great and then I tell it okay summarize everything you learned so then I have that one single paragraph where it tells me like here's everything I learned based on my prediction versus the actual number and then I feed that back

into system instructions. So I'll go back...

Piyush (42:06)
You weren't joking when you said that you coach them and you act as if you're the manager and they're like, is like literally everything that a manager would do, right? It's like, hey, where did you go wrong in this? Like trying to reflect and yeah, I mean, you make a great manager because you're getting such a great, if you aren't already, this is amazing.

Rukma Sen (42:16)
You

That is very nice of you. I honestly do it purely because it saves me time. But yeah, it works for me. It's fun.

Piyush (42:33)
Yeah, that's very smart. This is remarkable. I'm going to start. This is just like if there's one takeaway for me from this episode, there are many insightful things that you shared today. But one big takeaway would be that I'm going to start acting more of a coach to the LLMs and also be very mindful of the tone that I use because it can get a better output. But this is very, very insightful. So you.

Rukma Sen (42:54)
What would be the first thing, like what would be like a change you make like on Monday or immediately next? That would make you more of a coach.

Piyush (43:04)
I think this mindset shift will be the biggest change. Right now, think the approach that I take is it's a tool and then I'll just have to use this tool. But I'm going to start treating it more like it was a reportee of mine and I'm the manager. My job is to get the best out of them and also help them develop because that's what you're doing. In the last thing that you mentioned, you're like, all right, now reflect on what you think may have gone wrong.

And then you're taking the learnings and you're trying to build them into the systems front, which is what you're hoping a reportee of yours will do, right? They will learn from their mistakes and then hopefully improve from that. So yeah, I think it's a mindset shift.

Rukma Sen (43:42)
would say this making it learn from its own thing is also helpful for like, I think pretty much any bot. when I first started with my content creators, they would give me some output and I'm like, no, this is not really on our voice or the positioning is wrong, this, that. So then I would rewrite it myself and give it back and say, I rewrote it to say this, whatever X. Can you explain what are the differences between what you provided and what I?

gave and then I would take that whatever answer it gave and put it back in system instructions.

Piyush (44:17)
very interesting. It's very cool.

Nikhil Maddirala (44:20)
On the topic of these multi -agent workflows, I just wanted to share one of the common frameworks that's been emerging in the programming world for how to set these up. This is from the Lankchain blog, and Lankchain is a popular framework for programming LLM applications.

they have a framework for multi -agent workflows. And here's how they think of it. So there's a user, which is you at the end of the day, and you first interact with a supervisor agent. And then the supervisor agent routes your query to several possible other agents. So in this case, your supervisor agent could be like a marketing manager, and these agents could be an email writing agent, could be a social media content writing agent, it could be a

campaign writing agent or like an evaluator agent and you only interact with the supervisor agent and then the supervisor agent coordinates all the other agents' So it automates this flow that Rukma was describing that she built for herself of a writer agent and an evaluator agent. And yeah, it's really interesting. So people are trying to like...

productionize these multi -agent workflows into an automated system like this. it's hard to specify what are the conditions when you stop the flow, because pretty much every time you go through the loop, the evaluator agent will never say this is perfect because you programmed it to be like, hey, you need to find what's wrong with this. then that's where usually the supervisor agent is where

you give some logic that, okay, like maybe you can stop here or you say after a certain number of iterations just to avoid running into like an infinite loop, you stop. But that part actually is the hardest to automate. So Rukma in her case is playing the role of the supervisor. She's doing it, yeah.

Piyush (46:07)
Interesting.

I was just going to say that, yeah, sounds like Rukma is playing the role of the supervisor. And it's kind of scary to me that this blog on Langchain puts the user above the supervisor and the supervisor is supposed to be automated. Like this is scary to me. This goes back to a conversation that Nikhil and I had, is like, at what point do our jobs become redundant? But anyways, we won't go there. Rukma, I'm curious, Nikhil used the word that this helps you productize. Have you seen your productivity improve after using these LLMs?

Nikhil Maddirala (46:34)
Yeah.

Rukma Sen (46:52)
by a huge amount. Like honestly, currently at my job, I am in charge of executing and running nearly 80 events, big and small over the year. 80, yes. And I don't think I could do it without my LLMs.

Piyush (46:52)
in your workflow.

8 -0

Yeah, that sounds intense.

Rukma Sen (47:15)
So like 100 % super much more like productivity for sure and also there's definitely my colleagues at work.

you know, who have similar roles have reached out to me and I think it's like helped them. So yeah, I think my view on AI and LLM specifically is like nothing's going to take away that art piece that you guys have in the art and science of AI from humans. Like my judgment, my like business intuition, my sense of like where budget is going to work best is always going to be required.

but all of the pieces of like analysis, creation, evaluation, execution, you know, that the AI can do, it does very well, does fast, it does not get tired, it doesn't have limited kind of brain power like I do. So I love using it. It's like, basically to me, it's like having a thought partner or consultant by my side while I'm working and I can just go to it and be like, hey, can you do this? Can you do that?

Piyush (48:21)
Yeah, yeah. mean, that makes a lot of sense. I keep going back to thinking, there is this one famous saying that's applied to almost all types of jobs that your job will not be taken by AI, but your job will be taken by someone using AI. And you can replace your job with marketing or sales or this and that. I think the examples that you use are such a perfect example for that particular saying, right? Because imagine someone in your role who's not using these LLMs.

versus you who are using these LLMs to coach them to get so much productivity out of it, and also to, produce better work even, right? Like the unknown unknowns. Like there's only so much you can do from your own thinking. But when you have a thought partner, as you described, you're much more likely to not just uncover your blind spots, but your unknown unknowns. Another amazing framework that I learned today. I'm curious, Rukma, so all of these workflows that you explained, you're using LLMs or custom GPTs.

Are there any other tools that you use, AI tools in your job, in your workflows?

Rukma Sen (49:26)
Yeah, so I actually recently found one that I'm very excited to talk about. I actually haven't even mentioned this to Nikhil yet, but it's called Flow With, so F -L -O -W -I -T -H. And what it does, fascinatingly, is that it's just like any normal conversation, and it supports a bunch of different models, so you can pick which specific model you want to converse with. what it does is it breaks up your conversation into a graphical kind of

user interface. it will show like suppose you ask it a question, it will be like node one, I went and did this research and this is what it said, then it will split into two nodes. It will be like based on that research, I went further down the path of A and B thing, then it will go into like, okay, within B thing, I went further. And so it almost maps this like network of thought. And it makes like, I'm not saying that the graphical mapping is exactly what the neural network

is doing, right? Because this is like the basic thing Nikhil explained in your first podcast is that, hey, that machine learning is not human explainable. We can't really understand what's going on there. But it somehow uses a concept or a metaphor, if you will, that makes it easier for me to understand, hey, this is what the AI is actually doing. And then it also, I think by now, it's probably clear to everyone listening that I am very into processes and like setting up these detailed instructions and stuff. So for me, I

Piyush (50:34)
Right.

Rukma Sen (50:55)
I love being able to see like, here's this node versus that node. And then you can actually go click on each specific node. So suppose you're like, you know, during your process, were going, you were doing everything correctly. You did step A, step B, step C, but in step D actually, you went wrong. You can go up there and tell it like, hey, this is wrong. Change it to something else and come up with like a better kind of final answer. So I have been having a lot of fun with this.

especially for brainstorming kind of stuff, because it just creates this like mind map and you can play with it and it's fun and it's like very easy to understand. great, Nikhil found it.

Nikhil Maddirala (51:37)
I just looked this up and this looks really cool. So here's the first example it gives you. It says research the top most profitable US tech companies, and then it gives you a list of the companies, and then it breaks it down into five different nodes, like one for each company, and you can choose whether you want to continue going down.

Piyush (51:37)
He

Nikhil Maddirala (51:59)
the single node, so the companies are Apple, Microsoft, Amazon, Google, Facebook, I could click on one of them and follow that line of reasoning and say I wanna dig into that, or you can connect some or all of them and ask it to do a task like generate a chart using all of this data. So I've never seen this before, this looks really cool. I definitely want to play with it more.

Piyush (52:09)
Right.

Yeah, because so far all the interactions that you have are all in one window. So it's like just one train of thought and it sounds like in, or it looks like in this thing, you can have multiple train of thoughts visualized at the same time. And you can like if sticking with it. Yeah. Yeah. Yeah. Yeah. This is very cool. Flow with.

Nikhil Maddirala (52:37)
It's like a mind map. Yeah. What have you used this for, Rukma? Any interesting example you can share?

Rukma Sen (52:48)
So my non -day job is that I am a creative writing enthusiast and I have recently been using it to kind of brainstorm what happens next in this story I'm writing. It's based on the Indian epic, the Maa Bharta. I think I have mentioned this to you as well at some point, Piyush, but yeah, I'm this novel and every time I'll write a new chapter and I'll be like, okay, this happened, that happened. Then I go to flow with it

say okay this happened, that happened and then it's like here are 20 different nodes for what could actually happen next and I don't necessarily listen to those nodes but it's just like a fun way to to see like all the different like you know threads my characters could take the arcs that could happen the locations they could go to the magic they can interact with so I have just been having fun with it for my non -day job

Nikhil Maddirala (53:42)
That actually sounds really cool. So you're like, okay, I got to a certain point in my story and I'm not sure which direction to go. And this tool can map out 10 different directions you could go in, but you're like, I'm not sure which of these 10 directions to pick. You can expand each of the nodes and for each of the 10 directions go further and further. And then based on the end state, you can choose which end state do I like and then go down that node. That sounds...

really powerful and really cool. Cause actually that's one of the main problems I have with LLMs. the linear chat experience right now is that often it goes too quickly into picking a solution and talking about that. But in the early stages, I just want to explore what are all the different things. And then I want to go down each of those different options to a deeper level to understand what choice.

I should make. So this sounds amazing. I can't wait to try it out.

Rukma Sen (54:44)
Yeah.

I strongly recommend it. I almost never, my creative process is such that I almost never just like pick one node and follow it, but it's more like a way of like sparking ideas and simulating. It honestly is like a way to simulate different worlds or like different chains of thought where you're like, hey, if I went down this train, here's where I'd go. If I went down this other train, here's where I'd go. Another thing I used it for recently was just a brainstorm exercise at work as well.

Nikhil Maddirala (54:56)
Hmm.

Rukma Sen (55:14)
think it's very good for these creative, open, brainstorming exercises.

Piyush (55:16)
Mm

Yeah, a lot of team activities have people putting sticky notes where they do brainstormings. I can almost envision using something like this by yourself as one of those team meetings where, again, you have five different people thinking about five different threads and all different ideas. Cool recommendations. I'm going to try it out.

Rukma Sen (55:26)
Good job.

Nikhil Maddirala (55:27)
you

Alright, Frukma, is there anything else you want to plug before we end this episode?

Rukma Sen (55:45)
Yeah, well, first of all, want to say thank you. This was a really fun episode. loved geeking out about all my specific prompting. And then if anyone listening is interested, I will be speaking in SF at the AI for Marketers Summit.

AI in my workflow as well as the Developer Marketing Summit and you can find all of this information on my LinkedIn which is just my name Rukma and I look forward to connecting with anyone who wants to talk about AI with me.

Piyush (56:15)
Rukma, I have a suggestion you can put as your tagline on LinkedIn, the AI coach. Because again, like I said, I loved it. The way you use AI, think that's a big mindset shift that's happened already. I'm going to try and coach the AI as opposed to talk to it or discuss it.

Nikhil Maddirala (56:15)
Very cool.

Rukma Sen (56:19)
You

really worried that people should not assume that I am a coach and I can help them out. But I love that idea.

Piyush (56:34)
Yeah, true, true, true. Yeah. Thank you so much, Rukma. Yeah. then, Nikhil, should link, Rukma's LinkedIn into our description so people can find her.

Nikhil Maddirala (56:45)
Yeah, of course. And thank you also to our listeners. If you're with us, connect with Rukma. If you want to learn more about what she talked about, let us know what you thought about this episode. If you liked it, leave us a rating or review. As always, we'd love to hear from you. Thank you. All right, guys. See you.

Piyush (57:05)
Bye.



# Post-episode Notes
## Title
S2-E8: Mastering AI for Marketing | Rukma Sen, Google AI Product Marketing Manager 

- ChatGPT
	- Mastering AI for Marketing: Insights from Google’s Rukma Sen
	- Coaching AI: Elevating Your Marketing Strategy with Rukma Sen
	- Unlocking AI’s Potential in Marketing: A Deep Dive with Google’s Rukma Sen
- Riverside
	- Harnessing the Power of AI in Marketing
	- Creating High-Quality Marketing Content with AI Coaching Language Models for Better Output
	- Visualizing and Brainstorming with 'Flow With'

## Description
Nikhil and Piyush welcome their first guest, Rukma Sen, an AI Product Marketing Manager at Google. Rukma shares her unique insights into how AI is transforming marketing strategies and operations, offering a detailed look at how she coaches AI tools to boost productivity and creativity in her role. From designing custom AI workflows to using cutting-edge tools, Rukma discusses the art and science of integrating AI into her job. We discuss Rukma's content creation workflow using a content creator bot together with a content evaluator bot, how she coaches the LLMs to improve their output and how they form a team to interact with each other. Rukma emphasizes the importance of starting with the end goals in mind when creating marketing content and the importance of human judgment and intuition in conjunction with AI tools to enhance productivity and creativity in a goal-oriented manner.

**ChatGPT**
In this special episode of "Art and Science of AI," hosts Nikhil and Piyush welcome their first guest, Rukma Sen, an AI Marketing Manager at Google Cloud and a long-time friend. Rukma shares her unique insights into how AI is transforming marketing strategies and operations, offering a detailed look at how she coaches AI tools to boost productivity and creativity in her role. From designing custom AI workflows to using cutting-edge tools like Flow With, Rukma discusses the art and science of integrating AI into everyday marketing tasks. Whether you’re an AI enthusiast or a marketing professional, this episode is packed with actionable insights and innovative approaches to using AI effectively.

**Riverside**
The conversation explores how AI is used in marketing, specifically in the context of product marketing. Rukma Sen shares her experience using AI tools to improve her workflow and create marketing content. She discusses the concept of identity and how it helps contextualize the responses from language models. Rukma also explains her workflow using a content creator bot and a content evaluator bot. The conversation highlights the importance of understanding the target audience, event goals, and competitive presence when creating marketing content. Rukma Sen discusses how she uses AI in her workflow, specifically focusing on language models (LLMs) and their applications in content creation, evaluation, and analysis. She explains how she coaches the LLMs to improve their output and how they form a team to interact with each other. Rukma also introduces the tool 'Flow With' for visualizing and brainstorming different paths of thought. She emphasizes the importance of human judgment and intuition in conjunction with AI tools to enhance productivity and creativity.


## Chapters
0:00 Introducing Rukma and her role as a Product Marketing Manager
19:06 Coaching and Managing AI assistants
32:52 Multi-agent workflows
42:03 Tools to enhance creativity and productivity 

Introduction and Guest Background - 00:00
The Role of AI in Marketing - 05:05
Coaching AI: Building Effective AI Workflows - 16:09
Exploring Multi-Agent Workflows and Tools - 33:30
Insights and Reflections on AI’s Impact - 46:52

Introduction and the Role of a Product Marketing Manager
19:06
Transforming the Job with AI and LLMs
22:33
Ethical Considerations in Interacting with AI
24:48
Coaching LLMs and Managing Bots
29:04
The Significance of Identity in LLMs
32:52
AI Models for Content Generation
33:39
Using AI Language Models in Event Marketing
38:40
Coaching LLMs for Optimal Output
42:03
Enhancing Creativity and Productivity with LLMs
49:56
Exploring Ideas with Flow With
57:07
s2 outro.mp4


## Takeaways
- **The importance of coaching AI**: Rukma emphasizes the importance of treating AI tools as "coachees" that require clear instructions and feedback to improve their outputs. This approach can significantly enhance the effectiveness of AI in various marketing tasks.
- **Building a team of AI assistants**: Using a team of AI assistants such as a content creator bot and a content evaluator bot can streamline the content creation process and ensure high-quality output. 
- **Exploring "unknown unknowns"**: The use of frameworks like the Johari Window helps in uncovering blind spots and unknowns in AI-driven projects, leading to more robust and effective outcomes.
- **Understand the end goals**: Understanding the target audience, event goals, and competitive presence is crucial when creating marketing content. Human judgment and intuition are essential in conjunction with AI tools to achieve the right goals.
- ChatGPT
	- **AI as a Coach**: Rukma emphasizes the importance of treating AI tools as "coachees" that require clear instructions and feedback to improve their outputs. This approach can significantly enhance the effectiveness of AI in various marketing tasks.
	- **Custom AI Workflows**: By designing tailored AI workflows, such as content creator and evaluator bots, Rukma demonstrates how marketers can streamline their processes and improve productivity.
	- **Exploring Unknown Unknowns**: The use of frameworks like the Johari Window helps in uncovering blind spots and unknowns in AI-driven projects, leading to more robust and effective outcomes.
	- **AI Tools in Action**: Tools like "Flow With" enable more dynamic and creative brainstorming, allowing for multiple potential outcomes to be visualized and explored.
- Riverside
	- AI tools can greatly enhance the marketing workflow by automating tasks and generating content.
	- Giving an identity to language models helps contextualize their responses and improve the quality of generated content.
	- Understanding the target audience, event goals, and competitive presence is crucial when creating marketing content.
	- Using a content creator bot and a content evaluator bot can streamline the content creation process and ensure high-quality output. Using AI tools like LLMs can significantly improve productivity in content creation, evaluation, and analysis.
	- Coaching LLMs and providing feedback helps improve their output and accuracy.
	- Tools like 'Flow With' can be used for visualizing and brainstorming different paths of thought.
	- Human judgment and intuition are essential in conjunction with AI tools to enhance productivity and creativity.


# Final show notes

## Substack version
S2-E8: Mastering AI for Marketing | Rukma Sen, Google AI Product Marketing Manager 

Nikhil and Piyush welcome their first guest, Rukma Sen, an AI Product Marketing Manager at Google. Rukma shares her unique insights into how AI is transforming marketing strategies and operations, offering a detailed look at how she coaches AI tools to boost productivity and creativity in her role. From designing custom AI workflows to using cutting-edge tools, Rukma discusses the art and science of integrating AI into her job. We discuss Rukma's content creation workflow using a content creator bot together with a content evaluator bot, how she coaches the LLMs to improve their output and how they form a team to interact with each other. Rukma emphasizes the importance of starting with the end goals in mind when creating marketing content and the importance of human judgment and intuition in conjunction with AI tools to enhance productivity and creativity in a goal-oriented manner.

## 🎧 Listen to the episode
EMBED YOUTUBE

Art and Science of AI is available wherever you watch or listen to podcasts! Click these links for [YouTube](https://www.youtube.com/@ArtScience-AI), [Spotify](https://open.spotify.com/show/2Wkubbc0AqF5492i94uFj7), [Apple Podcasts](https://podcasts.apple.com/us/podcast/art-and-science-of-ai/id1748468279), [Substack](https://artscienceai.substack.com/), or copy the [RSS link](https://anchor.fm/s/f67d7b4c/podcast/rss) into your favorite podcast app. Don't forget to click subscribe / follow in the app to get notified for new episodes!

Subscribe to our newsletter to get weekly updates by email! 

## 🧠 Key concepts
- **The importance of coaching AI**: Rukma emphasizes the importance of treating AI tools as "coachees" that require clear instructions and feedback to improve their outputs. This approach can significantly enhance the effectiveness of AI in various marketing tasks.
- **Building a team of AI assistants**: Using a team of AI assistants such as a content creator bot and a content evaluator bot can streamline the content creation process and ensure high-quality output. 
- **Exploring "unknown unknowns"**: The use of frameworks like the Johari Window helps in uncovering blind spots and unknowns in AI-driven projects, leading to more robust and effective outcomes.
- **Understand the end goals**: Understanding the target audience, event goals, and competitive presence is crucial when creating marketing content. Human judgment and intuition are essential in conjunction with AI tools to achieve the right goals.

## 🔗 Links
Rukma Sen
- [Linkedin](https://www.linkedin.com/in/rukmasen/)

Art and Science of AI
- [Homepage](https://artscienceai.substack.com/about)
- [YouTube](https://www.youtube.com/@ArtScience-AI)
- [Spotify](https://podcasters.spotify.com/pod/show/art-science-ai)
- [Linkedin](https://www.linkedin.com/company/art-science-ai)
- [Facebook](https://www.facebook.com/ArtScienceAI)
- [Instagram](http://instagram.com/artscienceai/)
- [Threads](https://www.threads.net/@artscienceai)
- [Twitter / X](https://x.com/ArtScienceAI)

### 💬 Keywords
`#AI #ArtificialIntelligence #GenerativeAI #GenAI #LLM #MachineLearning #ML #tech #podcast`


### Youtube / Spotify / etc.
Nikhil and Piyush welcome their first guest, Rukma Sen, an AI Product Marketing Manager at Google. Rukma shares her unique insights into how AI is transforming marketing strategies and operations, offering a detailed look at how she coaches AI tools to boost productivity and creativity in her role. From designing custom AI workflows to using cutting-edge tools, Rukma discusses the art and science of integrating AI into her job. We discuss Rukma's content creation workflow using a content creator bot together with a content evaluator bot, how she coaches the LLMs to improve their output and how they form a team to interact with each other. Rukma emphasizes the importance of starting with the end goals in mind when creating marketing content and the importance of human judgment and intuition in conjunction with AI tools to enhance productivity and creativity in a goal-oriented manner.

=== ⏰ CHAPTERS ===
0:00 Introducing Rukma and her role as a Product Marketing Manager
19:06 Coaching and Managing AI assistants
32:52 Multi-agent workflows
42:03 Tools to enhance creativity and productivity 

=== 🧠 KEY CONCEPTS ===
- The importance of coaching AI: Rukma emphasizes the importance of treating AI tools as "coachees" that require clear instructions and feedback to improve their outputs. This approach can significantly enhance the effectiveness of AI in various marketing tasks.
- Building a team of AI assistants: Using a team of AI assistants such as a content creator bot and a content evaluator bot can streamline the content creation process and ensure high-quality output. 
- Exploring "unknown unknowns": The use of frameworks like the Johari Window helps in uncovering blind spots and unknowns in AI-driven projects, leading to more robust and effective outcomes.
- Understand the end goals: Understanding the target audience, event goals, and competitive presence is crucial when creating marketing content. Human judgment and intuition are essential in conjunction with AI tools to achieve the right goals.

=== 🔗 LINKS ===
Rukma Sen
- Linkedin: https://www.linkedin.com/in/rukmasen/

Art and Science of AI
- Homepage: https://artscienceai.substack.com/about
- YouTube: https://www.youtube.com/@ArtScience-AI
- Spotify: https://podcasters.spotify.com/pod/show/art-science-ai
- Linkedin: https://www.linkedin.com/company/art-science-ai
- Facebook: https://www.facebook.com/ArtScienceAI
- Instagram: http://instagram.com/artscienceai/
- Threads: https://www.threads.net/@artscienceai
- Twitter / X: https://x.com/ArtScienceAI

=== 💬 KEYWORDS ===
`#AI #GenAI #LLM #ChatGPT #podcast`



# Social Media Posts 
## Publish post (Monday)
- [ ] Linkedin: article + post
- [ ] Facebook + IG: MBS
- [ ] Threads
- [ ] Twitter

For each post
- [ ] Title
- [ ] Description
- [ ] Tags
- [ ] Square image
- [ ] Keywords
- [ ] Links (Twitter / Threads - in comments)

## Shorts 1 (Wednesday)
Title: Rukma uses AI to re-imagine her marketing job 

🚀 How are people using AI to re-imagine their jobs?

Rukma Sen has transformed her product marketing role from an individual contributor into a "people manager." But instead of managing a team of people, she manages a team of AI agents. She coaches each AI agent to specialize in a specific marketing task such as content creation. The result? A more efficient and scalable approach to marketing.

🎧 Learn how to master AI for marketing in our latest podcast episode with Rukma Sen, AI Product Marketing Manager at Google: LINK

Hosted by Nikhil Maddirala and Piyush Agarwal

- [ ] Youtube shorts
- [ ] Linkedin
- [ ] Facebook + IG: MBS
- [ ] Threads + Twitter: Buffer



## Shorts 2 (Friday)

