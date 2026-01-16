---
global-template: source
source-title: Build Your First Voice AI Agent in 20 Minutes with LiveKit (Open Source)
source-url: https://www.youtube.com/watch?v=TXVyxJdlzQs
source-platform: youtube
source-type: video
source-creators:
  - - - Cole Medin
source-published-date: 2025-10-04
source-fetched-date: 2025-10-05
source-length-minutes: 18
source-status: drafted
test-score: 2
---

# AI notes

## TLDR
- This video demonstrates building voice AI agents using LiveKit, an open-source Python framework, as an alternative to restrictive platforms like Vapi or Bland.
- It covers local development, adding custom tools, integrating with real APIs via MCP, and deploying agents to LiveKit Cloud.
- The video highlights LiveKit's flexibility, scalability, and ease of use.

## Key ideas
- Traditional voice AI platforms are restrictive and costly, lacking customization and control.
- LiveKit offers an open-source, Python-based alternative for building highly customizable, scalable, and self-hostable voice AI agents.
- Building a basic LiveKit agent is straightforward, requiring minimal code.
- LiveKit agents can be extended with custom tools and integrated with external APIs (e.g., Airbnb) using MCP servers.
- LiveKit agents can be deployed to the cloud for broader accessibility and tested in a browser playground.

## Detailed Summary
- The video introduces LiveKit as a superior open-source alternative to proprietary voice AI platforms (Vapi, Synthflow, Bland.ai).
  - Proprietary platforms often impose high costs, limit customization, and operate as "black boxes."
  - LiveKit, a Python framework, provides developers with:
    - Full control over conversation logic.
    - Direct tool integrations.
    - Flexibility to self-host or deploy to LiveKit Cloud.
    - Emphasizes speed, reliability, and scalability.
- The tutorial demonstrates building a basic voice AI agent in under 20 minutes.
  - It starts with a 52-line Python script.
  - It progresses to adding custom tools, such as a `get_current_date_and_time` function, using the `@function_tool` decorator and docstrings for agent instruction.
  - It further illustrates integrating more complex tools:
    - Mock Airbnb search and booking functionalities.
    - Connecting to a *real* Airbnb API via an MCP (Multi-party Communication Protocol) server, showcasing LiveKit's ability to handle external API calls.
- Finally, the video covers deploying the LiveKit agent to the cloud.
  - This involves using the LiveKit CLI (`lk cloud auth`, `lk app env`, `lk agent start`, `lk agent create`).
  - Testing is done in a browser-based playground.
  - The presenter also briefly mentions advanced features:
    - Multi-agent workflows.
    - Advanced tool integrations.
    - Telephone integrations.
  - Viewers are encouraged to explore LiveKit's extensive customization capabilities.

### Key quotes
- "Voice AI platforms like Vappy, Synthflow, and Bland.ai are good for getting you started, but they come with their trade-offs. And honestly, I've regretted using them for use cases in the past." @ 00:00
- "You don't run your own infrastructure. Your tool calls are slow. You're paying per minute rates that are premium. and it's really hard to truly customize your agents when it comes down to it." @ 00:00
- "LiveKit is an open-source Python framework for building your agents with code. So, it gives you full customization, control over your conversation logic, direct integrations with your tools and MCP servers, and you can actually self-host everything or deploy your agents to the LiveKit cloud. It's fast, it's reliable, it's very scalable, and I know you're probably thinking it's going to be a lot more complex than something like Vappy or Bland, but it actually isn't. It's really easy to build agents with LiveKit." @ 00:00
- "It is as easy as creating any Python function and then adding the at@ function tool decorator. So when we create a function within the agent class... And we add this decorator, we're telling the LiveKit agent, here is a capability that you have." @ 06:45

## Source notes

