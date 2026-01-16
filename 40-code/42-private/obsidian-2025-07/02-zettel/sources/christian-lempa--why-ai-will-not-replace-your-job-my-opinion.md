---
global-template: source
source-title: Why AI will NOT replace your job! (… my opinion)
source-url: https://www.youtube.com/watch?v=7nOKa8OSu98
source-platform: youtube
source-type: video
source-creators:
  - "[[Christian Lempa]]"
source-published-date: 2025-10-04
source-fetched-date: 2025-10-05
source-length-minutes: 21.3
source-status: drafted
aliases:
  - Why AI will NOT replace your job! (… my opinion)
test-score: 1
---

# AI notes

## TLDR
- AI will not fully replace human jobs in IT, but agentic AI coding and "vibe coding" will transform software development, requiring developers to adapt by learning to work with AI tools and focusing on higher-level tasks like troubleshooting, planning, and auditing.

## Key ideas
- **Agentic AI vs. Simple Chat Integrations**: Agentic AI can autonomously run tasks, react to outputs, and use external APIs/tools (like running commands or changing files), making it behave more like a human engineer compared to simple chat prompts.
- **AI as a Tool, Not a Replacement**: While AI can rapidly generate functional applications (e.g., a web app in 10-12 minutes), it still requires human oversight for troubleshooting, defining features, selecting technology stacks, and auditing code quality.
- **"Vibe Coding"**: This method, driven by AI tools, allows non-technical people to create functional applications with limited understanding of the underlying code, enabling broader participation but raising concerns about code quality, security, and ethical issues.
- **Challenges of AI-Generated Code**: AI-produced code can introduce issues like unknown security vulnerabilities, dependency on AI tools, limited customization, and ethical/legal concerns regarding code origin, necessitating human review and "vibe coding cleanup specialists."
- **Adaptation is Key**: Instead of fearing job replacement, developers should embrace and learn to work with AI tools, focusing on roles that involve coordinating, troubleshooting, planning, and auditing, as new job roles will emerge alongside AI advancements.

## Detailed Summary
The video discusses the impact of agentic AI coding on the IT industry, arguing that AI will not fully replace human jobs but will significantly change the nature of software development. The speaker introduces agentic AI as a more advanced form of AI that can autonomously execute tasks, interact with external tools and APIs, and modify files, contrasting it with simpler chat-based AI. He demonstrates this by using Warp, an agentic AI coding tool, to rapidly generate a modern, user-friendly web application for IT learning, complete with user authentication and course management, in about 10-12 minutes.

The video highlights the efficiency of AI in scaffolding projects and handling repetitive coding tasks. However, it also points out that AI-generated applications often require human intervention for troubleshooting, fixing errors (like downgrading Tailwind CSS versions), and refining functionalities (e.g., implementing registration pages or dashboards). The concept of "vibe coding" is introduced, where individuals with limited programming knowledge can create functional applications using AI tools. While this democratizes development, it also raises significant concerns about code quality, robustness, security risks (due to unknown dependencies or AI-chosen versions), limited customization, and ethical/legal concerns regarding code provenance.

The speaker emphasizes that human engineers will remain crucial for tasks that AI struggles with, such as creative thinking, defining complex requirements, strategic planning, coordinating projects, and critically auditing AI-generated code. He suggests that new job roles, like "vibe coding cleanup specialists," are already emerging to address the challenges of AI-produced code. Ultimately, the video advises developers not to resist AI but to learn and adapt to these new technologies, focusing on higher-level problem-solving and oversight to stay relevant in an evolving industry.

### Key quotes
- "AI agents can run tasks autonomously. So that means they can even react to outputs and inputs by using external APIs or tools that allow the LLM to do things like running commands or changing files." @ 00:01:50
- "I've done all of this entirely with AI without actually writing just a single line of code by myself." @ 00:14:40
- "This is called VIPE coding. And this is a method of coding primarily driven through AI tools where developers often like non-technical people like me if I don't know this programming language can create applications with even limited understanding of the underlying code or the structure." @ 00:15:20
- "This is like programming or working with a black box. This obviously has many challenges when it comes to code quality and robustness, security risks." @ 00:16:30
- "You cannot solely delegate every task to an AI model... You need to somehow control and define what type of features and capabilities you want to have in this application." @ 00:19:00
- "Don't try to argue against AI, don't try to argue against this technology and this evolution, it's going to happen, it's going to take things over... You should start learning this. You should start familiarize yourself with these technologies." @ 00:20:00

