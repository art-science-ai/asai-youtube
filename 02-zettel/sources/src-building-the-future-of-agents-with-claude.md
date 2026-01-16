---
global-template: source
source-title: "Building the future of agents with Claude"
source-url: https://youtu.be/XuvKFsktX0Q?si=g60k3m4qtooYZoj1
source-platform: youtube
source-type: video
source-creators: [["Alex Albert"], ["Brad Abrams"], ["Katelyn Lesse"]]
source-published-date: 2025-10-02
source-fetched-date: 2025-10-05
source-length-minutes: 22
topics: [ai-agents, claude, anthropic]
source-status: drafted
---

# AI notes

## TLDR
- The Claude Developer Platform has evolved to support building autonomous AI agents by providing essential tools and reducing unnecessary scaffolding around the model.
- AI agents are systems where the model autonomously chooses tools, executes them, and decides next steps based on results.
- Best practices for agents include using the Claude Code SDK for prototyping and focusing on clear business value to ensure impactful implementations.
- New platform features like context management, memory tools, and web search enhance agent performance in long-running tasks.
- Future developments aim to provide higher-level abstractions, observability, and persistent computer access to further "unhobble" Claude's capabilities.

## Key ideas
- Agents represent a shift toward model autonomy, where Claude independently selects and uses tools rather than following rigid predefined workflows.
- As model intelligence increases, developers should minimize scaffolding and constraints to fully leverage Claude's reasoning capabilities.
- Tools like web search and fetch enable Claude to perform complex research tasks autonomously, discovering and synthesizing information.
- The Claude Code SDK provides a ready-made agentic harness that automates tool calling and loop management for rapid prototyping.
- Memory and context management features allow agents to learn from past executions and maintain focus during extended operations.

## Detailed Summary
- Introduction to the Claude Developer Platform's evolution from a simple API to a comprehensive platform including APIs, SDKs, documentation, and console experiences.
- Discussion of what constitutes an AI agent: autonomous tool selection, execution, and decision-making based on model reasoning.
- Analysis of the trend toward reducing model scaffolding as intelligence improves, allowing agents to perform better without artificial constraints.
- Exploration of how tools like web search and fetch "unhobble" the model by providing access to external information and capabilities.
- Overview of the Claude Code SDK as an agentic harness that provides a pre-built loop for tool calling and automation.
- Best practices for identifying agent use cases, emphasizing business value and potential to reduce manual work or engineering hours.
- Examination of context management features that help maintain focus by removing unnecessary tool call history while preserving recent interactions.
- Introduction of memory tools that allow agents to learn and improve over time by storing insights from previous executions.
- Roadmap discussion covering higher-order abstractions, observability for long-running tasks, and future computer access capabilities.

### Key quotes
- "Agents is where the model is taking some autonomy to be able to choose what tools to call to call those tools to handle the results and kind of choose the next step."
- "The scaffolding the model needs to be able to accomplish tasks is needing less as the level of intelligence of the model goes up."
- "We're trying to unhobble the model... give the model the tools it needs and set it free, let it be able to use those in the right way."
- "The cloud code SDK is we essentially built an agent harness around the model to run that loop right and automate a lot of that tool calling."
- "We're in the early stages of giving Claude a computer... what if it had a persistent computer that was always there."

---

## Source notes

### Source Metadata

- **Title**: Building the future of agents with Claude
- **Channel**: Anthropic
- **Uploader**: Anthropic
- **Upload Date**: 2025-10-02
- **Duration**: 22 minutes (1331 seconds)
- **Views**: 57,473
- **Likes**: 1,356
- **Categories**: Science & Technology
- **Tags**: (none)

### Source Description

Anthropic's Alex Albert (Claude Relations), Brad Abrams (Product) and Katelyn Lesse (Engineering) discuss the evolution of building agents with Claude, the latest Claude Developer Platform features, and why agents perform best when developers "unhobble" their model with tools. 

Learn more about the Claude Developer Platform: https://www.claude.com/platform/api