### Source Metadata
- Video URL: <https://www.youtube.com/watch?v=TXVyxJdlzQs>
- Video ID: TXVyxJdlzQs
- Channel: Cole Medin (<https://www.youtube.com/channel/UCMwVTLZIRRUyyVrkjDpn4pA>)
- Upload Date: 2025-10-04
- Duration: 00:18:59
- Views: 2083
- Likes: 209

### Source Description
Voice AI platforms like Vapi, Synthflow, and Bland can only get you so far. You're paying premium rates, you'll hit walls when you try to heavily customize your agent, your tools are slow, and you're working within someone else's infrastructure. It's a big black box.

LiveKit is different. It's an open-source Python framework where you write actual code for your voice agents. You get full control over your conversation logic, direct integration with your tools and MCP servers, and the ability to self-host or deploy to LiveKit Cloud. It's fast, reliable, easy to build with, and extremely scalable.

In this video, I'll walk you through building your first voice AI agent with LiveKit in under 20 minutes. We'll set up the agent locally, test it in the terminal, then deploy it to LiveKit Cloud. I'll even cover building custom tools and connecting MCP servers to your LiveKit agents!

- If you're looking to join a community for early AI adopters to master AI Coding & AI Agents and transform your career or business, check out Dynamous:
https://dynamous.ai

- Once you're in the community, here is the link to the LiveKit workshop!
https://community.dynamous.ai/c/live-events/community-workshop-a69e7b

- GitHub repo with my LiveKit voice agents:
  <https://github.com/coleam00/ottomator-agents/tree/main/livekit-agent>

- LiveKit Agents GitHub:
  <https://github.com/livekit/agents/tree/main>

- Guide to deploying voice agent guide:
  <https://docs.livekit.io/agents/start/voice-ai/>

- LiveKit Cloud:
  <https://cloud.livekit.io/>

- LiveKit Agent Playground:
  <https://agents-playground.livekit.io/>

00:00 - Introducing LiveKit for Building Voice AI Agents
01:28 - Getting Started with LiveKit
02:21 - Building a Voice Agent from Scratch Together
05:57 - Testing Our New LiveKit Voice Agent
06:45 - Adding a Basic Tool to Our Voice Agent
08:14 - Adding Mock Airbnb Tools to Our Voice Agent
09:57 - Integrating the Real Airbnb API through MCP
12:06 - Testing Our Airbnb Voice Agent Live
13:03 - Dynamous LiveKit Workshop
13:45 - Deploying Our LiveKit Agent to the Cloud
17:30 - Live Voice Agent Test in the Browser
18:11 - More LiveKit Features & Final Thoughts

Join me as I push the limits of what is possible with AI. I'll be uploading videos every week - Wednesdays at 7:00 PM CDT and often more!


### Raw source
Voice AI platforms like Vappy,
Synthflow, and Bland.ai are good for
getting you started, but they come with
their trade-offs. And honestly, I've
regretted using them for use cases in
the past. I've talked to businesses
before that have specifically switched
from Vappy to a custom solution because
you run into problems with these tools.
You don't run your own infrastructure.
Your tool calls are slow. You're paying
per minute rates that are premium. and
it's really hard to truly customize your
agents when it comes down to it. I
respect these platforms for being easy
to use and pretty powerful overall, but
it is just a big black box. Luckily
though, LiveKit is different. LiveKit is
an open-source Python framework for
building your agents with code. So, it
gives you full customization, control
over your conversation logic, direct
integrations with your tools and MCP
servers, and you can actually self-host
everything or deploy your agents to the
LiveKit cloud. It's fast, it's reliable,
it's very scalable, and I know you're
probably thinking it's going to be a lot
more complex than something like Vappy
or Bland, but it actually isn't. It's
really easy to build agents with
LiveKit. And that's what I'm going to
show you super quickly in this video.
How easy it is to get started building
simple agents where you can customize
your tools and the different models for
text to speech and speech to text. I'll
show you how we can build a voice agent
locally and then even deploy it to the
cloud and interact with it in our
browser. So this GitHub repository that
we're looking at right here, I will have
linked in the description. It is a great
place to get started. And a lot of what
I'm going to be guiding you through
today is based on the examples that they
have here. So we have this first quick
start and also scrolling down they have
a lot of different examples. You can
explore the different kinds of voice
agents that we can build with live kits.
They got a basic starter one that can
deal with background audio like having
that play as the agent is talking,
dynamic tool creation, building an
outbound caller and they have a lot of
cool integrations with things like
Twilio. We have MCP support. I'll show
you that later as well. Video avatars.
There's so many things that they offer.
But right now, I want to cover building
the most basic version of a LiveKit
agent. Then we'll build on top of that
over time so you can see how to really
customize it. Building the kind of thing
that we aren't going to be able to do
with an out-of-the-box tool like Bland,
Vappy, or Synthflow. So, I will have
this repository linked in the
description as well. This is where we'll
be building the agents live that I have
for you today. What you can take as a
foundation and build on top of to create
really anything that you want. And if
you want to read through this whole
readme, I've got setup instructions for
everything. But right now, I just want
to dive right in and build with you. So,
let's open up our first basic agent. I'm
going to actually create this section by
section from scratch to show you how
easy it is. The first thing we need to
do in Python is import all the
dependencies that we have from LiveKit.
You can see some different providers
here for part of our voice pipeline.
More on that in a little bit. We're
going to load our environment variables
including things like our OpenAI API
key. And then we're going to create a
agent class. So we're calling it
assistant. It's based on the agent class
that we're importing from LiveKit.
Everything that we build going forward
is going to be within this assistant
class. And so we create up our agent and
then we use this class to connect to
LiveKit either self-hosted or in the
cloud. And I'll show you at the end of
this guide as well. And so first we have
our init function. And this is where we
get to specify the system prompt for our
voice agent. I'm just keeping it very
very basic here. And then we have our
entry point. So this is what is called
when we are trying to use our agent for
the first time when a user calls into
it. However, we are invoking it. And so
we create what is called an agent
session. And there's a lot of different
parameters that we can set here to tweak
our agent. A few of the most important
ones that I have here is all about
creating what is called the voice
pipeline because the way that it works
with LiveKit is you have your
speechtoext model that sits at the front
and then it goes to the large language
model. So whatever speech it transcribes
into text it goes to the LLM to get the
response and then the response goes
through a texttospech model so that we
have the voice come out the other end
for us as the end user. And there are
also voicetovoice options with the
OpenAI real-time API for example. So
there's quite a few different things
that you can set up in LiveKit if you
wanted to use Enthropic for the LLM
instead or Cartisia for speech to text.
There's a lot of different providers
that are available if you want to check
that out in the LiveKit documentation.
But this is our session where we define
our voice pipeline. And now we get to
start the session. So in the entry point
we're invoking our agent. Now we're
starting the session creating a room.
This is where we maintain the
conversation history between the user
and the voice agent. And we're just
passing in our agent because obviously
that's what we want to use for this room
session. And then the other thing that
we're going to do is generate an initial
greeting. And so at any point in our
agent code, we're able to generate
replies. That's one of the more
customizable components we have to live
kit that we don't have with something
else. like in our Python code anywhere
we want. We can just inject it to say
something based on the instructions that
we give it. And so when we kick off the
session, the user doesn't actually have
to be the first one to talk. We can have
it generate something. And so we're
telling it at a high level, this is
literally just a prompt to an LLM.
Basically, we're telling it to greet the
user warmly in some way. And you can
tweak this however you want. And then
this is the very last thing that we have
to do. All we have to do when we start
this script here, the LiveKit basic
agent.py, Pi is we're calling the
CLI.run app and then we're passing in
this entry point where we have the whole
agent session and room and greeting set
up. That is it. 52 lines of code.
Congratulations. You've already created
your first live kit agent. It is that
easy. And so let's test it out right
now. Then I'll show you how you can
start to really add in the fun stuff.
All right, so back over to the Remi cuz
I have instructions for running
everything. If it is your first time
executing this LiveKit agent, you do
need to download the model files for it.
I already have that run. So I'm going to
go right to running the console command.
So whenever we invoke a LiveKit agent
through a Python script, there's a few
different options that we have as these
commands that we have as just like the
last argument here. Console is how we
get to use our agent in the command
line. So let's go ahead and run this and
listen to this conversation here. It'll
even start by giving us a greeting. So
here we go.
Hi there. How can I assist you today?
Hey, in five words, tell me what is so
cool about LiveKit. scalable, real time,
open-source video.
All right, it sounds really, really
good. Cool. Okay, so I'm going to go
ahead and close out of this here. Things
are working perfectly. So that is our
super basic test. There's nothing fancy
with our voice agent at this point
because we haven't given it anything
special through tools. So now let's go
ahead and add a tool to our agent. And
watch this because if you blink, you're
going to miss it. There we go. All
right, we have now added a tool to our
LiveKit agent. It is as easy as creating
any Python function and then adding the
at@ function tool decorator. So when we
create a function within the agent
class, like I said, everything we're
adding is just within the agent class
here. And we add this decorator, we're
telling the LiveKit agent, here is a
capability that you have. And the dock
string, this comment that we have at the
top of the function is going to tell the
agent when and how to use this tool. So
we can do things like specify the
arguments that we have here. So it's
exactly the same as when we add tools
into our agents with pedantic AI or crew
AI. It works in just the same way.
LiveKit really is just another AI agent
framework, but for building voice agents
in particular. It's very very cool. And
so this function is just a basic one in
general to get the current date and time
because large language models due to
their training cutoff don't actually
have that by default. And so I'm going
to go ahead and save this agent. Go back
over to my terminal and let's invoke it
again and this time ask it what the
current time is. Can you tell me what
the current time is, please?
Current time is 4:21 p.m. on October
3rd, 2025. Is there anything?
All right, that is looking really good.
And you can see that it used the get
current date and time function just like
we have defined in our Python code. And
then just for fun, let's add a couple
more tools to this agent. So, I'm going
to turn it into an Airbnb assistant that
can help me with searching and booking.
And so, to keep it simple, I'll have
mock data for a bunch of available
Airbnbs. And then I'll create one tool
to search for Airbnbs. And so the
parameter here is the city that we're
searching in. So the LLM will actually
decide this parameter when it decides to
invoke the search Airbnbs tool. And we
specify the arguments in this dock
string as well because that is included
as a part of the prompt to our LiveKit
agent. And again, this is just using a
bunch of mock data here. And then I'll
just add another tool so that we can
actually book the Airbnb. And if any of
these arguments it doesn't actually know
yet from our conversation, then it will
clarify with us. So cool. I'm going to
go ahead and save this, go back over
into our terminal, and let's invoke our
agent for the third time.
Hi, welcome. How can I assist you with
your Airbnb plans today?
All right, tell me the top Airbnb in San
Francisco. Really quickly here,
here are three top Airbnbs in San
Francisco. One, Cozy Downtown Loft, $150
per night.
Okay, cool. I am sold on the Cozy
Downtown Loft already. I want to go
ahead and book that right now.
Great choice. Could you please provide
thee with your name and the check-in and
checkout dates for your stay?
Cole, I'll go ahead and check in on
November 1st and I'll check out on
December 30th.
You're booking for the cozy downtown
loft from November 1st to December 30th
is confirmed. Cole,
you'll get a Let's go. Cool. All right,
I'm going to go edit in this ear.
Looking really good. So, there we go. We
have some mock data here for Airbnb. So,
it's not really a voice agent that's
doing something for us, but if we were
really using the Airbnb API, this would
be a super solid voice agent that can
help us find our Airbnbs. Pretty cool.
Now, I thought it would be fun to
actually show you using the real Airbnb
API in the LiveKit agent. This is a bit
off the cuff, so I'm not going to dive
super deep into this right now. I do
actually have a video coming out next
week on the Docker MCP catalog, so check
that out. Stay tuned for that because
that's how we're going to get quick
access to the Airbnb MCP server. And so
this won't actually book an Airbnb for
us. I want to be really clear on that.
It's probably a good thing. We don't
want our agent to book on our behalf,
but it's actually real search finding
real Airbnbs for me now instead of using
the mock data. So I've got this added to
my servers here. And then I am running
the MCP gateway from Docker so that I
have this ready to be connected to from
my LiveKit agent. And I'm going to be
covering all of this in the Wednesday
video on the Docker MCP catalog. So
again, stay tuned for that. So it's
running the streamable HTTP protocol on
port 8089. So you'll see given that how
we connect to it in LiveKit in just a
little bit here. So I have a second
agent where I have this MCP integration.
And there are some differences between
this script and the last basic agent
even besides the MCP stuff. I was just
playing around with more features in
LiveKit. Just showing you some things
like we can fire off certain events
within the whole conversation flow like
when the user starts speaking or stops
speaking. We can have custom logic built
in. So just trying to give you a little
bit of an idea of how we can continue to
extend and customize LiveKit agents even
more. Like it definitely is a lot more
you can than what you can do with other
platforms like Vappy. And then we have
the MCP servers. Literally all we have
to do it's so easy. We have our agent
session here defined in pretty much the
same way with our whole voice pipeline.
And then all I have to do is add the MCP
servers. This is just a list of all the
servers that I want to connect to. So we
have streamable HTTP for the Docker MCP
gateway that I have running. And all I
have to do because this is just running
locally. There's no authentication. I
just have to give the URL to my MCP
server. It is that easy. And then boom,
this agent is now connected. Let's go
ahead and run it and use the real Airbnb
API. All right, back in the terminal,
let's run a very similar command, but
this time for our MCP agent instead of
our basic one.
Hello. How can I assist you today?
Uh, I want you to search for Airbnbs
around Minneapolis, Minnesota that I can
book for this week. Just give me the top
one really quickly here.
The top Airbnb listing in Minneapolis
for this week is a studio in historic
Brownstone, downtown MLS. It has one
bedroom with one queen bed, a rating of
4.79.
Really, really good. Cool. I'm going to
stop it here. So perfect. We are now
using a real Airbnb API call to get that
Airbnb. So cool. That's everything that
I have for you for building LiveKit
agents. It really is easy and powerful.
And the last thing that I want to show
you is how we can take our LiveKit agent
that we've been running locally and
actually deploy it to the cloud. So we
can interact with it in the browser. And
I'll even speak to how you can set up a
phone integration so you can actually
have a phone number with your LiveKit
agent behind it. Now, before we get into
that, the last thing that I want to say
as far as building agents and the tools
that we have for this, there's a
workshop that I did in the Dynamis
community where I built a more advanced
LiveKit agent also with the help of
Archon that has a complete rag
implementation behind it. And so,
definitely come check out dynamis.ai if
you're interested in workshops like
this. The recording for this is
available for you immediately when you
join the community. And there's a ton of
other resources that we have in here for
building AI agents and working with AI
coding assistants. So I just want to
mention that really quick because I have
already covered LiveKit in the Dinest
community. But with that, let's go ahead
and take our basic agent that we have
here and now deploy it to the cloud. Now
I've got custom instructions in the
readme to make the deployment to the
cloud as simple as possible. But it is
all based on the voice AI quickart that
we have here in the live kit docs. This
is a little bit more complex because it
assumes you don't have an agent yet. We
already have one. So that's why I have
my own instructions for you. And so
following this, we can either deploy to
the LiveKit cloud, which is what we're
going to be doing just because it's the
fastest and most convenient, but you can
also self-host because LiveKit is free
open source. You can run all of the
infrastructure if you want complete
control for your voice agents. Now
LiveKit is not sponsoring this video or
anything. I just want to deploy to my
cloud platform here because it is the
easiest to show you how to get started.
And so you can host your first agent
completely for free. I'm not paying for
anything for LiveKit or for Deepgram in
this video. Literally just my OpenAI API
key is the only thing that I have to pay
a single scent for. So that's what we
got going on here. Going back to the
read me here. Let's go down to the
instructions that I've got once we
actually want to do our deployment. And
so first thing you have to sign up,
create your LiveKit cloud account. I got
the link right here. And then you have
to install the LiveKit CLI. So based on
your operating system, there's a
different command. I'm on Windows. And
so in my terminal, I've already run this
windget command. And then you need to
authenticate with the LiveKit cloud. So
you just run LK cloud off. So all of our
CLI commands with LiveKit now is just
going to be the LK command. And so it'll
walk you through authenticating in the
browser. and then you'll be good to go.
Now, the next thing that you need to do
is set up your environments. And this is
where I'll actually go and show you
running these commands alongside. So,
I'll go in here, minimize this a little
bit, and I will do lkapp env.
What this is going to do is we just
enter in all of the different
environment variables that I have in
thev.example
for you. So we specify our openi API
key. We specify our deepgram API key and
then the large language model that we
want to use for that part of our voice
pipeline. And then just a couple of
development settings. And so the live
kit command will actually recognize the
values we have in thev.ample and it'll
set all of those with us. And then these
three at the top for our live kit
authentication. It actually does that
automatically under the hood because we
already did our authentication.
And so I'm going to set these values off
camerara. Like you can see I just like
set this and then I set my deep API key.
I'll set all of these off camera and
I'll come back once that is done. All
right, all my environment variables are
entered. We are good to go. This will
create av.local
file. Just make sure that you rename it
to env. And then moving on, the next
thing that we can do is start our agent.
So we have to run the start command
first before we can run the deploy
command because this sets up some
configuration under the hood. So, I'm
going to go ahead and copy this command.
Go back into my terminal here and
execute it. There we go. And so, once we
run this start and it loads everything,
then we can immediately exit out here.
So, just control or command C to exit
out in the terminal. And then we can go
to create our agent. So, last time back
into our terminal here, I deleted my
previous agent because on the free tier
I can only have one. So, I'll do lk
agent create. There we go. So, it'll
have us use the org that we
authenticated with. We can select our
ENV file for our secrets. And we will
select the agent that we want to deploy,
which I'm going to do the basic agent in
this case with just all the mock tool
calls because we can't use the MCP
server remotely. And there we go. Now,
it's going to go ahead and create the
Docker file and deploy everything to the
LiveKit cloud and will be immediately
usable for us. So, I'll pause and come
back again once we have that ready to
go. All right, our agent is now deployed
and we can also see it within our cloud
dashboard as well. And now going into
our playground, which I'll link to this
in the description as well. We can
immediately test talking to our LiveKit
agent in the browser. So we just have to
select our organization and it
automatically connects us to the agent
that we just deployed through the CLI.
Take a look at this.
I can assist you with Airbnb related
request.
Go ahead and find me the top Airbnb in
San Francisco.
The top Airbnbs in San Francisco are one
cozy downtown loft.
Stop it here. We obviously got the same
answer that we did running things
locally. So we now have our agent pretty
much in a production environment and you
can even go so far as to take advantage
of their telephone integrations. You can
have a phone number for your agent and
that really is the end goal for most
voice agents. Not going to cover it
here, but let me know if you'd want me
to do a separate video covering this
integration for LiveKit. Really taking
it further. There's a lot of other
things that I could cover as well, like
multi- aent workflows within LiveKit,
advanced tool integrations, so many more
ideas that I have. So, let me know in
the comments what you'd want me to cover
for LiveKit next. I definitely want to
do more content for LiveKit because I'm
just blown away everything we're able to
build so easily and customize things
because it is all Python code. So, if
you appreciate this video and you're
looking forward to more things on voice
agents and AI agents in general, I would
really appreciate a like and a
subscribe. And with that, I will see you
in the next