## Source notes

### Source Metadata

**Video URL:** <https://www.youtube.com/watch?v=7nOKa8OSu98>
**Video ID:** 7nOKa8OSu98
**Channel:** Christian Lempa (<https://www.youtube.com/channel/UCZNhwA1B5YqiY1nLzmM0ZRg>)
**Upload Date:** 2025-10-04
**Duration:** 00:21:18
**Views:** 3276
**Likes:** 119

### Source Description

In this video, I explain why AI won't replace your job, demonstrate agentic AI coding and 'vibe coding' with tools like Warp and GitHub Copilot, and show practical examples and notes on building an AI-driven web app.

References:
- Warp Tutorial: https://www.youtube.com/watch?v=d6QZ1v_J4lI

________________

💜 Support me and become a Fan!
   → https://christianlempa.de/patreon
   → https://www.youtube.com/channel/UCZNhwA1B5YqiY1nLzmM0ZRg/join

💬 Join our Community!
   → https://christianlempa.de/discord

👉 Follow me everywhere
   → https://christianlempa.de

________________

Read my Tech Documentation
https://christianlempa.de/docs

My Gear and Equipment
https://christianlempa.de/kit

________________
Links can include affiliate links.

### Raw source

Hey guys, it's Christian and today I'd
like to talk with you about agentic AI
coding which I think is an absolutely
fascinating topic that I just want to
talk more about on this channel here
even though I know it is kind of a
controversial one these days and it
seems like people are either in the AI
fanboy camp. Yeah. Where creators and
communities are talking every single day
about this new LLM introduced by a big
brand company. or you're in the AI hater
camp where you just don't want to have
to do anything with this crap and you
just dislike every single AI video on
YouTube. So yeah, it's kind of a hit or
miss with this one. I know this, but I
just believe that no matter which side
you're on, AI is becoming a super
important technology in IT that we just
cannot ignore. And I know that many many
people are currently concerned about AI
because they are afraid of getting
replaced by it. So, I thought I'm just
going to share my honest and humble
opinion on this because I think no, you
should not be worried about getting
replaced by AI and let me explain and
show you why at the same time this is
absolutely mind-blowing and impressive
but also has a lot of issues and even
introduces new problems that we weren't
facing before in it.
Okay guys, so first of all, I want to
set the scene here and get everybody on
the same page because honestly AI wasn't
a major topic on this channel before. I
only did three different videos about
AI. Still, I think that everybody should
learn about Agentic AI because this is
not just a buzz word. Yeah, it's
technically very different from the
simple chat integrations where you just
send a prompt and the AI directly
responds to your inputs based on the
data that it was trained on. AI agents
can run tasks autonomously. So that
means they can even react to outputs and
inputs by using external APIs or tools
that allow the LLM to do things like
running commands or changing files. It
can even do other complex things and
file operations across your device or
repositories which at the end of the day
just makes the AI agent more behave like
a real human or real engineer because it
has access to additional context or
external tools to be much more powerful
than just providing simple text outputs.
And I thought I'm just going to work
with you on a simple example project. So
here I've prepared a prompt where the
objective is to create a modern and
userfriendly web application focused on
IT learning. So an IT course website
something that I could potentially use
for my YouTube channel as well. This
site should cater a wide audience
including beginners and advanced users
offering resources like tutorials,
articles, courses, and interactive
content. The key features should be that
it's responsive. So it natively works
great on mobile devices as well as
desktop devices. It should have a user
authentication. It should have process
tracking and the technology stack. I
haven't really specified further. You
could also add some specific web
frameworks like React or or Node.js or
things like that. But I think let the AI
figure it out on its own how to write
this application. I just want to make
sure that it uses an SQLite database for
the storage back end. So I just want to
keep it super simple. By the way, of
course, you can also explain AI to use a
different database like MongoDB or
Postgress or you can even use a gentic
AI coding to change that afterwards. But
with a simple prompt like this, yeah, we
can just execute it. By the way, I'm
using the claw for set model. We could
also try it out by using GPT5. That
would give me some slightly different
result, of course, because every LLM has
its own very specific techniques or can
behave a bit different in other
scenarios. But I think for most of the
cases I just found out that claude for
sonnet also Gemini 2.5 pro or GPD5 with
medium high or low reasoning these
models are really capable of riding
these type of applications completely on
their own. So let's just hit enter and
see what's happening. And now instead of
a simple chat prompt here because Warp
is a true agentic AI uh coding tool, it
will start making a plan. So first of
all, it will create a task list with all
the important things that it needs to
do. So initialize a project structure uh
create a package JSON there. So that's
probably important for the Node.js
configuration stuff like that. It even
creates a new directory here and then
wants to do all these things here. So I
could just go on and just run each of
these steps here individually. So I
confirm it or what I personally u like
to do more often I click on run and then
I activate the auto approvement
here. So that means that all the other
tasks the AI agent will autonomously
just execute without any confirmation
from my side. So here you can see it
creates this package.json. Obviously,
I'm not a JavaScript expert, so I know a
few things. Uh, but honestly, I couldn't
write any uh application or any code of
this uh quality myself without I don't
know tinkering weeks and months of doing
this. Yeah. So, Python might be a
different game. So, there I'm a little
more knowledgeable. But anyways,
JavaScript is not really my uh
profession. So, that's why it's probably
better to use these type of tools. All
right. So here we can also see the
readme file. For the back end um the AI
agent will use Node.js the SQLite
database as I have described it in the
prompt. For the front end it will use
React the Tailwind CSS. This is by the
way a nice framework. Uh I think that's
pretty good. The React router Axios for
AI communication. I have no idea what
that is but hey let's see what it comes
up with. So here is the structure of the
directories with the backend server, the
controller, the middleware, models,
routers, database, the client
application, API endpoints that it
needs. Yeah, based on my prompt, I
wanted to have a user authentication. So
it creates a route for off register to
register a new user, log in, log out,
get profile information. And then like I
described, I want um some IT courses
learning platform. It created some
endpoints for getting all the courses,
getting specific causes. So, everything
that I have described. So, um let's
scroll up because it's already starting
to do something. So, it created an SQLI
database initialization script that will
initialize the database structure with
all the fields, everything that it needs
to make this application functional.
Some error handling, which yeah, might
also be useful in some cases. So, you
can just wait until this is done.
probably it takes a few minutes until
it's uh finished. So I'm really excited
to see what it comes up with. Uh by the
way, while it's doing this thing here, I
can just open a new tab here and open it
in VS Code. So then we can in parallel
look at the files a bit better. And we
can also use the GitHub copilot to
continue working on this. Of course, you
can use both uh tools in parallel for
some tasks. I found out that the GitHub
copilot or VS Code is sometimes a bit
better. you can much better read and
search the files for anything. You can
uh specifically select some sections and
and add this as context to the GitHub
copilot. So for example, if you just
want to change this part of the file,
you can just use the hashtag symbol to
say selection. That is sometimes a bit
yeah simpler and more straightforward
when you're working on larger projects
and larger files than doing everything
in warp. However, I think warp is much
better for running through tasks
autonomously and it's also much much
better for anything that needs to be
executed in your terminal. So for
troubleshooting issues with your
application if you're running into some
error locks. It is much easier to
execute these type of tasks in warp at
the lock output as context for your next
prompt and just tell the AI model to fix
these issues. Warp is much more capable
of doing these things than GitHub
Copilot, at least in my opinion. So
these are two really great tools, but
again, as it is with all things in it,
there is always the best tool for a
specific job. Though that's at least my
experience.
All right, so it seems that it's almost
complete. Now comes the interesting part
here where it starts testing the
application. So it runs the development
server and the development client
application and as you can see here
there is some internal errors. So here
you can see this issue. This is kind of
something that went wrong during the
processing. But now after some trial and
error it finally works. So this is the
web application that warp has completely
created for us. And I think that just
took like 10 or maybe 12 minutes to run
through this and troubleshoot some of
the initial errors. So one big problem
was that it previously tried to use
Tailwind CSS 4.x that had a few
problems. So it automatically downgraded
it to Tailwind CSS 3.x that seems to be
much more stable and has better
compatibility. So yeah, whatever. We
just trust AI. So that's the best
decision. And yeah, now it finally
works. We got our application. So let's
first of all test this. This is the very
first time I open this. So um let's just
click on start learning. So we need to
register registration form coming soon.
So it seems like we don't have a
registration form. That's the first
problem we need to fix. And also when we
click on browse courses, there's nothing
in here. So we don't have any courses.
But I think at least the foundation for
this application is working with a
responsive design. Does that work? Oh
yeah. So responsive design is definitely
working great. And now we can continue
working on this project. So we either
could use warp or we could use GitHub
copilot. Let's try GitHub copilot and
see how that's working. You can see I'm
using the same cloth sonnet model. I
could also switch to something else, but
let's just keep cloud for now. And let's
say uh can you implement the
registration page so I can register new
users to my application and let's hit
enter. So just like warp uh this tool
again it works a bit differently but it
usually does the same agentic AI coding
logic. So it first of all tries to
gather context from this project because
we didn't work with this uh chat here
before. So this application is
completely new to this chat window here.
So it first of all needs to gather all
the files so it understands how this
application is working. Therefore, it is
always good that you from time to time
let the AI update the readme file,
especially when you made some changes.
Sometimes it forgets to update the
readme file and then another chat window
doesn't really know what were the
changes before. So, always make sure
that you document as much as you can so
the AI model has enough context to
provide accurate responses and makes the
correct decisions when it's altering
files or changing code logics and stuff
like that. Here it says it at least has
a good understanding of the structure.
So that sounds promising. Let's see and
let's hope for the best. So one thing
where warp is much better is to execute
commands. You so you can see that GitHub
copilot is also capable of executing
commands to run the development server
and stuff like that, but it doesn't have
the same auto approval thing and it
doesn't troubleshoot issues on the
terminal so well. So it's more for
working with an IDE. All right. So
here's our registration form. Let me
just fill in something. I don't really
know if there are any other required
fields. So ah we can uh add our
programming skill level. So I might want
to change this because uh this IT course
website is not solely about programming.
So maybe we don't need this and we could
remove it. But you can see anything else
looks pretty sophisticated and so as you
would expect it from a professional
application. So let's uh try. Okay. So
dashboard is coming soon. So that's the
next thing we need to implement here.
obviously. So, uh yeah, let's give it a
go and say imp implement dashboard as
well. And while this is working, by the
way, you can start more AI agents if you
want. So, in case of warp for example,
let's just open a new tab and let's uh
implement something else because as you
can see, there is no dark mode uh
switcher and of course we need dark
mode. So the warp AI work on something
else while um the GitHub copilot is is
still working on the dashboard. So add a
dark mode switcher to this application.
All right. And let's also set it to auto
approve so it can run in the background
and it can start working on this task
while we are checking something else. So
here you can see there's our dashboard.
By the way, when you're working with
multiple AI agents on the same project
in Warp, you can see all the tasks from
these agents here. So here, for example,
uh while this is still working on the
dark mode switcher, I created a new AI
agent that will start implementing the
course in the lessons page. So that we
get up to speed a little because this is
taking too long for me. All right, guys.
So now everything is completed,
everything works. I fixed all the issues
and implemented everything. Let's take a
look at the web application. So, first
of all, be before my eyes are getting
damaged, let's enable the new dark mode
switcher. So, that's much better. Now,
as you can see, uh I completely
implemented a profile section, the
dashboard, and we can now browse the
courses. As you can see here, I've also
added some example courses. Yeah. Um
also the sorting functionality works.
That is really amazing. For example,
let's take a look at one of the courses
here, Docker for beginners. That
actually could be a great course uh on
YouTube as well maybe. So let's enroll.
It's free. Okay. And yeah, so let's
start learning. It already provisioned
the demo courses with actually some
useful content in here. So your first
docker command. So that's great mark as
complete. And now I could add more pages
to this. Of course, this I haven't
implemented yet, but I could if I
technically wanted to do this. And it
took me about 15 minutes to roughly an
hour to get through all of this because
I needed to fix a bunch of issues and go
through many different iterations to get
everything working. However, I've done
all of this entirely with AI without
actually writing just a single line of
code by myself. And this is really
impressive and I can definitely see why
some people are worried about getting
replaced by AI. However, if we just take
a look behind the curtain, we can still
see so many different issuers created by
this. By the way, this what we've just
done together has a specific term. This
is called VIPE coding. And this is a
method of coding primarily driven
through AI tools where developers often
like non-technical people like me if I
don't know this programming language can
create applications with even limited
understanding of the underlying code or
the structure. So yeah with white coding
many many people can create applications
fully functional applications really
without actually understanding what they
are doing. At the one side, this is
really great because I think it enables
a wider audience of nontechnical people
to bring their ideas to life even
without understanding programming and
using AI tools. However, it also should
hopefully raise many alarm bells. This
is like programming or working with a
black box. This obviously has many
challenges when it comes to code quality
and robustness, security risks. Yeah, we
probably even don't know if there are
any security risks within our
application because we're not familiar
with all the packages and dependencies.
Are there any security vulnerabilities
in these versions? Where did these
version numbers come from? Maybe AI just
came up with these versions because it
was used in some of their old legacy
training data. We actually don't know.
And this is becoming a huge problem not
just for this application that's running
right now but because AI assisted tools
will create and produce much more source
code without actually someone experience
taking a look at this code and
preventing any bad things from
happening. But it's also introducing
many many challenges to people or even
organizations that implement these vibe
coding techniques to their day-to-day
work because they become a lot more
dependent on these AI tools and when
something does not work somewhere inside
who actually knows where to look for and
what to look for. So you solely are
dependent on these tools and that of
course is introducing many problems with
limited customizations also ethical and
legal concerns because you don't really
know uh where this code is coming from
and if you have the rights if it was
copied from some training data from a
closed source repository or if it came
from an open source repository you can
never really be sure. So again, while
I'm still a big fan of VIP coding.
Honestly, I use this technique a lot to
create some scripts and tools. I I
really love this. I'm not fully against
it, but I'm definitely aware of the big
challenges and the big problems coming
with it. So I think we can learn a lot
or predict a few things based on these
observations here that we just did. And
my assumption is that of course these
techniques are going to be used in the
industry and AI assisted tools even vibe
coding is becoming more and more popular
and people are just going to build
applications with it if you like it or
not. Yeah, things are going to happen
and of course that might have some
implications on people's jobs and
beginner jobs that we probably will see
reduce in numbers. Yeah, be because why
would you hire a junior developer that
uh creates a simple application when you
can use AI to do that in a few minutes?
But at the end of the day, you cannot
solely delegate every task to an AI
model. As you can see here, we did a lot
of manual fixing, a lot of bugs that we
needed to troubleshoot. And of course,
we needed to somehow tell the AI model
what it actually should build. An AI
cannot think creatively and just come up
with uh how to create such a learning
platform. You need to somehow control
and define what type of features and
capabilities you want to have in this
application. You probably also need
somewhat more experience to tell what is
the right technology stack to build an
application on. You of course you can uh
just let the AI do this for you, but
then it's becoming more a gamble than a
sophisticated decision. So the AI
revolution is coming if you want it or
not. Yeah. Companies will adapt to this.
Yeah. But I think they can't do
everything through these automated
tools. They still need some human
engineers working on these uh things,
coordinating stuff, getting the chaos
under controls, troubleshooting issues.
It still requires manual planning and uh
some auditing and review of this code.
it probably even becomes more
challenging because there's a lot more
code that is currently produced by AI
tools. So you need more people to review
more code. Actually, by the way, there's
even a new job raising these days that's
called the VIP coding cleanup
specialists. So companies and
freelancers are already making a
business of reviewing and auditing this
shitty code and getting this to a more
stable and solid product. So you can see
even if there are a few jobs going away
or replaced by AI there are new
challenges and new jobs are going to be
created. So what I want to say with this
even if agentic AI coding becomes kind
of the standard how we develop software
in IT I would not say that you should be
afraid of losing your job I will just
say this yeah don't try to argue against
AI don't try to argue against this
technology and this evolution it's going
to happen it's going to take things
over. People are going to do vibe coding
if you like it or not. So you should not
ignore this. You should start learning
this. You should start familiarize
yourself with these technologies. Learn
how to work with these tools. Maybe
build some example projects yourself. I
think now is the best time to play
around with this. And I think that's
ultimately the best strategy to stay in
the game. But just like I said in the
beginning, it's really just my humble
and honest opinion. Yeah, maybe you have
a completely different view on this. So
I would like to open the discussion and
please let me know in the comments what
do you think about agentic AI coding.
What do you think about all these
technologies and what's your opinion on
this? But I hope I inspired you to try
out a few things and experiment with it.
So I'll let you go and of course I'm
going to catch you in the next video. So
stay tuned for more tutorials. And a big
thanks goes out to all my supporters and
members. You guys are really amazing.
Thanks everybody for watching. I'm going
to catch you in the next one. Take care.
Bye-bye.