00:00 - Introductions 
00:30 - What is the Claude Developer Platform? 
2:30 - What is an AI agent
3:15 - Building frontier intelligence for AI agents 
4:00 - Reducing model scaffolding to build better agents
5:05 - The evolution of agentic frameworks 
6:40 - Unhobbling the model with tools like web fetch
8:35 -  Building agents with the Claude Agent SDK (formerly the Claude Code SDK)
10:50 - Best practices for identifying agentic use cases 
11: 40 - Driving better agentic outcomes with the SDK
14:35 - Best practices for managing context and memory with Claude
19:00 - The future of the Claude Developer Platform (observability, computer use, and other ways to unhobble the model)

---

## Raw source

Because as a developer like my
creativity ends at some point. I can
only think of so many use cases. But the
model like anything anything comes with
the model will figure out a way to go do
that thing.
>> Hey, I'm Alex. I lead cloud relations
here at Enthropic. Today we're talking
about building the future of agents with
cloud and I'm joined by my colleagues.
>> I'm Brad. I run the PM team on the cloud
developer platform.
>> I'm Caitlyn. and I lead the engineering
team for the cloud developer platform.
>> Let's talk about the cloud developer
platform.
>> Let's start with that.
>> Let's start with that.
>> Start there.
>> It used to be called the anthropic API.
>> Yeah.
>> We just went through a big name change.
>> Can you walk me through why we made that
change and also what this new platform
is and what it encompasses?
>> Yeah, totally. So the cloud developer
platform really encompasses our APIs,
our SDKs, our documentation, all of our
experiences within the console, and
really everything that a developer needs
to actually build on top of Cloud. We're
really humbled, proud to serve um some
really awesome customers around the
world who are trying to what we like to
say raise the ceiling of intelligence um
using Claude. Um and the platform really
enables them to do that. Um and I would
say one of my favorite parts about it is
the platform doesn't just serve
customers uh externally. The platform
actually serves our internal products.
So um we love telling people like claude
code for example is actually built
directly on our public platform.
>> I see. Yeah. I mean I think when we
started we were just the enthropic API
and very simple access to the model but
over the last year or so we've added so
many features to it. Um we added prompt
caching, we added a whole separate batch
API. Uh we added web search, a web
fetch, this context management support,
the code execution. So all these tool,
you know, now this kind of we feel like
yeah, it's aspirationally we're it's re
it's a platform now.
>> I see. So there's just a lot more to it
now. It's evolved in pretty drastic way
over the past year.
>> Yeah.
>> Yeah. And I think that's what developers
were sort of calling it anyway, you
know. So, it's always natural to just
sort of go with what developers
>> we were a little late to the game there.
Had it right.
>> We've made our amends.
>> Um, one of the cool things you can do
now as we're moving from the sort of
chat model to maybe this more aentic
future is building agents as part of
this developer platform.
>> Um, before we get into how we're
actually doing that on on the platform,
can we talk about what even is an agent
to begin with?
>> Yeah, I mean agents is it's almost sort
of a buzzword, right? like everybody you
talk to now is building agents and and
whenever a industry tech term gets to
that level, you know, the definition
gets very gray. Everything everybody
builds is an agent. But in anthropic,
what we really think about agent is
where the model is taking some uh
autonomy to be able to choose what tools
to call to call those tools to handle
the results and kind of choose the next
step. So, uh, as a as a foundational
research lab, like leaning into the
model and being and and what it its
reasoning, how it decides what to do. We
think that's a really important element
of what an agent is.
>> So, it's kind of like the the aspect of
it being autonomous in some sense.
>> Yeah. Yeah. I mean, I think there's also
I mean, we have customers doing really
useful workflows where they're sort of
predefining the path that Claude should
walk and that that is a super useful
thing to do. But what's nice about the
agentic thing is as the model gets
better every couple of months, you know,
we release a new model and it with a
true agentic pattern, you know, those
services are just going to get better.
whe where if you build a workflow with a
lot of scaffolding in it, you kind of
put bounds on the model, which is maybe
okay in some use cases, but that means
that you're you may not take advantage
of the next level of intelligence that a
next model release gets.
>> Yeah. So, it seems like there's this
interesting trend with agents at least
over the past 6 to 12 months where like
you've said the scaffolding has been a
bit of a hindrance and maybe we're
dropping some of that.
>> Um,
>> can you explain the intuitions behind
that around
Is is this actually the future is like
we give less and less things to the
model?
>> Yeah, I mean I think over time what
we're seeing is the scaffolding the
model needs to be able to accomplish
tasks is needing less as the as the
level of intelligence of the model goes
up and we have every we believe it's
going to keep going up. Um that basically
the model has more contextual understanding
of the highle task that it's trying to
accomplish. So therefore, it doesn't need
as many sort of guard rails, right? And
in fact, those guard rails in some cases
become some like a liability to have.
We've had customers try out new models
and say, "Oh, well, it's actually only
just a little bit better." And then we
kind of look into it with them about
what's going on and it turns out, well,
yeah, they were constraining it in ways
that makes it harder for them to see the
intelligence of the model. Uh does this
match what we see in the field with like
our customers where they're also
following these same trends? I know at
the limit we have customers exploring
all sorts of innovative techniques for
managing cloud.
>> Yeah, totally. And there's actually a
lot of like discourse about this right
now, right? Like what is an agent and
and what does it need? What do you need
to build? And and there are people
saying, you know, it's just a while
loop. Like we don't have to try that
hard. And um I think ultimately uh
there's a lot of there's been a lot of
evolution of frameworks that people are
putting around the model that are
helping them orchestrate their agents,
try to get the most out of the model.
And um I think what uh the industry is
maybe kind of circling around is a lot
of that has become maybe too heavy and
maybe too opinionated. Um and which is
why you kind of get the the people
coming back to like it's just a while
loop and that is all you need. Um, and I
think what we're trying to to do there
is to say maybe in a lot of ways it is a
while loop, but the things we can more
uniquely do to help people get the most
out of the model is a lot of those
tools, those features and otherwise. And
so what we want to do is put um, you
know, frameworks and tools and platform
out there that is opinionated to some
extent on how people should use those
tools. Um, but it's not this like super
heavy framework that really like to
Brad's point gets in the way of what the
model's ultimately trying to do. So,
it's strike the right balance. It's
like, you know, we've we've seen what a
lot of people have tried to do. So, we
know we can be opinionated there. Um,
but we want to be lightweight in the way
that we're doing that and make sure that
the real thing we're doing is helping
you get the most out of the model. Um,
without, you know, bogging you down in
some super heavy framework.
>> Right. So would you describe part of the
strategy here then as providing these
auxiliary tools and things that we can
give to the model but we're not
necessarily like placing the bumper on
like the model itself or
>> yeah we think about we think about it as
like how do you unhobble the model like
the model already has a lot of
capabilities in fact I'm convinced that
even if you take a current generation of
models there's way more intelligence in
there than we've been able to unlock
>> but anyway that intuition is if you just
give the model like the tools it needs
and like set it set it free, let it be
able to use those in the right way. um
you'll get great results and and I think
like a good example of that is we
launched this serverside uh web search
tool and web and web fetch tools and
it's been interesting to watch customers
use those and you know all we did really
I mean it's a very minimal prompt that
we have we just give it the web search
tool and like all of a sudden deep
research tasks are like almost
completely done with with just turning
on that uh switch on the API because the
model will call that tool. It'll look at
its results. It'll say consider it and
say, "Okay, maybe I need to call, you
know, do these other searches." And
then, "Oh, that fourth link you
returned, that's the great one." It'll
do a web fetch on that link and bring
that data back. And really, all that
very autonomously on its own kind of
deciding,
>> right? I I think it's almost kind of
like an interesting shift in like where
the intelligence of a system is being
applied from like the developer having
to apply their intelligence to guiding
towards like the model now figuring it
out. And it's so exciting what the model
does it because as a developer like
>> my creativity ends at some point. I can
only think of so many use cases but the
model like anything anything comes with
the model will figure out a way to go do
that thing. So
>> it's great great to unhobble the model.
>> Yeah. So if I'm a developer today and
I'm getting started building with the
developer platform,
>> what do you recommend? What are some
best practices or ways for me to get
started?
>> Yeah. So um super tactically actually
the number one thing that we recommend
right now is the cloud code SDK. Okay.
>> Um and what's really really interesting
about the cloud code SDK is we
essentially built an agent harness an
agentic harness um around the model to
run that loop right and automate a lot
of that tool calling and otherwise
feature use. And obviously originally
was built for coding purposes. Um, and
what uh the team really quickly figured
out was like actually this is like an
excellent generalpurpose agentic
harness. Um, and so what the SDK does is
it gives people a perfect out of the box
solution to actually just start
prototyping agents um without having to
go and build, you know, the loop with
all the tool calling and otherwise. It's
built on top of the messages API and all
those same tools that um we're
mentioning, but it kind of gives you
that really great starting place right
out of the box.
>> Right. I feel like this is a pretty
common misconception at least when I
talk to developers about the cloud code
SDK. So like I'm not building a coding
application like why would I want to use
this
>> but
>> you can kind of remove the coding
specific parts right
>> I mean I think that's a great example of
what we were talking about removing
scaffolding on the model. It's like once
we got done removing things from the
from cloud code to really unhobble the
model, it turns out there was nothing
coding left. When that when you remove
everything else, then it's just an
agentic loop and you're you're really a
minimalistic thing to give uh claude
access to to a file system to a set of
like Linux command line tools um to the
ability to you know write code and
execute that code. So those are all very
generic kind of capabilities that turns
out could solve a wide variety of
problems,
>> right? Yeah. I feel like something I've
been running up to in like my own side
projects and also seeing with projects
within Anthropic is
>> before the cloud code SDK, everybody's
implementing some form of managing
prompt caching or some form of managing
their tool calls and that loop,
>> right?
>> And now it's like, oh, just start at
this
>> base point and then build from there.
>> You start a little bit higher up. Yeah.
Yeah. Yeah.
>> So it's like a further level
abstraction. I think that's super
interesting. I mean I think I think the
other really interesting thing to think
about especially for businesses looking
at agents is like what use case to go
target right so thinking beyond the
technology like what is the actual
problem to go solve and I think you
know we we see a lot of customers and
like doing a lot of things we love all
of it but where you know the biggest
impacts are is where the customer has
thought hard about what's the business
value of this like will it actually save
this any engineering hours or will it
help us remove this much uh uh manual
work or whatnot and being able to
articulate like what you expect the
outcome of the agent project to be I
think is really helpful in in defining
the scope of the agent
>> right and tying back one more time to
the SDK so it seems like it's been
really really useful for like individual
developers like myself you know starting
out
>> y
>> and just wanting to get hacking on
something really
for these customers, for enterprises
that are actually trying to get real
business value out of these things,
>> should they be using the SDK? Is it
ready for them? Is it ready for scaled
use like that?
>> Yeah. So, um I think in a lot of ways it
is. In a lot of ways, if you are in a
spot where you can like you can deploy
that runtime essentially that's what you
get out of the SDK is an agentic loop
runtime. um you can go and deploy that
runtime wherever you want whenever
you're ready to do so. But I think what
we're really trying to do is take the
spirit of what the SDK unlocks for
people like go kind of up to that higher
order abstraction where we give you the
loop, we give you a lot of tool
calling in an automated way um and say
how can we learn from that and give
people out of the box solutions that
like at scale um will really be able to
solve for their use cases. And I think
that's a lot of where we're kind to
trying to go with our road map
throughout the rest of the year. Um, and
one really important bit when we think
about that is if the entire goal here is
to help our users like really raise that
ceiling of intelligence, get the
absolute best outcome out of the models,
then higher order abstractions are not
just make it easier because you don't
have to write all that code yourself.
It's actually like how can we like
really truly help you get the best
outcome
>> because we uh we're in the room with
research. we're in the room with
inference like we know how to make sure
that our abstractions, our agentic loop
is going to be extremely powerful and
extremely good at working with claude.
Um and the last thing that I would add
in there is especially as these things
get longer running and as we provide
more and more tooling to help people get
at those longer running tasks, um
another big problem that our users we
know are going to keep trying to solve
is uh observability within those longer
running tasks. Um, and so that's that's
one of the most common things that comes
up for folks is, you know, I I have
these longunning tasks. I'm trying to
get um these really great outcomes, but
um you know, I might need to do some
steering or I might need to tune my
prompt or I might need to do some
steering or I might need to tune my
prompt or I might need to think about
tool calling a little differently. And
um that's something that we know we can
give people that observability through
the platform over time. And that's
another big area of focus for us.
>> Okay, that's really interesting. I mean
this has been a huge issue that's
starting to come to a head with agents I
think especially as you trust them to go
work in some you know other application
in the background
>> how do you make sure they're actually
doing the right thing and then if you're
deploying them
>> yeah how do you audit it like if we're
going to give some level of autonomy to
the system there needs to be a way to
audit it and like make sure the right
things are happening so that you can
tune things and whatnot so I think
observability is really really a key
piece of this
>> and putting a pin there. I want to ask a
question on just like the future of how
we're going to address that.
>> Um before I do,
>> uh is there other tools that exist right
now that folks should be aware of when
they're getting started with the
developer platform?
>> Things have you've found helpful or
useful?
>> Yeah, I mean I think there's a So we
mentioned uh web search and web fetch.
Uh I think another big thing that we're
seeing is um customers uh have to do
right now have to do a lot of work to
manage the context window. So by default
cloud has 200k tokens of context. We
have a mil mill million token available
now in beta on sonnet which is great but
even a million there's a limit there. Uh
and what what many customers have told
us is that um they get better outputs,
higher intelligence if they uh even use
a smaller part of the context. And so
we've done we have a couple of cool
features that are just coming out to
help developers manage that context. So
in these agentic loops a lot of times
you're doing 10 15 100 tool calls as you
edit this file or look up data in this
database or uh you know send this email
and each of those tool calls takes up
like a know 100 200 a thousand tokens
right
>> uh and so we have this cool feature that
lets you uh lets the model actually
remove some of the older tool calls that
are not needed anymore.
>> Interesting. Uh and that get that gives
just just like you if you declutter your
desk and declutter your notebook like
you can focus a little bit better. So if
you declutter the prompt actually the
model can actually focus a little bit
better.
>> Interesting. So okay removing
unnecessary context is there a risk that
we remove necessary context.
>> Yeah.
>> Yeah. Yeah. So um we have some some
guard rails and some bounds around it.
So you don't but the general rule is if
you um remove we try to remove the tools
that are like several turns back okay
that the model's already made decisions
based on those tools but if you AI I was
playing with it uh recently and I
removed the tools that it was just
called and it's oh my tool results are
gone I don't know what to do and then
the but the model the sonnet doesn't
give up like it's like I'm just going to
call this tool again you know um
>> but yeah so generally we have put some
bounds on that because of that
experience And so we we do preserve the
most recent set of tools.
>> I see.
>> And then the other cool thing we do is
um tombstone it. So by that we mean when
we remove the tool calls, we put a note
in there to the model that say oh the
tool results for the search call were
were here.
>> Oh, okay.
>> And they've been removed.
>> So the model's not completely like
memory wiped.
>> Exactly. I I think we found the model
does better if we just give it a little
more context about what is happening.
Right. Um and and so that's a that's a
key feature,
>> right?
>> Um and then the other one is this like
um kind of aentic memory uh feature that
we've added. Uh and there we we have
seen that the model um does like right
now if you give a task to the model say
a deep research task or or play Pokemon
or whatnot like the model does about the
same every time it runs. Um, but if you
give a human a task, like the fifth time
the human does a task, like they do it
like way better because they've learned,
okay, if I'm gonna do this search, okay,
probably the Wikipedia site is better
than this other site or whatever. Like
they learn which things. So they get
better over time. So we've given this
memory tool to the model now so that the
model can actually take some notes while
it's going and say oh like I realize
that this website maybe isn't the right
one or if I'm doing a search it should
be like this or if I'm looking up I
should use this database not that
database or whatnot and it makes those
notes and then when it's stumped it can
actually go back and review its notes
and say okay like oh I'm starting this
task let me go read the notes so I can
figure it out.
>> Cool. So we're handling all of that for
the developers.
>> Yeah. Yeah. Well, we're giving the model
like this core capability to do memory
and right now we're letting the
developer manage the memory. So because
you know different developers like they
might want to store it in some cloud
storage or they might want to store it
somewhere else. So we're letting
developers figure out exactly where to
store the memory. That way they have
more control over that,
>> right?
>> Um
>> but exposing the tool
>> but expose the tool. The tool.
>> So going back again to to a roadmap
question here. So it sounds like there's
ton of new features that we've recently
launched. There's a lot of momentum and
now there's other offerings as well like
the cloud code SDK and things coming out
soon.
>> Um what are you most excited about
Caitlyn? What's the what's the future
looking like here in the next 6 to 12
months?
>> Yeah, so we talked a little bit about
these higher orders of abstraction where
we can um really just make it uh as as
simple as possible for you to get the
absolute best outcomes out of claude. Um
and we want to pair that with the
observability that we talked about. um
so that you can really like you know see
the data and take those insights from
those longer running tasks. Um and if
you combine these things together and
start to think about some of the
capabilities like memory that Brad just
talked about, you can really start to
see this flywheel where over time we're
not just able to help you get the best
outcomes out of Claude, but we can help
you get self-improving and continuously
improving outcomes out of Claude. And
that to me is kind of the the like
galaxy brain magic of the road map is
get to a point where um you know we we
have people coming to us, they're
building on Claude, they're they have
their task, they know what they're trying
to do. Um and they get these like really
like aha moments where over time it's
getting better and better and better. Um
and you know that is that's kind of the
biggest thing that in everything that
we're doing we're trying to make sure
we're going after.
>> That's awesome. Yeah. Yeah, I mean I
guess I'd have to say I'm I'm always
excited about model launches. Like it's
like Christmas like what how what will
will it what will be possible now? So I
love playing with the model launches
they come out just unlocks more use
cases. Some use cases that you know
we've been working hard on and trying to
improve which is satisfying to see but
also some things I had no idea the model
would be able to do this thing. you
know, now it draws the ASKY picture so
much better or what you know, whatever
the very important things. But beyond
that, the other thing I'm really excited
about is um we're we're in the early
stages of giving Claude a computer. You
know, I think about if we hire an
employee here at Enthropic and we we
welcome them. Here's your first day, but
we don't give them a computer like they
would not be very successful at
Enthropic. So like right now essentially
everybody you is using claude and it
doesn't have a computer. So I'm I'm
really excited about giving Claude a
computer and I you see like the very
baby steps of that with the code
execution tool uh where the the model
can write code execute it on the VM and
get the results back. So like it can
like zoom in on images or take a Excel
spreadsheet and create like amazing data
analysis with charts and graphs. And
that's just the baby step. Like what if
it had a persistent computer that was
always there and it could like organize
the files in there the way it needed and
get the tools set up the way it wanted.
And um I just think there's a lot of
headroom to to that scenario.
>> Yeah. And I guess that all ties back
into this unhobling.
>> Exactly. Exactly. It's all about anomaly
model. That's exactly just give give
Claw the tools.
>> Yeah.
>> Well, I'm excited for that future.
Thanks so much for this conversation.
All right. Cool. Yeah. Thank you.
[Music]