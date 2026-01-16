---
id: f438ce45-c29e-4216-a4d2-e303460e8409
---

# Stratechery by Ben Thompson – On the business, strategy, and impact of technology.
Tags: #Omnivore

[Read on Omnivore](https://omnivore.app/me/stratechery-by-ben-thompson-on-the-business-strategy-and-impact--19008d8c02a)
[Read Original](https://stratechery.com)


## Content
## **Subscriber’s Daily Update**

Apple’s annual Worldwide Developer Conference keynote kicks off in a few hours, and [Mark Gurman has extensive details of what will be announced in Bloomberg](https://www.bloomberg.com/news/articles/2024-06-07/apple-wwdc-2024-what-to-expect-ai-ipados-18-macos-15-siri-updates-more), including the name: “Apple Intelligence”. As John Gruber noted on [Daring Fireball](https://daringfireball.net/2024/06/gurman%5Fwwdc%5Fleak%5Fdump):

> His report reads as though he’s gotten the notes from someone who’s already watched Monday’s keynote. I sort of think that’s what happened, given how much of this no one had reported before today. Bloomberg’s headline even boldly asserts “Here’s Everything Apple Plans to Show at Its AI-Focused WWDC Event”. I’m only aware of one feature for one platform that isn’t in his report, but it’s not a jaw-dropper, so I wouldn’t be surprised if it was simply beneath his threshold for newsworthiness. Look, I’m in the Apple media racket, so I know my inside-baseball obsessions are unusual, but despite all the intriguing nuggets Gurman drops in this piece, the thing I’m most insatiably curious about is how he got all this. Who spilled? By what means? It’s extraordinary. And don’t think for a second it’s a deliberate leak. Folks inside Apple are, I assure you, furious about this, and incredulous that one of their own colleagues would leak it to Gurman.

The irony of the leak being so huge is that nothing is particularly surprising: Apple is announcing and incorporating generative AI features throughout its operating systems and making them available to developers. _Finally_, the commentariat exclaims! Apple is in danger of falling dangerously behind! The fact they are partnering with OpenAI is evidence of how desperate they are! In fact, I would argue the opposite: Apple is not too late, they are taking the correct approach up and down the stack, and are well-positioned to be one of AI’s big winners.

### Apple’s Business Model

Start with the most basic analysis of Apple’s business: despite all of the (legitimate) talk about Services revenue, Apple remains a hardware company at its core. From its inception the company has sold personal computers: the primary evolution has been that the devices have become ever more personal, from desktops to laptops to phones, even as the market as a whole has shifted from being enterprise-centric to consumer-centric, which [plays to Apple’s strengths in design and the user experience benefits that come from integration](https://stratechery.com/2013/clayton-christensen-got-wrong/).

Here’s the thing about an AI-mediated future: we will need devices! Take the classic example of the Spike Jonze movie “Her”:

[![A scene from "Her" showing the protagonist wearing an earpiece to access AI](https://proxy-prod.omnivore-image-cache.app/640x360,sCxyo1EanlqFW1FuPzTQ50XKvvj4JrW0aHxEHWsM93Bs/https://i0.wp.com/stratechery.com/wp-content/uploads/2024/06/apple-intelligence-1.png?resize=640%2C360&ssl=1)](https://www.warnerbros.com/movies/her)

Jonze’s depiction of hardware is completely unrealistic: there is not a single battery charger in the entire movie (the protagonist removes the device to sleep, and simply places it on his bedside table), or any consideration given to connectivity and the constraints that might put on the size and capability of the device in the protagonist’s ear; and yet, even then, _there is a device in the protagonist’s ear_, and, when the protagonist wants the AI to be able to see the outside world, he puts an iPhone-esque camera device in his pocket:

[![A scene from "Her" showing the protagonist with a smartphone-like camera in his pocket](https://proxy-prod.omnivore-image-cache.app/640x360,sH1H5-xHnLaVOkkeh_3JmWPR3FO6oZ_Up-ceqSTrUFog/https://i0.wp.com/stratechery.com/wp-content/uploads/2024/06/apple-intelligence-2.png?resize=640%2C360&ssl=1)](https://www.warnerbros.com/movies/her)

Now a Hollywood movie from 2013 is hardly dispositive about the future, but the laws of physics are; in this case the suspension of disbelief necessary to imagine a future of smarter-than-human AIs must grant that we need some sort of device for a long time to come, and as long as that is the case there is an obvious opportunity for the preeminent device maker of all time. Moreover, to the extent there is progress to be made in miniaturization, power management, and connectivity, it seems reasonable to assume that Apple will be on the forefront of bringing those advancements to market, and [will be courageous enough to do so](https://stratechery.com/2016/beyond-the-iphone/).

In other words, any analysis of Apple’s prospects in an AI world should start with the assumption that AI is a complement to Apple’s business, not disruptive. That doesn’t mean that Apple is guaranteed to succeed, of course: AI is the only foreseeable technological advancement that could provide sufficient differentiation to actually drive switching, but even there, the number of potential competitors is limited — there may only be one (more on this in a moment).

In the meantime, AI makes high-performance hardware more relevant, not less; Gurman notes that “Apple Intelligence” will only be available on Apple’s latest devices:

> The new capabilities will be opt-in, meaning Apple won’t make users adopt them if they don’t want to. The company will also position them as a beta version. The processing requirements of AI will mean that users need an iPhone 15 Pro or one of the models coming out this year. If they’re using iPads or Macs, they’ll need models with an M1 chip at least.

I’m actually surprised at the M1 baseline (I thought it would be M2), but the iPhone 15 Pro limitation is probably the more meaningful one from a financial perspective, and speaks to the importance of RAM (the iPhone 15 Pro was the first iPhone to ship with 8GB of RAM, which is also the baseline for the M1). In short, this isn’t a case of Apple driving arbitrary differentiation; you really do need better hardware to run AI, which means there is the possibility of a meaningful upgrade cycle for the iPhone in particular (and higher ARPUs as well — might Apple actually start advertising RAM differences in iPhone models, since more RAM will always be better?).

### The App Store and AI

One of the ironies of that phone-like device in Her being a camera is that such a device will probably not be how an AI “sees”; Humane has already shipped a camera-based device that simply clips on to your clothing, but the most compelling device to date is Meta’s Ray-Ban smart glasses:

[![Meta's Ray-Ban smartglasses](https://proxy-prod.omnivore-image-cache.app/640x391,smcJtuJiI3oU6HuyqjwW0TMy9Uj1xCGadsdSnS0VHzJc/https://i0.wp.com/stratechery.com/wp-content/uploads/2024/06/apple-intelligence-3.png?resize=640%2C391&ssl=1)](https://www.meta.com/smart-glasses/)

Meta certainly has designs on AR glasses replacing your phone; shortly after acquiring Oculus, CEO Mark Zuckerberg predicted that devices mounted on your head would replace smartphones for most interactions in 10 years time. That prediction, though, was [nine years ago](https://www.csmonitor.com/Technology/2015/0701/AR-goggles-will-replace-phones-says-Facebook-CEO-Zuckerberg); no one today, including Meta, predicts that smartphones will not be the most essential computing device in 2025, even though the Ray-Ban glasses are interesting.

The fact of the matter is that smartphones are nearly perfect devices [for the jobs we ask them to do](https://stratechery.com/2013/apps-people-jobs-to-be-done/): they are small enough to be portable, and yet large enough to have a screen to interact with, sufficient battery life to make it through the day, and good enough connectivity; the smartphone, alongside cloud computing, represents [the end of the beginning](https://stratechery.com/2020/the-end-of-the-beginning/), i.e. the platform on which the future happens, as opposed to a transitory phase to a new class of disruptive devices.

In this view the app ecosystem isn’t so much a matter of lock-in as it is a natural state of affairs: of course the app interfaces to the physical world, from smart homes to transportation to media consumption, are located on the device that is with people everywhere. And, by extension, of course those devices are controlled by an oligopoly: the network effects of platforms are unrivaled; indeed, the real surprise of mobile — at least if you asked anyone in 2013, when Stratechery started — is that there are _two_ platforms, instead of just one.

That, by extension, is why the Ray-Ban glasses [come with an app](https://apps.apple.com/us/app/meta-view/id1558240027), and thus have a chance of succeeding; one of Humane’s fatal flaws was their insistence that [they could stand alone](https://stratechery.com/2024/mkbhds-for-everything/). Moreover, the longer that the smartphone is a prerequisite for new experiences, the more likely it is to endure; there is an analogy here to the continued relevance of music labels, which depend on the importance of back catalogs, which just so happen to expand with every release of new music. Every new experience that is built with the assumption of a smartphone extends the smartphone’s relevance that much further into the future.

There is, to be fair, a scenario where AI makes all applications obsolete with one fell swoop, but for now AI fits in the smartphone-enhancing pattern. First, to the extent that AI can be done locally, it will depend on the performance and battery life of something that is smartphone-sized at a minimum. Second, to the extent that AI is done in the cloud, it will depend on the connectivity and again battery life of something that is smartphone-sized as well. The latter, meanwhile, will come with usage costs, which is a potential tailwind for Apple’s (and Google’s) App Stores: those usage costs will be paid via credits or subscriptions which both platforms will mandate go through their in-app purchase systems, of which they will take a cut.

The third alternative is that most AI utilization happens via platform-provided APIs, which is exactly what Apple is expected to announce later today. From Gurman’s report:

> Siri will be a part of the new AI push as well, with Apple planning a revamp to its voice-control service based on large language models — a core technology behind generative AI. For the first time, Siri users will be able to have precise control over individual features and actions within apps. For instance, people will be able to tell Siri to delete an email, edit a photo or summarize a news article. Over time, Apple will expand this to third-party apps and allow users to string multiple commands together into a single request. These features are unlikely to arrive until next year, however.

Platform-provided AI capabilities will not only be the easiest way for developers to incorporate these features, they will also likely be the best way, at least in terms of the overall user experience. Users will understand how to use them, because they will be “trained” by Apple’s own apps; they will likely be cheaper and more efficient, because they are leveraging Apple’s overall investment in capabilities; most importantly, at least in terms of Apple’s competitive position, they will further lock-in the underlying platform, increasing the hurdle for any alternative.

### AI Infrastructure

There are two infrastructure concerns when it comes to the current state of AI. The first, and easiest to manage for Apple (at least in the short term), are so-called chatbots. On one hand, Apple is massively “behind” in terms of both building a ChatGPT-level chatbot, and also in terms of building out the necessary infrastructure to support that level of capability for its massive userbase. The reason I put “behind” in scare-quotes, though, is that Apple can easily solve its shortcoming in this area by partnering with a chatbot that already exists, which is exactly what they are doing. Again from Gurman:

> The company’s new AI system will be called Apple Intelligence, and it will come to new versions of the iPhone, iPad and Mac operating systems, according to people familiar with the plans. There also will be a [partnership with OpenAI](https://www.bloomberg.com/news/articles/2024-05-11/apple-closes-in-on-deal-with-openai-to-put-chatgpt-on-iphone) that powers a ChatGPT-like chatbot.

The analogy here is to Search, another service that requires astronomical investments in both technology and infrastructure; Apple has never built and will never need to build a competitive search engine, because it owns the devices on which search happens, and thus can charge Google for the privilege of making the best search engine the default on Apple devices. This is the advantage of owning the device layer, and it is such an advantageous position that Apple can derive billions of dollars of profit at essentially zero cost.

A similar type of partnership with OpenAI will probably not be as profitable as search was; my guess is that Apple will be paying OpenAI, instead of the other way around, but the most important takeaway in terms of Apple’s competitive position is that they will, once again, have what is regarded as the best chatbot on their devices without having to make astronomical investments in technology and infrastructure. Moreover, this dampens the threat of OpenAI building their own device that usurps the iPhone: why would you want to buy a device that lacks the iPhone ecosystem when you can get the same level of capability on the iPhone you already have, along with all of the other aspects of the iPhone platform I noted above?

The second infrastructure concern is those API-level AI capabilities that Apple is set to extend to 3rd-party developers. Here the story is a bit fuzzier; from [another Gurman report last month](https://www.bloomberg.com/news/articles/2024-05-09/apple-to-power-ios-18-ai-features-with-in-house-server-mac-chips-this-year):

> Apple Inc. will deliver some of its upcoming artificial intelligence features this year via data centers equipped with its own in-house processors, part of a sweeping effort to infuse its devices with AI capabilities. The company is placing high-end chips — similar to ones it designed for the Mac — in cloud-computing servers designed to process the most advanced AI tasks coming to Apple devices, according to people familiar with the matter. Simpler AI-related features will be processed directly on iPhones, iPads and Macs, said the people, who asked not to be identified because the plan is still under wraps.

I am intrigued to learn more about how these data centers are architected. Apple’s chips are engineered first-and-foremost for smartphones, and extended to Macs; that means they incorporate a CPU, GPU, NPU and memory into a single package. This has obvious benefits in terms of the iPhone, but there are limitations in terms of the Mac; for example, the highest end Mac Pro only has 192 GB of memory, a significant step-down from the company’s Intel Xeon-based Mac Pros, which topped out at 1.5 TB of memory. Similarly, while that top-of-the-line M2 Ultra has a 72-core GPU, it is married to a 24-core CPU; a system designed for AI processing would want far greater GPU capability without paying a “CPU tax” along the way.

In short, I don’t currently understand why Apple would build datacenters around its own chips, instead of using chips better-suited to the tasks being asked of them. Perhaps the company will announce that it has designed a new server chip, or perhaps its chips are being used in conjunction with purpose-built chips from other companies; regardless, building out the infrastructure for API-level AI features is one of the biggest challenges Apple faces, but it is a challenge that is eminently solvable, particularly since Apple controls the interface through which those capabilities will be leveraged — and when. To go back to the first Gurman article referenced above:

> Apple’s AI features will be powered by its own technology and tools from OpenAI. The services will either rely on on-device processing or cloud-based computing, depending on the sophistication of the task at hand. The new operating systems will include an algorithm to determine which approach should be taken for any particular task.

Once again, we see how Apple (along with Google/Android and Microsoft/Windows) is located at the point of maximum leverage in terms of incorporating AI into consumer-facing applications: figuring out what AI applications should be run where and when is going to be a very difficult problem as long as AI performance is not “good enough”, which is likely to be the case for the foreseeable future; that means that the entity that can integrate on-device and cloud processing is going to be the best positioned to provide a platform for future applications, which is to say that the current operating system providers are the best-placed to be the platforms of the future, not just today.

### Competitive Threats

Outlining Apple’s competitive position illustrates what a threat to their business must look like. In the very long run, it is certainly possible that there is an AGI that obsoletes the smartphone entirely, just as [the iPhone obsoleted entire categories of consumer electronics](https://stratechery.com/2013/obsoletive/). Yes, we will still need devices, which works in Apple’s favor, but if those devices do not depend on an app ecosystem then Apple runs the risk of being reduced to a commoditized hardware manufacturer. This, by extension, is the biggest reason to question Apple’s decision to partner with OpenAI for chatbot functionality instead of building out their own capability.

I’m skeptical, though, that this sort of wholesale transition will happen anytime soon, or ever; the reality of technology is that most new epochs layer on top of what came before, as opposed to replacing it wholesale. The Internet, for example, has been largely experienced on top of existing operating systems like Windows or iOS. Again, the most fervent AI believers may argue that I am dismissing AI’s long-term capabilities, but I think that Apple is making a reasonable bet.

It follows, then, that if I am right about the continued importance of the smartphone, that the only entity that can truly threaten Apple is Google, precisely because they have a smartphone platform and attendant ecosystem. The theory here is that Google could develop truly differentiated AI capabilities that make Android highly differentiated from the iPhone, even as Android has all of the apps and capabilities that are the price of entry to a user’s pocket in the first place.

I don’t, for the record, think that this possibility is purely theoretical; I wrote last December about [Google’s True Moonshot](https://stratechery.com/2023/googles-true-moonshot/):

> What, though, if the mission statement were the moonshot all along? What if “I’m Feeling Lucky” were not a whimsical button on a spartan home page, but the default way of interacting with all of the world’s information? What if an AI Assistant were so good, and so natural, that anyone with seamless access to it simply used it all the time, without thought?
> 
> That, needless to say, is probably the only thing that truly scares Apple. Yes, Android has its advantages to iOS, but they aren’t particularly meaningful to most people, and even for those that care — like me — they are not large enough to give up on iOS’s overall superior user experience. The only thing that drives meaningful shifts in platform marketshare are paradigm shifts, and while I doubt the v1 version of Pixie would be good enough to drive switching from iPhone users, there is at least a path to where it does exactly that.

I wrote more about this possibility [two weeks ago](https://stratechery.com/2024/ai-integration-and-modularization/), so I don’t want to belabor the point, but this may be the biggest reason why Apple is partnering with OpenAI, and not Google: Apple might not want to build a dependency on a company might be incentivized to degrade their relative experience (a la Google Maps [a decade ago](https://stratechery.com/2013/the-android-detour/)), and Google might not want to give access to its potential source of long-term differentiation to the company whose business model is the clearest solution to the search company’s threat of disruption.

The disruptive potential of AI for Google is straightforward: yes, Google has massive infrastructure advantages and years of research undergirding its AI efforts, but delivering an answer instead of a set of choices is problematic both [for Google’s business model](https://stratechery.com/2023/ai-and-the-big-five/), which depends on users’ choosing the winner of an auction, and for [its position as an Aggregator](https://stratechery.com/2024/aggregators-ai-risk/), which depends on serving everyone in the world, regardless of their culture and beliefs.

The past few weeks have surfaced a third risk as well: Google has [aggressively pushed AI results into search](https://stratechery.com/2024/google-i-o-googles-strengths-and-weaknesses-ai-search/) in response to the competitive threat from chatbots; OpenAI and Perplexity, though, aren’t upsetting user expectations when they delivery hallucinatory responses, because users already know what they are getting into when they choose to use chatbots to ask questions. Google, though, has a reputation for delivering “correct” results, which means leveraging its search distribution advantage to push AI entails significant risk to that reputation. Indeed, Google has already started to deprioritize AI results in search, moving them further down the page; that, though, at least in my personal experience, has made them significantly less useful and pushed me back towards using chatbots.

A meaningful strategic shift towards a vertical model centered around highly differentiated devices, though, solves a lot of these problems: the devices would make money in their own right (and could be high-priced because they are the best way to access Google’s differentiated AI experiences), could deliver a superior AI experience (not just via the phone, but accessories like integrated glasses, ear buds, etc), and would serve an audience that has self-selected into the experience. I remain dubious that Google will have the gumption to fully go in this direction, but it is the one possibility that should make Apple nervous.

### AI Prudence

It is the other operating system provider, Microsoft, who gives further credence to Apple’s deliberative approach. Windows is not a threat to the iPhone for all of the app ecosystem reasons noted above, but Microsoft clearly sees an opportunity to leverage AI to compete with the Mac. After last month’s CoPilot+ PC event I wrote in [Windows Returns](https://stratechery.com/2024/windows-returns/):

> The end result — assuming that reviewed performance measures up to Microsoft’s claims — is an array of hardware from both Microsoft and its OEM partners that is MacBook Air-esque, but, unlike Apple’s offering, actually meaningfully integrated with AI in a way that not only seems useful today, but also creates the foundation to be dramatically more useful as developers leverage Microsoft’s AI capabilities going forward. I’m not going to switch (yet), but it’s the first time I’ve been tempted; at a minimum the company set a bar for Apple to clear at next month’s WWDC.

One of the new Windows features that Microsoft touted at that event was Recall, which leverages AI to help users access everything they have seen or done on their computer in recent history. The implementation, though, turned out to be quite crude: Windows will regularly take screenshots and use local processing to index everything so that it is easily searchable. The problem is that while Microsoft stridently assured customers (and analysts!) that none of your information would be sent to the cloud, they didn’t take any measures to ensure that said data was secured locally, instead taking a dependency on Windows’ overall security. Over the intervening weeks security researchers [have demonstrated why that wasn’t good enough](https://www.theverge.com/2024/6/3/24170305/microsoft-windows-recall-ai-screenshots-security-privacy-issues), leading to a Microsoft announcement last week of several significant changes; from [The Verge](https://www.theverge.com/2024/6/3/24170305/microsoft-windows-recall-ai-screenshots-security-privacy-issues):

> Microsoft says it’s making its new Recall feature in Windows 11 that screenshots everything you do on your PC an opt-in feature…Microsoft will also require Windows Hello to enable Recall, so you’ll either authenticate with your face, fingerprint, or using a PIN…This authentication will also apply to the data protection around the snapshots that Recall creates.

There are a few interesting implications in these changes:

* First, by making Recall opt-in, Microsoft is losing the opportunity to provide users with a surprise-and-delight moment when their computer finds what they were looking for; Microsoft is going to need to sell the feature to even make that experience possible.
* Second, while requiring OS-level user authentication to access Recall data is almost certainly the right choice, it’s worth pointing out that this removes the potential for 3rd-party developers to build innovative new applications on top of Recall data.

These two factors explain how this screw-up happened: Microsoft wanted to push AI as a differentiator, but the company is still at its core a developer-focused platform provider. What they announced initially solved for both, but the expectations around user data and security are such that the only entity that has sufficient trust to deliver these sorts of intimate experiences is the OS provider itself.

This is good news for Apple in two respects. First, with regards to the title of this Article, the fact it is possible to be too early with AI features, as Microsoft seemed to be in this case, implies that _not_ having AI features does not mean you are too late. Yes, AI features could differentiate an existing platform, but they could also diminish it. Second, Apple’s orientation towards prioritizing users over developers aligns nicely with its brand promise of privacy and security: Apple would prefer to deliver new features in an integrated fashion as a matter of course; making AI not just compelling but societally acceptable may require exactly that, which means that Apple is arriving on the AI scene just in time.

_I wrote a follow-up to this Article in [this Daily Update](https://stratechery.com/2024/wwdc-apple-intelligence-apple-aggregates-ai/)._

Satya Nadella, in last week’s [Stratechery Interview](https://stratechery.com/2024/interviews-with-microsoft-ceo-satya-nadella-and-cto-kevin-scott-about-the-ai-platform-shift/), said in response to a question about Google and AI:

> I look at it and say, look, I think there’s room always for somebody to vertically integrate. I always go back, there’s what is the Gates/Grove model, and then let’s call it the Apple or maybe the new Google model, which is the vertical integration model. I think both of them have plays.

One of the earliest economists to explore the question of integration versus modularization was Ronald Coase in his seminal paper [The Nature of the Firm](https://onlinelibrary.wiley.com/doi/full/10.1111/j.1468-0335.1937.tb00002.x); Coase concluded:

> When we are considering how large a firm will be the principle of marginalism works smoothly. The question always is, will it pay to bring an extra exchange transaction under the organising authority? At the margin, the costs of organising within the firm will be equal either to the costs of organising in another firm or to the costs involved in leaving the transaction to be “organised” by the price mechanism.

It was Professor Clayton Christensen who extended the analysis of integration versus modularization beyond the economists’ domain of measurable costs to the more ineffable realm of innovation. From [The Innovator’s Solution](https://claytonchristensen.com/books/the-innovators-solution/):

> [![The improvement of integrated versus modular systems over time according to Professor Christensen](https://proxy-prod.omnivore-image-cache.app/640x372,srfrspDEyfI6Yjb1_GQfuVmry43wgsfqWaRrvshp99nM/https://i0.wp.com/stratechery.com/wp-content/uploads/2024/05/integration-modularization-ai-1.png?resize=640%2C372&ssl=1)](https://claytonchristensen.com/books/the-innovators-solution/)
> 
> The left side of figure 5-1 indicates that when there is a performance gap — when product functionality and reliability are not yet good enough to address the needs of customers in a given tier of the market — companies must compete by making the best possible products. In the race to do this, firms that build their products around proprietary, interdependent architectures enjoy an important competitive advantage against competitors whose product architectures are modular, because the standardization inherent in modularity takes too many degrees of design freedom away from engineers, and they cannot not optimize performance.
> 
> To close the performance gap with each new product generation, competitive forces compel engineers to fit the pieces of their systems together in ever-more-efficient ways in order to wring the most performance possible out of the technology that is available. When firms must compete by making the best possible products, they cannot simply assemble standardized components, because from an engineering point of view, standardization of interfaces (meaning fewer degrees of design freedom) would force them to hack away from the frontier of what is technologically possible. When the product is not good enough, backing off from the best that can be done means that you’ll fall behind.
> 
> Companies that compete with proprietary, interdependent architectures must be integrated: They must control the design and manufacture of every critical component of the system in order to make any piece of the system. As an illustration, during the early days of the mainframe computer industry, when functionality and reliability were not yet good enough to satisfy the needs of mainstream customers, you could not have existed as an independent contract manufacturer of mainframe computers because the way the machines were designed depended on the art that would be used in manufacturing, and vice versa. There was no clean interface between design and manufacturing. Similarly, you could not have existed as an independent supplier of operating systems, core memory, or logic circuitry to the mainframe industry because these key subsystems had to be interdependently and iteratively designed, too.

I made my own contribution to this literature in 2013’s [What Clayton Christensen Got Wrong](https://stratechery.com/2013/clayton-christensen-got-wrong/). My dispute wasn’t with the above excerpt, but rather the follow-on argument that integrated solutions would eventually overshoot customers and be disrupted by modular alternatives; it was on this basis that Christensen regularly predicted that Apple would lose its lead in smartphones, but I didn’t think that would happen in a consumer market where there were costs to modularization beyond those measured by economists:

> The issue I have with this analysis of vertical integration — and this is exactly what I was taught at business school — is that the only considered costs are financial. But there are other, more difficult to quantify costs. Modularization incurs costs in the design and experience of using products that cannot be overcome, yet cannot be measured. Business buyers — and the analysts who study them — simply ignore them, but consumers don’t. Some consumers inherently know and value quality, look-and-feel, and attention to detail, and are willing to pay a premium that far exceeds the financial costs of being vertically integrated.

This ended up being correct as far as smartphones are concerned, and even computers: yes, Windows-based modular computers dominated the first 30 years of computing, but today the Mac is dominant amongst consumers, something Microsoft implicitly admitted [in their framing of Copilot+ PCs](https://stratechery.com/2024/windows-returns/). Both smartphones and PCs, though, are physical devices you hold in your hands; does the assumption that integration wins in the beginning — and sometimes even the end — hold in AI?

### Integrated Versus Modular AI

The integrated versus modular dichotomy in PCs looked like this:

![Integrated versus modular in PCs](https://proxy-prod.omnivore-image-cache.app/640x428,sGLMZx9VZggTBg5c5SbAvpxaZjDm_MZFTxOLoi4Br8hE/https://i0.wp.com/stratechery.com/wp-content/uploads/2024/05/integration-modularization-ai-2.png?resize=640%2C428&ssl=1)

Apple briefly experimented with modularization in the 1990s, and it nearly bankrupted them; eventually the company went in the opposite direction and integrated all the way down to the processor, following the path set by the iPhone:

![Integrated versus modular in smartphones](https://proxy-prod.omnivore-image-cache.app/640x436,sx6_-YR9QClQUK0rbWlKzZqizMz4srN90vZchF-Z682w/https://i0.wp.com/stratechery.com/wp-content/uploads/2024/05/integration-modularization-ai-3.png?resize=640%2C436&ssl=1)

The similarities between these two images should be striking; Mark Zuckerberg is counting on the same pattern repeating itself for headset computers, with Meta [as the open alternative](https://stratechery.com/2024/meta-and-open/). When it comes to AI, though, Google is, as Nadella noted, the integrated player:

![Google's integrated AI stack](https://proxy-prod.omnivore-image-cache.app/640x401,s2IgtNvIlmoDw9Luf2pJjCbNu4mtO0W2bKfQ_wCR5Atk/https://i0.wp.com/stratechery.com/wp-content/uploads/2024/05/integration-modularization-ai-4.png?resize=640%2C401&ssl=1)

Google trains and runs its Gemini family of models on its own TPU processors, which are only available on Google’s cloud infrastructure. Developers can access Gemini through Vertex AI, Google’s fully-managed AI development platform; and, to the extent Vertex AI is similar to Google’s internal development environment, that is the platform on which Google is building its own consumer-facing AI apps. It’s all Google, from top-to-bottom, and there is evidence that this integration is paying off: Gemini 1.5’s industry leading 2 million token context window almost certainly required joint innovation between Google’s infrastructure team and its model-building team.

On the other extreme is AWS, ~~which doesn’t have any of its own models~~ which, while it has its own Titan family of models, appears to be primarily focused on its Bedrock managed development platform, which lets you use any model. Amazon’s other focus has been on developing its own chips, although ~~the vast majority~~ a good portion of its AI business runs on Nvidia GPUs.

![AWS's modular AI stack](https://proxy-prod.omnivore-image-cache.app/640x407,sWMRs18EPUj3lFvIuaA3KBDaameDhfZwYSm6iLRCHI6g/https://i0.wp.com/stratechery.com/wp-content/uploads/2024/05/integration-modularization-ai-5.png?resize=640%2C407&ssl=1)

Microsoft is in the middle, thanks to its close ties to OpenAI and its models. The company added Azure Models-as-a-Service last year, but its primary focus for both external customers and its own internal apps has been building on top of OpenAI’s GPT family of models; Microsoft has also launched its own chip for inference, but the vast majority of its workloads run on Nvidia.

![Microsoft's somewhat integrated AI stack](https://proxy-prod.omnivore-image-cache.app/640x395,sU8n-VHjXFy1IXaMJBCK5vo6J1eerfI4L-TqD9haHoSs/https://i0.wp.com/stratechery.com/wp-content/uploads/2024/05/integration-modularization-ai-6.png?resize=640%2C395&ssl=1)

Finally there is Meta, which only builds for itself; that means the most important point of integration is between the apps and the model; that’s why Llama 3, for example, was optimized for low inference costs, even at the expense of higher training costs. This also means that Meta can skip the managed service layer completely.

![Meta's mostly integrated AI stack](https://proxy-prod.omnivore-image-cache.app/640x401,sVkzJxMyqtfVI34BvhrCo6O2h_orunhO4GdrQsqV5OfU/https://i0.wp.com/stratechery.com/wp-content/uploads/2024/05/integration-modularization-ai-7.png?resize=640%2C401&ssl=1)

One other company to highlight is Databricks (whose CEO I spoke to [earlier this month](https://stratechery.com/2024/an-interview-with-databricks-ceo-ali-ghodsi-about-building-enterprise-ai/)). Databricks, thanks to [its acquisition of MosaicML](https://stratechery.com/2023/friction-follow-up-databricks-acquires-mosaicml/), helps customers train their own LLMs on their own data, which is, of course, housed on Databricks, which itself sits on top of the hyperscalers:

![Databrick's customized model AI stack](https://proxy-prod.omnivore-image-cache.app/640x403,sKV04sot3uR2Z28y4QttfjlL_A_aealM5macUPhrv1bU/https://i0.wp.com/stratechery.com/wp-content/uploads/2024/05/integration-modularization-ai-8.png?resize=640%2C403&ssl=1)

Databricks is worth highlighting because of the primacy its approach places on data; data and model are the points of integration.

### Big Tech Implications

#### Google

The first takeaway from this analysis is that Google’s strategy truly is unique: they are, as Nadella noted, the Apple of AI. The bigger question is if this matters: as I noted above, integration has proven to be a sustainable differentiation in (1) the consumer market, where the buyer is the user, and thus values the user experience benefits that come from integration, and when (2) those user experience benefits are manifested in devices.

Google is certainly building products for the consumer market, but those products are not devices; they are Internet services. And, as you might have noticed, the historical discussion didn’t really mention the Internet. Both Google and Meta, the two biggest winners of the Internet epoch, built their services on commodity hardware. Granted, those services scaled thanks to the deep infrastructure work undertaken by both companies, but even there Google’s more customized approach has been at least rivaled by Meta’s more open approach. What is notable is that both companies are integrating their models and their apps, as is OpenAI with ChatGPT.

The second question for Google is if they are even good at making products anymore; part of what makes Apple so remarkable is not only that the company is integrated, but also that it maintained its standard for excellence for so long even as it continued to release groundbreaking new products beyond the iPhone, like the Apple Watch and AirPods. It may be the case that selling hardware, which has to be perfect every year to justify a significant outlay of money by consumers, provides a much better incentive structure for maintaining excellence and execution than does being an Aggregator that users access for free.

What this analysis also highlights is the potential for [Google’s True Moonshot](https://stratechery.com/2023/googles-true-moonshot/): actually putting weight behind the company’s Pixel phones as a vertically-integrated iPhone rival. From that Article:

> Google’s collection of moonshots — from Waymo to Google Fiber to Nest to Project Wing to Verily to Project Loon (and the list goes on) — have mostly been science projects that have, for the most part, served to divert profits from Google Search away from shareholders. Waymo is probably the most interesting, but even if it succeeds, it is ultimately a car service rather far afield from Google’s mission statement “to organize the world’s information and make it universally accessible and useful.”
> 
> What, though, if the mission statement were the moonshot all along? What if “I’m Feeling Lucky” were not a whimsical button on a spartan home page, but the default way of interacting with all of the world’s information? What if an AI Assistant were so good, and so natural, that anyone with seamless access to it simply used it all the time, without thought?
> 
> That, needless to say, is probably the only thing that truly scares Apple. Yes, Android has its advantages to iOS, but they aren’t particularly meaningful to most people, and even for those that care — like me — they are not large enough to give up on iOS’s overall superior user experience. The only thing that drives meaningful shifts in platform marketshare are paradigm shifts, and while I doubt the v1 version of Pixie \[Google’s rumored Pixel-only AI assistant\] would be good enough to drive switching from iPhone users, there is at least a path to where it does exactly that.
> 
> Of course Pixel would need to win in the Android space first, and that would mean massively more investment by Google in go-to-market activities in particular, from opening stores to subsidizing carriers to ramping up production capacity. It would not be cheap, which is why it’s no surprise that Google hasn’t truly invested to make Pixel a meaningful player in the smartphone space.
> 
> The potential payoff, though, is astronomical: a world with Pixie everywhere means a world where Google makes real money from selling hardware, in addition to services for enterprises and schools, and cloud services that leverage Google’s infrastructure to provide the same capabilities to businesses. Moreover, it’s a world where Google is truly integrated: the company already makes the chips, in both its phones and its data centers, it makes the models, and it does it all with the largest collection of data in the world.

As [I noted in an Update](https://stratechery.com/2024/google-earnings-googles-re-org-googles-true-moonshot/) last month, Google’s [recent reorg](https://blog.google/inside-google/company-announcements/building-ai-future-april-2024/) points in this direction, although [Google I/O](https://stratechery.com/2024/google-i-o-googles-strengths-and-weaknesses-ai-search/) didn’t provide any hints that this shift in strategy might be coming; instead, the big focus was a new AI-driven search experience, which, needless to say, has seen mixed results. Indeed, the fact that Google is being mocked mercilessly for messed-up AI answers gets at why [consumer-facing AI may be disruptive for the company](https://stratechery.com/2023/ai-and-the-big-five/): the reason why incumbents find it hard to respond to disruptive technologies is because they are, at least at the beginning, not good enough for the incumbent’s core offering. Time will tell if this gives more fuel to a shift in smartphone strategies, or makes the company more reticent.

The enterprise space is a different question: while [I was very impressed with Google’s enterprise pitch](https://stratechery.com/2024/gemini-1-5-and-googles-nature/), which benefits from its integration with Google’s infrastructure without all of the overhead of potentially disrupting the company’s existing products, it’s going to be a heavy lift to overcome data gravity, i.e. the fact that many enterprise customers will simply find it easier to use AI services on the same clouds where they already store their data (Google does, of course, also support non-Gemini models and Nvidia GPUs for enterprise customers). To the extent Google wins in enterprise it may be by capturing the next generation of startups that are AI first and, by definition, data light; a new company has the freedom to base its decision on infrastructure and integration.

#### AWS

Amazon is certainly hoping that argument is correct: the company is operating as if everything in the AI value chain is modular and ultimately a commodity, which implies that it believes that data gravity will matter most. What is difficult to separate is to what extent this is the correct interpretation of the strategic landscape versus a convenient interpretation of the facts that happens to perfectly align with Amazon’s strengths and weaknesses, including infrastructure that is heavily optimized for commodity workloads.

#### Microsoft

Microsoft, meanwhile, is, as I noted above, in the middle, but not entirely by choice. [Last October](https://stratechery.com/2023/google-earnings-microsoft-earnings-ai-leverage/) on [the company’s earnings call](https://seekingalpha.com/article/4643129-microsoft-corporation-msft-q1-2024-earnings-call-transcript) Nadella talked extensively about how the company was optimizing its infrastructure around OpenAI:

> It is true that the approach we have taken is a full stack approach all the way from whether it’s ChatGPT or Bing Chat or all our Copilots, all share the same model. So in some sense, one of the things that we do have is very, very high leverage of the one model that we used, which we trained, and then the one model that we are doing inferencing at scale. And that advantage sort of trickles down all the way to both utilization internally, utilization of third parties, and also over time, you can see the sort of stack optimization all the way to the silicon, because the abstraction layer to which the developers are riding is much higher up than low-level kernels, if you will.
> 
> So, therefore, I think there is a fundamental approach we took, which was a technical approach of saying we’ll have Copilots and Copilot stack all available. That doesn’t mean we don’t have people doing training for open source models or proprietary models. We also have a bunch of open source models. We have a bunch of fine-tuning happening, a bunch of RLHF happening. So there’s all kinds of ways people use it. But the thing is, we have scale leverage of one large model that was trained and one large model that’s being used for inference across all our first-party SaaS apps, as well as our API in our Azure AI service…
> 
> The lesson learned from the cloud side is — we’re not running a conglomerate of different businesses, it’s all one tech stack up and down Microsoft’s portfolio, and that, I think, is going to be very important because that discipline, given what the spend like — it will look like for this AI transition any business that’s not disciplined about their capital spend accruing across all their businesses could run into trouble.

Then, one month later, [OpenAI nearly imploded](https://stratechery.com/2023/openais-misalignment-and-microsofts-gain/) and Microsoft had to face the reality that it is exceptionally risky to pin your strategy on integrating with a partner you don’t control; much of the company’s rhetoric — including the Nadella quote I opened this Article with — and actions since then have been focused on abstracting models away, particularly through the company’s own managed AI development platform, in an approach that looks more similar to Amazon’s. I suspect the company would actually like to lean more into integration, and perhaps still is (including [acqui-hiring its own model and model-building team](https://stratechery.com/2024/microsoft-and-inflection-ai-inflection-oddities-the-acquisition-that-isnt/)), but it has to hedge its bets.

#### Nvidia

All of this is, I think, good news for Nvidia. One [underdiscussed implication of the rise of LLMs](https://stratechery.com/2024/nvidia-waves-and-moats/) is that [Nvidia’s CUDA moat](https://stratechery.com/2021/nvidias-gtc-keynote-the-nvidia-stack-the-omniverse/) has been diminished; the vast majority of development in AI is no longer happening with CUDA libraries, but rather on top of LLMs. That does, in theory, make it more likely that alternative GPU providers, whether that be AMD or hyperscalers’ internal efforts, put a dent in Nvidia’s dominance and margins.

Nvidia, though, is hardly resting on its moat: the company is making its GPUs more flexible over time, promising that its next generation of chips will ship in double the configurations of the current generation, including a renewed emphasis on Ethernet networking. This approach will maximize the Nvidia’s addressable market, driving more revenue which the company is funneling back into a one-year iteration cycle that promises to keep the chip-maker ahead of the alternatives.

I suspect that the only way to overcome this performance advantage, at least in the near term, will be through true vertical integration a la Google; to put it another way, while Google’s TPUs will remain a strong alternative, I am skeptical that hyperscaler internal chip efforts will be a major threat for the foreseeable future. Absent full stack integration those efforts are basically reduced to trying to make better chips than Nvidia, and good luck with that! Even AMD is discovering that [a good portion of its GPU sales are a function of Nvidia scarcity](https://stratechery.com/2024/nvidia-earnings-amd-earnings-nvidias-goldilocks-pitch/).

#### Meta

This also explains Meta’s open source approach to Llama: the company is focused on products, which do benefit from integration, but there are also benefits that come from widespread usage, particularly in terms of optimization and complementary software. Open source accrues those benefits without imposing any incentives that detract from Meta’s product efforts (and don’t forget that Meta is receiving some portion of revenue from hyperscalers serving Llama models).

### AI or AGI

The one company that I have not mentioned so far — at least in the context of AI — is Apple. The iPhone maker, like Amazon, appears to be betting that AI will be a feature or an app; like Amazon, it’s not clear to what extent this is strategic foresight versus motivated reasoning.

It does, though, get at the biggest question of all: LLMs are already incredible, and there is years of work to be done to fully productize the capabilities that exist today; are even better LLMs, though, capable of disrupting not just search but all of computing? To the extent that the answer is yes, the greater advantage I think that Google’s integrated approach will have, for the reasons Christensen laid out: achieving something approaching AGI, whatever that means, will require maximizing every efficiency and optimization, which rewards the integrated approach.

I am skeptical: I think that models will certainly differ, but not in a large enough way to not be treated as commodities; the most value will be derived from building platforms [that treat models like processors](https://stratechery.com/2024/interviews-with-microsoft-ceo-satya-nadella-and-cto-kevin-scott-about-the-ai-platform-shift/), delivering performance improvements to developers who never need to know what is going on under the hood. This will mean the biggest benefits will accrue to horizontal reach — on the API layer, the model layer, and the GPU layer — as opposed to vertical integration; it is up to Google to prove me wrong.

_I wrote a follow-up to this Article in [this Daily Update](https://stratechery.com/2024/computex-2024-aws-and-integration/)._

Full disclosure: I didn’t have any plans to write this Article; I had various [reasons](https://stratechery.com/2024/an-interview-with-ben-thompson-at-the-moffettnathanson-media-internet-and-communications-conference/) to be in the U.S. this week, and Microsoft’s Build developer conference, which kicks off today, happened to fit in my schedule. It wasn’t until a couple of days ago that I even realized there was a Windows and Surface event the day before, so hey, why not attend?

Of course I knew that AI would be the focus; Microsoft made a big deal of adding an AI button to Windows PCs earlier this year, and the company’s Surface event last fall [wasn’t about the Surface at all](https://stratechery.com/2023/microsofts-surface-ai-event-the-new-microsoft-the-old-microsoft/), but rather about Windows Copilot, the company’s omnipresent brand name for its various AI assistants.

Yesterday, though, a whole host of various threads that Microsoft has been working on for years suddenly came together in one of the most compelling events I’ve attended in a long time. Windows, of all things, suddenly feels revitalized, and Microsoft has both made and fostered hardware that feels meaningfully differentiated from other devices on the market. It is, in many respects, the physical manifestation of CEO Satya Nadella’s greatest triumph.

### Copilot+ PCs

I should start by noting that some things never change: Microsoft’s branding veers wildly between a lack of clarity due to too many brands for similar concepts to too many concepts under one brand. In this case both the company and its partners have been talking about “AI PCs” for a while; for example, from the [January announcement](https://blogs.windows.com/windowsexperience/2024/01/04/introducing-a-new-copilot-key-to-kick-off-the-year-of-ai-powered-windows-pcs/) of that aforementioned Copilot key:

> Today, we are excited to take the next significant step forward and introduce a new Copilot key to Windows 11 PCs. In this new year, we will be ushering in a significant shift toward a more personal and intelligent computing future where AI will be seamlessly woven into Windows from the system, to the silicon, to the hardware. This will not only simplify people’s computing experience but also amplify it, making 2024 the year of the AI PC.

I don’t want to begrudge the effort that I’m sure went into introducing a new key onto Windows PCs, but “significant step forward” seems a bit much, particularly given the inherent challenges entailed in a licensing model: in this post-ChatGPT world even my washing machine suddenly has AI, and it seemed inevitable that the crappiest notebook that can barely hold a charge or load a webpage without its fans spooling up like a jet engine would now be christened an “AI PC.”

That is why yesterday brought a new brand: Copilot+ PCs. Yes, it’s a bit of a mouthful, but it’s a trademark Microsoft owns, and it won’t be handed out willy nilly; to qualify as a “Copilot+ PC” a computer needs distinct CPUs, GPUs, and NPUs (neural processing units) capable of >40 trillion operations per second (TOPS), and a minimum of 16 GB RAM and a 256 GB SSD. These aren’t supercomputers, but that is a pretty impressive baseline — the MacBook Air wouldn’t qualify, for example, as it only has 18 TOPS (and starts with only 8 GB of RAM).

[1](#fn1-12997 "It’s also unclear how specifically TOPS are defined, as the precision of the calculations used for measurements makes a big difference.")

This guaranteed baseline lets Microsoft build some genuinely new experiences. The headline feature is Recall: Copilot+ PCs will record everything that happens on your computer locally, and make it available to Copilot-mediated queries; developers can add “breadcrumbs” to their apps so that you can not just return to a specific app but also the exact context you wanted to Recall. That last bit gets at how Recall is better than Rewind, [the Mac app that provides similar functionality](https://stratechery.com/2024/more-on-humane-limitless-the-iphone-integration-barrier/); by being built into the operating system Recall can both be extended to developers even as it is made fundamentally more secure and private, with lower energy usage, thanks to the way it leverages Copilot+ level hardware.

Another fun and downright whimsical feature is Cocreator, which lets you not just edit images using AI, but also create new ones using a combination of drawing and text prompts; I tried it out and it works pretty well, with the main limitation being some amount of latency in rendering the image.

[![](https://proxy-prod.omnivore-image-cache.app/640x480,sOkj7NEQOYVq7Cn_WlK_GykA0Y8KgMxwmmvXdFIiFa8w/https://i0.wp.com/stratechery.com/wp-content/uploads/2024/05/windows-1.png?resize=640%2C480&ssl=1)](https://stratechery.com/2022/the-ai-unbundling/)

That latency, frustratingly enough, doesn’t come from the actual rendering, which happens locally on that beefy hardware, but rather the fact that Cocreator validates everything with the cloud for “safety”; never mind that you can create “unsafe” images in Paint of your own volition (at least for now).

What will be most intriguing, though, is the extent to which these capabilities will be available to 3rd-party developers. The keynote included demos from Adobe’s family of apps, DaVinci Resolve Studio, CapCut, and more, and I presume there will be much broader discussions about what is possible at the actual Build conference. The trick for Microsoft will be in getting Copilot+ PCs at critical mass such that developers build capabilities that actually utilize the hardware in question.

The hardware at the keynote, meanwhile, was based on Qualcomm’s Snapdragon X Elite ARM processor. The X Elite was built by the Nuvia team, a startup [Qualcomm acquired in 2021](https://stratechery.com/2021/intel-follow-up-qualcomm-buys-nuvia-netflix-earnings/); that team is made up of some of the creators of Apple Silicon, and while we will need to wait for benchmarks to verify Microsoft’s claims of better-than-MacBook-Air performance and battery life, it appears to be the real deal.

It’s also the culmination of a 12 year journey to move Windows to ARM: the original Surface tablet was painfully slow, a weakness that was exacerbated by the fact that basically no 3rd-party software was built to run on ARM. Today the latter situation is much improved, but more importantly, Microsoft is making big promises about the Snapdragon X performance being good enough that Windows’ new Rosetta-like emulation layer should make the experience of using x86-compiled apps seamless.

The end result — assuming that reviewed performance measures up to Microsoft’s claims — is an array of hardware from both Microsoft and its OEM partners that is MacBook Air-esque, but, unlike Apple’s offering, actually meaningfully integrated with AI in a way that not only seems useful today, but also creates the foundation to be dramatically more useful as developers leverage Microsoft’s AI capabilities going forward. I’m not going to switch (yet), but it’s the first time I’ve been tempted; at a minimum the company set a clear bar for Apple to clear at next month’s WWDC.

### Walmart’s E-Commerce Separation

Last month I had [the opportunity to interview Walmart CEO Doug McMillon](https://stratechery.com/2024/an-interview-with-walmart-ceo-doug-mcmillon-about-omnichannel-retail/). I have occasionally [written about Walmart](https://stratechery.com/?s=walmart) over the years, and I intend to do more, as the company emerges as a genuine contender in e-commerce.

Walmart is succeeding exactly how you thought they might: with an omnichannel approach that leverages their stores to offer delivery, pick-up, and in-person shopping options, including a dominant position in grocery, a nut that Amazon has struggled to crack. Around this model the company is building out all of the other necessary pieces of an at-scale e-commerce operation, including a 3rd-party marketplace and [a very compelling advertising business](https://stratechery.com/2024/walmart-earnings-walmart-connect-and-closing-the-loop-walmart-acquires-vizio/). What is fascinating — and this was a theme that emerged throughout the interview — is the circuitous path that Walmart took to get there.

Go back to 2016, when the company acquired Jet.com and I wrote [Walmart and the Multichannel Trap](https://stratechery.com/2016/walmart-and-the-multichannel-trap/); I hearkened back to Walmart’s past e-commerce pronouncements and pointed out how half-baked everything was:

> The fulfillment program Anderson went on to describe was ridiculously complex: “fast” shipped anything online to your local store, “faster” shipped a smaller selection to your house, while “fastest” made an even smaller selection available for pickup the same day. Anderson concluded:
> 
>> “Fast, faster, fastest. What a great example of a continuous channel experience that cannot easily be replicated.”
> 
> What a positively Buldakian statement! Of course such an experience “cannot easily be replicated”, because who would want to? It was, like Sears’ “socks-to-stocks” strategy, driven by solipsism: instead of starting with customer needs and working backwards to a solution, Walmart started with their own reality and created a convoluted mess. Predictably it failed.

The problem Walmart had was that every aspect of the company was oriented around the stores; that by extension meant that new initiatives, like e-commerce, had to fit in that reality, even if it resulted in a terrible experience for customers. That was why I liked the Jet.com acquisition; I wrote [in an Update](https://stratechery.com/2016/follow-up-didi-uber-and-instagram-stories-walmart-reportedly-buying-jet-com-amazons-earnings/):

> Walmart, meanwhile, finally realized a couple of months ago that while they are really good at retail logistics, that skill doesn’t translate to e-commerce in the way they hoped. [I wrote in June](https://stratechery.com/2016/jeff-bezos-at-the-code-conference-recent-amazon-news/):
> 
>> All of those analysts who assumed Wal-Mart would squish Amazon in e-commerce thanks to their own mastery of logistics were like all those who assumed Microsoft would win mobile because they won PCs. It turns out that logistics for retail are to logistics for e-commerce as operating systems for a PC are to operating systems for a phone. They look similar, and even have the same name, but require fundamentally different assumptions and priorities.
> 
> Walmart promised at the time to invest $2 billion in technology and logistics, but given Amazon’s continued encroachment the company has far more money than time: paying a bit more to get technology and infrastructure already built out is a very good choice…Ideally Walmart will keep Jet.com at arms-length: that’s the prescribed response for an incumbent dealing with a disruptive competitor. There are simply too many incentives for incumbent companies to kill new initiatives that by definition threaten the core business, and while Walmart’s executives seem to have finally learned that extending a bricks-and-mortar business model online doesn’t work, it always takes even longer for that lesson to filter down to middle managers primarily motivated by their own specific responsibilities that often aren’t aligned with the future.

Fast forward to today, and Jet.com redirects to Walmart.com, and e-commerce is, as I noted, integrated with retail, but that doesn’t mean I was wrong. McMillon noted in the interview:

> It was always the plan to bring things together, but just like the structure, it needed to be separate for a while for good reasons.

The reason is that tech, given its reliance on massive investments on a scalable platform, is inherently centralizing; that, though, is directly counter to how Walmart traditionally operated. McMillon explained:

> Taking ownership all the way down to department manager level for toys and store number #1113 has great value in it, and when a buyer feels like they’re really responsible for their category, there’s great value in that, but we have to, on behalf of the customer and in a customer-led way, have top down decision-making to say, “No, we’re not going to just respond to what you, the buyer, want the next tech priority to be”.
> 
> We’ve actually set the tech priorities driven off what we want to build for customers and what they’re asking us to solve, and that’s how it’s going to be, and that is a cultural tension even today because we actually want some of both, we want ownership. We don’t want to diminish that ownership and our store managers, they make this company go, and they make a lot of great decisions, and they’re fantastic. You may have read recently, we increased their pay and we need a tech team and a design team, a product management team and leaders that can identify priorities and make sure they get resourced.
> 
> But take a marketplace, we can’t build a marketplace one country at a time, you build one marketplace. So there have to be people that are willing to give up authority so that that gets done in a way that’s most efficient and we’re doing that now, but I think that tension is going to be here forever.

In other words, Walmart needed to build up e-commerce independent of its stores; only then, once its e-commerce operation was a viable business in its own right, and as a new generation of leadership in retail recognized its inherent value, could the company achieve the omni-channel dreams it had harbored for so long.

### The End of Windows

Back to Microsoft: the fundamental problem Nadella faced when took over Microsoft was that every aspect of the company — including, most problematically, [the culture](https://stratechery.com/2016/the-curse-of-culture/) — was built around Windows. I wrote in [Microsoft’s Monopoly Hangover](https://stratechery.com/2017/microsofts-monopoly-hangover/):

> The company loved to brag about its stable of billion dollar businesses, but in truth they were all components of one business — Windows. Everything Microsoft built from servers to productivity applications was premised on the assumption that the vast majority of computing devices were running Windows, leaving the company completely out of sorts when the iPhone and Android created and captured the smartphone market.

Former CEO Steve Ballmer couldn’t accept this reality: in his disastrous last few months he [reorganized the company around a One Microsoft concept](http://stratechery.com/2013/why-microsofts-reorganization-is-a-bad-idea/) that really meant that the rest of the company needed to better support Windows, and doubled down by buying Nokia in [a deal that made no sense](https://stratechery.com/2013/the-deal-that-makes-no-sense/), all while [Microsoft’s productivity applications were suffering](https://stratechery.com/2015/redmond-reality/) from a lack of apps for iOS and Android.

What Nadella did after he took over was not particularly complicated, but it was exceptionally difficult. I wrote in 2018’s [The End of Windows](https://stratechery.com/2018/the-end-of-windows/):

> The story of how Microsoft came to accept the reality of Windows’ decline is more interesting than the fact of Windows’ decline; this is how CEO Satya Nadella convinced the company to accept the obvious.

I then documented a few seminal decisions made to demote windows, including releasing Office on iPad as soon as he took over, explicitly re-orienting Microsoft around [services instead of devices](https://stratechery.com/2013/services-not-devices/), isolating the Windows organization from the rest of the company, killing Windows Phone, and finally, in the decision that prompted that Article, splitting up Windows itself. Microsoft was finally, not just strategically but also organizationally, a services company centered on Azure and Office; yes, Windows existed, and still served a purpose, but it didn’t call the shots for the rest of Microsoft’s products.

And yet, here I am in May 2024, celebrating a Windows event! That celebration, though, is not because Windows is differentiating the rest of Microsoft, but because the rest of Microsoft is now differentiating Windows. Nadella’s focus on AI and the company’s massive investments in compute are the real drivers of the business, and, going forward, are real potential drivers of Windows.

This is where the Walmart analogy is useful: McMillon needed to let e-commerce stand on its own and drive the development of a consumer-centric approach to commerce that depended on centralized tech-based solutions; only then could Walmart integrate its stores and online services into an omnichannel solution that makes the company the only realistic long-term rival to Amazon.

Nadella, similarly, needed to break up Windows and end Ballmer’s dreams of vertical domination so that the company could build a horizontal services business that, a few years later, could actually make Windows into a differentiated operating system that might, for the first time in years, actually drive new customer acquisition.

---

1. It’s also unclear how specifically TOPS are defined, as the precision of the calculations used for measurements makes a big difference. [↩](#rf1-12997 "Return to footnote 1.")

Apple did what needed to be done to get that unfortunate iPad ad out of the news; you know, the one that somehow found the crushing of musical instruments and bottles of paint to be inspirational:

The ad was released as a part of [the company’s iPad event](https://stratechery.com/2024/apples-ipad-event-the-peaceful-ipad-disney-earnings/), and was originally scheduled to run on TV; Tor Myhren, Apple’s vice-president of marketing communications, [told AdAge](https://adage.com/article/digital-marketing-ad-tech-news/apple-apologizes-ipad-pro-crushed-ad-it-missed-mark/2559321):

> Creativity is in our DNA at Apple, and it’s incredibly important to us to design products that empower creatives all over the world…Our goal is to always celebrate the myriad of ways users express themselves and bring their ideas to life through iPad. We missed the mark with this video, and we’re sorry.

The apology comes across as heartfelt — accentuated by the fact that [an Apple executive put his name to it](https://daringfireball.net/linked/2024/05/09/apple-crush-apology) — but I disagree with Myhren: the reason why people reacted so strongly to the ad is that it couldn’t have hit the mark more squarely.

### Aggregation Theory

The Internet, birthed as it was in the idealism of California tech in the latter parts of the 20th century, was expected to be a force for decentralization; one of the central conceits of this blog has been to explain why reality has been so different. From 2015’s [Aggregation Theory](https://stratechery.com/2015/aggregation-theory/):

> The fundamental disruption of the Internet has been to turn this dynamic on its head. First, the Internet has made distribution (of digital goods) free, neutralizing the advantage that pre-Internet distributors leveraged to integrate with suppliers. Secondly, the Internet has made transaction costs zero, making it viable for a distributor to integrate forward with end users/consumers at scale.
> 
> [![Aggregation Theory](https://proxy-prod.omnivore-image-cache.app/640x275,sS0TBK7jJ0GMtlYtRlV0r7QXUnlUYZ2o5cqtz4pk7HRg/https://i0.wp.com/stratechery.com/wp-content/uploads/2015/07/Screen-Shot-2018-03-27-at-12.47.09-PM.png?resize=640%2C275&ssl=1)](https://stratechery.com/2015/aggregation-theory/)
> 
> This has fundamentally changed the plane of competition: no longer do distributors compete based upon exclusive supplier relationships, with consumers/users an afterthought. Instead, suppliers can be commoditized leaving consumers/users as a first order priority. By extension, this means that the most important factor determining success is the user experience: the best distributors/aggregators/market-makers win by providing the best experience, which earns them the most consumers/users, which attracts the most suppliers, which enhances the user experience in a virtuous cycle.

In short, the analog world was defined by scarcity, which meant distribution of scarce goods was the locus of power; the digital world is defined by abundance, which means discovery of what you actually want to see is the locus of power. The result is that consumers have access to anything, which is to say that nothing is special; everything has been flattened.

* Google broke down every publication in the world into individual pages; search results didn’t deliver you to the front page of a newspaper or magazine, but rather dropped you onto individual articles.
* Facebook promoted user-generated content to the same level of the hierarchy as articles from professional publications; your feed might have a picture of your niece followed by a link to a deeply-reported investigative report followed by a meme.
* Amazon created the “Everything Store” with practically every item on Earth and the capability to deliver it to your doorstep; instead of running errands you could simply check out.
* Netflix transformed “What’s on?” to “What do you want to watch?”. Everything from high-brow movies to budget flicks to prestige TV to reality TV was on equal footing, ready to be streamed whenever and wherever you wanted.
* Sites like Expedia and Booking changed travel from an adventure mediated by a travel agent or long-standing brands to search results organized by price and amenities.

Moreover, this was only v1; it turns out that the flattening can go even further:

* LLMs are breaking down all written text ever into massive models that don’t even bother with pages: they simply give you the answer.
* TikTok disabused Meta of the notion that your relationships were a useful constraint on the content you wanted to see; now all short-form video apps surface content from across the entire network based on their understanding of what you individually are interested in.
* Amazon is transforming into a logistics powerhouse befitting the fact that Amazon.com is increasingly dominated by 3rd-party merchant sales, and extending that capability throughout the economy.
* All of Hollywood, convinced that content was what mattered, jointly killed the linear TV model to ensure that all professionally-produced content was available on-demand, even as YouTube became the biggest streamer of all with user-generated content that is delivered through the exact same distribution channel (apps on a smart device) as the biggest blockbusters.
* Services like Uber and Airbnb commoditized transportation and lodging to the individual driver or homeowner.

Apple is absent from this list, although the App Store has had an Aggregator effect on developers; the reason the company belongs, though, and why they were the only company that could make an ad that so perfectly captures this great flattening, is because they created the device on which all of these services operate. The prerequisite to the commoditization of everything is access to anything, thanks to the smartphone. “There’s an app for that” indeed:

This is what I mean when I say that Apple’s iPad ad hit the mark: the reason why I think the ad resonated so deeply is that it captured something deep in the gestalt that actually has very little to do with trumpets or guitars or bottles of paint; rather, thanks to the Internet — particularly the smartphone-denominated Internet — everything is an app.

### The Bicycle for the Mind

The more tangible way to see in which that iPad ad hit the mark it to play it in reverse:

This is without question the message that Apple was going for: this one device, thin as can be, contains musical instruments, an artist’s studio, an arcade machine, and more. It brings relationships without borders to life, complete with cute emoji. And that’s not wrong!

Indeed, it harkens back to one of Steve Jobs’ last keynotes, when he introduced the iPad 2\. My favorite moment in that keynote — one of my favorite Steve Jobs’ keynote moments ever, in fact — was the introduction of GarageBand. You can [watch the entire introduction and demo](https://videos.files.wordpress.com/pyENUudf/garageband-introduction.mp4), but the part that stands out in my memory is Jobs — clearly sick, in retrospect — moved by what the company had just produced:

> I’m blown away with this stuff. Playing your own instruments, or using the smart instruments, anyone can make music now, in something that’s this thick and weighs 1.3 pounds. It’s unbelievable. GarageBand for iPad. Great set of features — again, this is no toy. This is something you can really use for real work. This is something that, I cannot tell you, how many hours teenagers are going to spend making music with this, and teaching themselves about music with this.

Jobs wasn’t wrong: [global hits have originated on GarageBand](https://medium.com/@certifiedmish/artists-who-made-global-hits-with-garageband-32314c0861e1), and undoubtedly many more hours of (mostly terrible, if my personal experience is any indication) amateur experimentation. Why I think this demo was so personally meaningful for Jobs, though, is that not only was GarageBand about music, one of his deepest passions, but it was also a manifestation of his life’s work: creating a bicycle for the mind.

> I remember reading an Article when I was about 12 years old, I think it might have been in _Scientific American_, where they measured the efficiency of locomotion for all these species on planet earth. How many kilocalories did they expend to get from point A to point B, and the condor won: it came in at the top of the list, surpassed everything else. And humans came in about a third of the way down the list, which was not such a great showing for the crown of creation.
> 
> But somebody there had the imagination to test the efficiency of a human riding a bicycle. Human riding a bicycle blew away the condor, all the way off the top of the list. And it made a really big impression on me that we humans are tool builders, and that we can fashion tools that amplify these inherent abilities that we have to spectacular magnitudes, and so for me a computer has always been a bicycle of the mind, something that takes us far beyond our inherent abilities.
> 
> I think we’re just at the early stages of this tool, very early stages, and we’ve come only a very short distance, and it’s still in its formation, but already we’ve seen enormous changes, but I think that’s nothing compared to what’s coming in the next 100 years.

In Jobs’ view of the world, teenagers the world over are potential musicians, who might not be able to afford a piano or guitar or trumpet; if, though, they can get an iPad — now even thinner and lighter! — they can have access to everything they need. In this view “There’s an app for that” is profoundly empowering.

### After the Flattening

The duality of Apple’s ad speaks to the reality of technology: its impact is structural, and amoral. When I first started Stratechery I wrote a piece called [Friction](https://stratechery.com/2013/friction/):

> If there is a single phrase that describes the effect of the Internet, it is the elimination of friction. With the loss of friction, there is necessarily the loss of everything built on friction, including value, privacy, and livelihoods. And that’s only three examples! The Internet is pulling out the foundations of nearly every institution and social more that our society is built upon.
> 
> Count me with those who believe the Internet is on par with the industrial revolution, the full impact of which stretched over centuries. And it wasn’t all good. Like today, the industrial revolution included a period of time that saw many lose their jobs and a massive surge in inequality. It also lifted millions of others out of sustenance farming. Then again, it also propagated slavery, particularly in North America. The industrial revolution led to new monetary systems, and it created robber barons. Modern democracies sprouted from the industrial revolution, and so did fascism and communism. The quality of life of millions and millions was unimaginably improved, and millions and millions died in two unimaginably terrible wars.
> 
> Change is guaranteed, but the type of change is not; never is that more true than today. See, friction makes everything harder, both the good we can do, but also the unimaginably terrible. In our zeal to reduce friction and our eagerness to celebrate the good, we ought not lose sight of the potential bad.

Today that exhortation might run in the opposite direction: in our angst about the removal of specialness and our eagerness to criticize the bad, we ought not lose sight of the potential good.

Start with this site that you are reading: yes, the Internet commoditized content that was previously granted value by virtue of being bundled with a light manufacturing business (i.e. printing presses and delivery trucks), but it also created the opportunity for entirely new kinds of content predicated on reaching niche audiences that are only sustainable when the entire world is your market.

The same principle applies to every other form of content, from music to video to books to art; the extent to which being “special” meant being scarce is the extent to which the existence of “special” meant a constriction of opportunity. Moreover, that opportunity is not a function of privilege but rather consumer demand: the old powers may decry that their content is competing with everyone on the Internet, but they are only losing to the extent that consumers actually prefer to read or watch or listen to something else. Is this supposed to be a bad thing?

Moreover, this is just as much a feather in Apple’s cap as the commoditization of everything is a black mark: Apple creates devices — tools — that let everyone be a creator. Indeed, that is why the ad works in both directions: the flattening of everything means there has been a loss; the flattening of everything also means there is entirely new opportunity.

### The AI Choice

One thing I do credit Apple for is not trying to erase the ad from the Internet — it’s still posted on [CEO Tim Cook’s X account](https://twitter.com/tim%5Fcook/status/1787864325258162239) — because I think it’s important not just as a marker of what has happened over the last several years, but also the choices facing us in the years ahead.

The last time I referenced Steve Jobs’ “Bicycle of the Mind” analogy was in [2018’s Tech’s Two Philosophies](https://stratechery.com/2018/techs-two-philosophies/), where I contrasted Google and Facebook on one side, and Microsoft and Apple on the other: the former wanted to create products that did things for you; the latter products that let you do more things. This was a simplified characterization, to be sure, but, as I noted in that Article, it was also related to their traditional positions as Aggregators and platforms, respectively.

What is increasingly clear, though, is that Jobs’ prediction that future changes would be even more profound raise questions about the “bicycle for the mind” analogy itself: specifically, will AI be a bicycle that we control, or an unstoppable train to destinations unknown? To put it in the same terms as the ad, will human will and initiative be flattened, or expanded?

The route to the former seems clear, and maybe even the default: this is a world where a small number of entities “own” AI, and we use it — or are used by it — on their terms. This is the outcome being pushed by those obsessed with “safety”, and demanding regulation and reporting; that those advocates also seem to have a stake in today’s leading models [seems strangely ignored](https://stratechery.com/2023/attenuating-innovation-ai/).

The alternative — [MKBHDs For Everything](https://stratechery.com/2024/mkbhds-for-everything/) — means openness and commoditization. Yes, those words have downsides: they mean that the powers that be are not special, and sometimes that is something we lament, as I noted at the beginning of this Article. Our alternative, though, is not the [gatekept world](https://stratechery.com/2017/goodbye-gatekeepers/) of the 20th century — [we can’t go backwards](https://stratechery.com/2023/regretful-accelerationism/) — but one where the flattening is not the elimination of vitality but the tilling of the ground so that something — many things — new can be created.

_This Article is available as a video essay on [YouTube](https://youtu.be/7AaE3ztTA2A?si=OHqeGUbLw-Bw0kdM)_

---

Stop me if you heard this one before. From [Bloomberg](https://www.bloomberg.com/news/articles/2024-04-24/meta-projects-higher-spending-weaker-revenue-amid-ai-push):

> Mark Zuckerberg is asking investors for patience again. Instead, they’re alarmed. After Meta Platforms Inc. revealed that it will spend billions of dollars more than expected this year — fueled by investments in artificial intelligence — the company’s chief executive officer did his best to soothe Wall Street. But the spending forecast, coupled with slower sales growth than anticipated, sent the shares tumbling as much as 16% in New York on Thursday morning, the biggest drop since October 2022.

18 months ago I created a meme for exactly this occassion:

[![The GTA meme about "Here we go again" as applied to Facebook](https://proxy-prod.omnivore-image-cache.app/640x360,szdlGPdlgITI10mTJxR-jRu8VrvAlQ41YdYso3AwJzyo/https://i0.wp.com/stratechery.com/wp-content/uploads/2022/10/meta-myths-1.png?resize=640%2C360&ssl=1)](https://stratechery.com/2022/meta-myths/)

I posted that meme in [Meta Myths](https://stratechery.com/2022/meta-myths/), where I argued that Meta was in far better shape than investors realized:

* Users were not deserting Facebook.
* Instagram engagement was growing.
* TikTok growth had leveled out.
* Digital advertising was recovering from ATT.
* Meta’s increase in capital expenditures — which [we now know was mostly for Nvidia GPUs](https://stratechery.com/2024/nvidia-earnings-inference-and-meta/) — was justified.

Notice, though, that the meme implies this happened more than once. Indeed, in 2018 I had written [Facebook Lenses](https://stratechery.com/2018/facebook-lenses/) after another stock market meltdown:

* Using a financial lens, Facebook revenue was in good shape but growing costs were a concern.
* Using a product lens, Facebook was in very good shape given the growth opportunities available in its non-Facebook-app properties.
* Using an advertising lens, Facebook was in very good shape given the quality of its infrastrcture.
* Using a strategic lens, Facebook’s moats were deeper than ever, thanks in part to regulation.
* Using a “reason-to-exist” lens, Facebook was, as it had been from its founding, underrated by folks who didn’t understand how powerful digitizing the connection between friends and family was.

Given this history, you might think that I’m here to once again raise the Meta flag and declare investors insane; in fact, this time is different: I understand the market’s reaction and, at least partially, share its skepticism about Meta’s short to medium-term future. The big question is the long run.

### Meta’s Short-Term Capex Costs

There was one consistent theme across the big tech earnings calls last week: spend, baby, spend! From [Google’s earnings call](https://seekingalpha.com/article/4686483-alphabet-inc-goog-q1-2024-earnings-call-transcript):

> With respect to CapEx, our reported CapEx in the first quarter was $12 billion, once again driven overwhelmingly by investment in our technical infrastructure with the largest component for servers followed by data centers. The significant year-on-year growth in CapEx in recent quarters reflects our confidence in the opportunities offered by AI across our business. Looking ahead, we expect quarterly CapEx throughout the year to be roughly at or above the Q1 level, keeping in mind that the timing of cash payments can cause variability in quarterly reported CapEx.

From [Microsoft’s earnings call](https://seekingalpha.com/article/4686499-microsoft-corporation-msft-q3-2024-earnings-call-transcript):

> Capital expenditures, including finance leases, were $14 billion to support our cloud demand, inclusive of the need to scale our AI infrastructure. Cash paid for PP&E was $11 billion. Cash flow from operations was $31.9 billion, up 31%, driven by strong cloud billings and collections…We expect capital expenditures to increase materially on a sequential basis driven by cloud and AI infrastructure investments. As a reminder, there can be normal quarterly spend variability in the timing of our cloud infrastructure build-outs and the timing of finance leases. We continue to bring capacity online as we scale our AI investments with growing demand. Currently, near-term AI demand is a bit higher than our available capacity.

From [Meta’s earnings call](https://s21.q4cdn.com/399680738/files/doc%5Ffinancials/2024/q1/META-Q1-2024-Earnings-Call-Transcript.pdf):

> We anticipate our full-year 2024 capital expenditures will be in the range of $35-40 billion, increased from our prior range of $30-37 billion as we continue to accelerate our infrastructure investments to support our AI roadmap. While we are not providing guidance for years beyond 2024, we expect capex will continue to increase next year as we invest aggressively to support our ambitious AI research and product development efforts.

The market reception to Microsoft and Google, though, could not be more different than the reaction to Meta; from [Bloomberg](https://www.bloomberg.com/news/articles/2024-04-26/microsoft-google-gain-after-ai-fuels-cloud-computing-demand):

> Microsoft Corp. and Google owner Alphabet Inc. sent a clear message to investors on Thursday: Our spending on artificial intelligence and cloud computing is paying off. The companies trounced Wall Street estimates with their latest quarterly results, lifted by a surge in cloud revenue — fueled in part by booming use of AI services. Alphabet shares surged as much as 12%, the biggest gain since July 2015, to their highest level ever. The rally pushed Alphabet’s valuation past $2 trillion. Microsoft rose as much as 3.5%.
> 
> The tech titans have been locked in a fierce battle for dominance in the field of artificial intelligence, with Microsoft joining forces with startup OpenAI to challenge Google’s two-decade stranglehold on internet search. But Thursday’s results showed there’s ample room for both companies to grow.

Microsoft is the best positioned to benefit from AI in the short-term: first, they have a cloud business in Azure that sells to enterprises eager to implement AI into their businesses; Azure grew 31% with 7 points of that growth coming from AI services.

[1](#fn1-12865 "One thing to keep in mind with Microsoft’s reporting is that this is where OpenAI spending — via Azure credits — shows up on the earnings report") Second, they have an enterprise software business that can expand its average revenue per user by selling AI services; Microsoft didn’t report how many CoPilot seat licenses they sold, but they did say it contributed to Office 365’s 15% growth in commercial revenue. These clear opportunities for monetization, along with the potential upside of AI generally, should and do make investors happy about the additional capex investment.

Google also clearly benefits from AI, particularly in terms of Google Cloud. I wrote [a very positive overview of Google Cloud’s prospects](https://stratechery.com/2024/gemini-1-5-and-googles-nature/) earlier this month because the story is so clear: bringing Google’s massive infrastructure advantages to bear in the Cloud is a very straightforward proposition with very significant upside. Google can not only expand ARPU with existing customers, but also has a wedge to win new customers, who will then potentially shift the rest of their cloud spending to Google Cloud.

Google’s consumer story is a bit more complicated: there is obvious consumer utility in AI-powered search results, but giving an answer instead of a set of links is a challenge both [to Google’s business model](https://stratechery.com/2024/india-and-gemini-ten-blue-links-the-complicity-framework/) and to its [ability to serve the entire market without controversy](https://stratechery.com/2024/aggregators-ai-risk/). Even despite those challenges, though, there are benefits in terms of improved recommendations, better ad targeting, generative advertisements, etc. On balance the increased investment is clearly worth it.

Meta doesn’t have as many clear applications in terms of short-term revenue opportunities: the company does not operate a cloud business, so no one is consuming — i.e. paying for — the use of Meta’s capex other than Meta itself. Meanwhile, the company’s consumer prospects are broadly similar to Google’s: yes, Meta can and is improving recommendations and ad targeting and implementing generative advertising, and also has the prospect of making click-to-message ads viable for businesses that can’t afford to pay for a human on the other end of a chat session. Still, the short-term upside is not nearly as clear as it is for Microsoft and Google.

### Meta’s Advertising Cycle and the Mid-Term

The other big business opportunity Zuckerberg emphasized on the earnings call was MetaAI, which he compared to Stories and Reels:

> You all know our product development playbook by this point. We release an early version of a product to a limited audience to gather feedback and start improving it, and then once we think it’s ready then we make it available to more people. That early release was last fall and with this release we’re now moving to that next growth phase of our playbook. We believe that Meta AI with Llama 3 is now the most intelligent AI assistant that you can freely use. And now that we have the superior quality product, we’re making it easier for lots of people to use it within WhatsApp, Messenger, Instagram, and Facebook.

But then what? Zuckerberg offered some vague ideas later in the call:

> I do think that there will be an ability to have ads and paid content in Meta AI interactions over time as well as people being able to pay for, whether it’s bigger models or more compute or some of the premium features and things like that. But that’s all very early in fleshing out.

Stories and Reels were not complicated in this regard: sure, Stories ads needed to have a larger visual component than Feed ads, and Reels ads are better if they are video, but at the end of the day the ad unit is the same across all of Meta’s channels. MetaAI, on the other hand, is going to require a completely different approach. I’m not saying that Meta won’t figure it out — Google needs to experiment here as well, and one’s experimentation will likely help the other — but the long-term revenue opportunity is not nearly as clearcut as Zuckerberg is painting it out to be.

What is clear is that figuring this out will take time, which is a concern given where Meta is in its advertising cycle. Long-time Stratechery subscribers know that I frequently reference this chart while reviewing Meta’s earnings:

![Meta's various growth metrics](https://proxy-prod.omnivore-image-cache.app/640x309,shE0NdcOMEuyh0wSf5bSzOzOyKn97-pjgbxDsZQZAaKA/https://i0.wp.com/stratechery.com/wp-content/uploads/2024/04/metadoubt-1.png?resize=640%2C309&ssl=1)

The most important thing to understand about this chart is that the growth in impressions is usually inversely correlated with the growth in price-per-ad, which makes intuitive sense: more impressions means more supply which, with an equivalent amount of demand, results in lower prices. The two big exceptions are related to Apple’s App Tracking Transparency changes: in 2022 the price-per-ad decelerated much more quickly than impressions grew, as Meta dealt with the loss of deterministic signal it suffered because of ATT; then, in 2023, the price-per-ad grew even as impressions grew as Meta reworked its targeting to operate probabilistically instead of deterministically.

Setting those two anomalies aside, there are two-and-a-half inversions of impression and price-per-ad growth rates on this chart:

* In 2017 Meta saturated the Instagram feed with ads; this led impressions growth to drop and the price-per-ad to increase; then, in 2018, Instagram started to monetize Stories, leading to increased growth in impressions and corresponding decreases in price-per-ad growth.
* In 2020 Meta saturated Instagram Stories; this once again led impressions growth to drop and the price-per-ad to increase; then, while COVID provided a boost in 2021, 2022 saw a significant increase in Reels monetization, leading to increased growth in impressions and a decrease in price-per-ad growth (which, as noted above, was made more extreme by ATT).
* Since the middle of last year Meta Impressions growth is once again dropping as Reels becomes saturated; this is leading to an increase in price-per-ad growth (although the lines have not yet crossed).

The most optimistic time for Meta’s advertising business is, counter-intuitively, when the price-per-ad is dropping, because that means that impressions are increasing. This means that Meta is creating new long-term revenue opportunities, even as its ads become cost competitive with more of its competitors; it’s also notable that this is the point when previous investor freak-outs have happened.

Notice, though, that this time is different; CFO Susan Li said on the earnings call:

> One thing I’d share, for example, is that we actually grew conversions at a faster rate than we grew impressions over the course of this quarter. So we are — we’re expecting to — which basically suggests that our conversion grade is growing and is one of the ways in which our ads are becoming more performant.

This is true, but it also means this specific moment in time is a much less bullish one for Meta’s advertising business than past stock drops: impressions growth declining means that price-per-ad is the primary route for revenue growth, which will happen but will also open the door for more of Meta’s competitors. Yes, those future advertising opportunities that Zuckerberg talked about will probably lead to another inversion at some point, but not only are those opportunities uncertain as I noted, but they also are quite a ways in the future (and the bill for GPUs is today).

### Meta’s Long-Term Prospects

The most interesting thing Zuckerberg said on the earnings call, meanwhile, was about the Metaverse and its relationship to AI:

> In addition to our work on AI, our other long term focus is the metaverse. It’s been interesting to see how these two themes have come together.
> 
> This is clearest when you look at glasses. I used to think that AR glasses wouldn’t really be a mainstream product until we had full holographic displays — and I still think that will be awesome and is mature state of the product. But now it seems pretty clear that there’s also a meaningful market for fashionable AI glasses without a display. Glasses are the ideal device for an AI assistant because you can let them see what you see and hear what you hear, so they have full context on what’s going on around you as they help you with whatever you’re trying to do. Our launch this week of Meta AI with Vision on the glasses is a good example where you can now ask questions about things you’re looking at.
> 
> One strategy dynamic that I’ve been reflecting on is that an increasing amount of our Reality Labs work is going towards serving our AI efforts. We currently report on our financials as if Family of Apps and Reality Labs were two completely separate businesses, but strategically I think of them as fundamentally the same business with the vision of Reality Labs to build the next generation of computing platforms in large part so that way we can build the best apps and experiences on top of them. Over time, we’ll need to find better ways to articulate the value that’s generated here across both segments so it doesn’t just seem like our hardware costs increase as our glasses ecosystem scales but all the value flows to a different segment.

[I have been arguing for a couple of years](https://stratechery.com/2022/dall-e-the-metaverse-and-zero-marginal-content/) that generative AI is going to be critical to making the Metaverse a compelling place to be, primarily in the context of VR; you can make a similar case for AR, particularly in terms of talking to your assistant. It’s interesting that Zuckerberg is making a similar argument, but backwards: instead of talking about AI costing money that accrues to the hardware division, he is talking about hardware costing money that accrues to the AI division.

Regardless, the broader point about AI and the metaverse being complements seems right to me, and in the long run the metaverse should be the internal Meta AI customer that serves a similar function as Microsoft or Google’s cloud customers in terms of necessitating and monetizing huge amounts of capacity. That, though, is a bit frightening: in _Meta Myths_ I conceded that the metaverse might not amount to anything, but that it was immaterial to the then swoon in Meta’s stock. In this case it seems more material: yes, there are applications for AI in Meta’s products, but the real upside may depend on Zuckerberg’s other big bet paying off.

That, in the end, gets at the real question for Meta shareholders: do you trust Zuckerberg? There was another big Meta sell-off in early 2022, and I wrote this [in an Update](https://stratechery.com/2022/metas-earnings-facebooks-three-challenges-financial-versus-existential-risks/):

> To that end, just as Facebook’s product changes are evidence that TikTok is real competition, today’s stock price drop is also evidence of the benefit of founder control. Meta could have delayed its response to TikTok until ATT worked its way through the system, but instead the company is fundamentally changing its products at the very moment its results are the most impacted by Apple’s changes. The easier decision, particularly for a manager, would have been to wait a quarter or two, when the comps would have been easier, and the excuses clearer, but founders have the freedom to prioritize existential risks over financial ones.
> 
> Of course they also have the freedom to spend $10 billion on a speculative bet like the Metaverse, an amount that will “increase meaningfully” in 2022; Meta continues to be first and foremost [a bet on Zuckerberg](https://stratechery.com/2021/meta/).

I do think that continues to be a bet worth making: Meta met the challenges in the first paragraph — thanks in part to its last big capex increase — and [is making the right strategic moves](https://stratechery.com/2024/meta-and-open/) to make that second paragraph pay off, even as it doubles down on AI. These are big bets, though, and I understand reasonable doubt in the meantime.

---

---

1. One thing to keep in mind with Microsoft’s reporting is that this is where OpenAI spending — via Azure credits — shows up on the earnings report [↩](#rf1-12865 "Return to footnote 1.")

_This Article is available as a video essay on [YouTube](https://youtu.be/D-rIfMAPq5Y?si=KWJrEcJaZdWHMfzQ)_

---

Apple released the Vision Pro on February 2; 12 days later Meta CEO Mark Zuckerberg delivered his verdict:

> Alright guys, so I finally tried Apple’s Vision Pro. And you know, I have to say that before this, I expected that Quest would be the better value for most people since it’s really good and it’s like seven times less expensive. But after using it I don’t just think that Quest is the better value — I think the Quest is the better product, period.

You can watch the video for Zuckerberg’s full — and certainly biased! — take, but the pertinent section for this Article came towards the end:

> The reality is that every generation of computing has an open and a closed model, and yeah, in mobile, Apple’s closed model won. But it’s not always that way. If you go back to the PC era, Microsoft’s open model was the winner, and in this next generation, Meta is going to be the open model, and I really want to make sure that the open model wins out again. The future is not yet written.

John Gruber [asked on Daring Fireball](https://daringfireball.net/linked/2024/02/14/zuckerberg-vision-pro):

> At the end, he makes the case that each new generation of computing devices has an open alternative and a closed one from Apple. (It’s interesting to think that these rivalries might be best thought of not as closed-vs.-open, but as Apple-vs.-the-rest-of-the-industry.) I’m not quite sure where he’s going with that, though, because I don’t really see how my Quest 3 is any more “open” than my Vision Pro. Are they going to license the OS to other headset makers?

Cue Zuckerberg yesterday:

> Some updates on the metaverse today. We are releasing Meta Horizon OS, our operating system that powers Quest virtual and mixed reality headsets, and we are partnering with some of the best hardware companies out there to design new headsets that are optimized for all the different ways that people use this tech.
> 
> Now, in every era of computing, there are always open and closed models. Apple’s closed model basically went out. Phones are tightly controlled and you’re kind of locked into what they’ll let you do. But it doesn’t have to be that way. In the PC era, the open model won out. You can do a lot more things, install mods. You got more diversity of hardware, software and more. So our goal is to make it so the open model defines the next generation of computing again with the metaverse, glasses and headsets. That’s why we’re releasing our operating systems so that more companies can build different things on it.

It’s natural to view this announcement as a reaction to the Vision Pro, or perhaps to [Google’s upcoming AR announcment at Google I/O](https://twitter.com/GoogleARVR/status/1778120765633659318), which is rumored to include [a new Samsung headset](https://www.sammobile.com/news/samsung-xr-headset-features-reveal-google-i-o-2024/). However, I think that this sells Zuckerberg and Meta’s strategic acumen short: this is an obvious next step, of a piece with the company’s recent AI announcements, and a clear missing piece in the overall metaverse puzzle.

### Meta’s Market

Any question of strategy starts with understanding your market, so what is Meta’s? This is a trickier question than you might think, particularly on the Internet. It’s a definition that has particularly vexed regulators, as I laid out in [Regulators and Reality](https://stratechery.com/2021/regulators-and-reality/); after describing why the FTC’s extremely narrow definition of “personal social networking” — which excluded everything from Twitter to Reddit to LinkedIn to TikTok to YouTube as Facebook competitors — didn’t make sense, I explained:

> The far bigger problem, though, is that everything I just wrote is meaningless, because everything listed above is a non-rivalrous digital service with zero marginal costs and zero transactional costs; users can and do use all of them at the same time. Indeed, the fact that all of these services can and do exist for the same users at the same time makes the case that Facebook’s market is in fact phenomenally competitive.
> 
> What, though, is Facebook competing for? Competition implies rivalry, that is, some asset that can only be consumed by one service to the exclusion of others, and the only rivalrous good in digital services is consumer time and attention. Users only have one set of eyes, and only 24 hours in a day, and every second spent with one service is a second not spent with another (although this isn’t technically true, since you could, say, listen to one while watching another while scrolling a third while responding to notifications from a fourth, fifth, and sixth). Note the percentages in this chart of platform usage:
> 
> [![Users spend more time on TikTok than other social media platforms](https://proxy-prod.omnivore-image-cache.app/640x368,suxOdxBnQlYZGBStacqdxjSBiFExUHuwQNSi5WjX4F20/https://i0.wp.com/stratechery.com/wp-content/uploads/2021/09/realityregulators2-2.png?resize=640%2C368&ssl=1)](https://stratechery.com/2021/regulators-and-reality/)
> 
> The total is not 100, it is 372, because none of these services exclude usage of any of the others. And while Facebook is obviously doing well in terms of total users, TikTok in particular looms quite large when it comes to time, the only metric that matters:
> 
> [![Most American adults use multiple online services](https://proxy-prod.omnivore-image-cache.app/640x557,sII8xmiEEc6vAK2FHL45ZL5eOZsuCt4lWXAogj7fCTwk/https://i0.wp.com/stratechery.com/wp-content/uploads/2021/09/realityregulators2-1.png?resize=640%2C557&ssl=1)](https://stratechery.com/2021/regulators-and-reality/)
> 
> This, of course, is why all of these services, including [Instagram](https://stratechery.com/2021/instagrams-evolution/), [Snapchat](https://stratechery.com/2021/snap-earnings-twitter-earnings-additional-notes/), and [YouTube](https://techcrunch.com/2021/03/18/2126652/) are trying to mimic TikTok as quickly as possible, which, last time I checked, is a competitive response, not a monopolistic one. You can even grant the argument that Facebook tried to corner the social media market — whatever that is — a decade ago, but you have to also admit that here in 2021 it is clear that they failed. Competition is the surest sign that there was not actually any anticompetitive conduct, and I don’t think it is the FTC’s job to hold Facebook management accountable for failing to achieve their alleged goals.

This idea that time and attention is the only scarce resource on the Internet, and thus the only market that truly matters, is what undergirds [Netflix’s shift in reporting away from members and towards engagement](https://stratechery.com/2024/netflix-earnings-netflixs-reporting-change-netflixs-waiting-game/); the company has been saying for years that its competitors were not just other streaming services, but everything from YouTube to Twitch streaming to video games to social media. That has always been true, if you squint, but on the Internet, where everything is only a click (or app) away, it’s tangible.

### Meta’s Differentiation

Defining the relevant market as time and attention has surprising implications, that even companies raised on the Internet, including Meta, sometimes miss. Indeed, there was a time when Meta might have agreed with the FTC’s definition, because the company made competitive decisions — both big successes and big mistakes — predicated on the assumption that your personal social network was the market that mattered.

Start with an Article I wrote in 2015 entitled [Facebook and the Feed](https://stratechery.com/2015/facebook-and-the-feed/):

> Zuckerberg is quite clear about what drives him; he wrote in [Facebook’s S-1](http://www.sec.gov/Archives/edgar/data/1326801/000119312512034517/d287954ds1.htm#toc287954%5F10):
> 
>> Facebook was not originally created to be a company. It was built to accomplish a social mission – to make the world more open and connected.
> 
> I am starting to wonder if these two ideas — company versus mission — might not be more in tension now than they have ever been in the past…I suspect that Zuckerberg for one subscribes to the first idea: that people find what others say inherently valuable, and that it is the access to that information that makes Facebook indispensable. Conveniently, this fits with his mission for the company. For my part, though, I’m not so sure. It’s just as possible that Facebook is compelling for the content it surfaces, regardless of who surfaces it. And, if the latter is the case, then Facebook’s engagement moat is less its network effects than it is that for almost a billion users Facebook is their most essential digital habit: their door to the Internet.

A year later and Facebook responded to what was then its most pressing threat, Snapchat, by putting Stories into Instagram. I wrote in [The Audacity of Copying Well](https://stratechery.com/2016/the-audacity-of-copying-well/):

> For all of Snapchat’s explosive growth, Instagram is still more than double the size, with far more penetration across multiple demographics and international users. Rather than launch a “Stories” app without the network that is the most fundamental feature of any app built on sharing, Facebook is leveraging one of their most valuable assets: Instagram’s 500 million users.
> 
> The results, at least anecdotally, speak for themselves: I’ve seen more Instagram stories in the last 24 hours than I have Snapchat ones. Of course a big part of this is the novelty aspect, which will fade, and I follow a lot more people on Instagram than I do on Snapchat. That last point, though, is, well, the point: I and my friends are not exactly Snapchat’s target demographic today, but for the service to reach its potential we will be eventually. Unless, of course, Instagram Stories ends up being good enough.

It was good enough — Instagram arrested Snapchat’s growth, while boosting its own engagement and user base — so score one for Zuckerberg, right? Instagram had a better network, so they won…or did they simply have more preexisting usage, which while based on a network, was actually incidental to it?

Fast forward a few years and Facebook’s big competitor was TikTok; I wrote in 2020’s [The TikTok War](https://stratechery.com/2020/the-tiktok-war/):

> All of this explains what makes TikTok such a breakthrough product. First, humans like video. Second, TikTok’s video creation tools were far more accessible and inspiring for non-professional videographers. The crucial missing piece, though, is that TikTok isn’t really a social network…by expanding the library of available video from those made by your network to any video made by anyone on the service, Douyin/TikTok leverages the sheer scale of user-generated content to generate far more compelling content than professionals could ever generate, and relies on its algorithms to ensure that users are only seeing the cream of the crop.

In [a follow-up Update](https://stratechery.com/2020/xi-jinping-thought-facebooks-blindspot-the-moat-map-revisited/) I explained why this was a blindspot for Facebook:

> First, Facebook views itself first-and-foremost as a social network, so it is disinclined to see that as a liability. Second, that view was reinforced by the way in which Facebook took on Snapchat. The point of _The Audacity of Copying Well_ is that Facebook leveraged Instagram’s social network to halt Snapchat’s growth, which only reinforced that the network was Facebook’s greatest asset, making the TikTok blindspot even larger.

I am, in the end, actually making the same point as the previous section: Meta’s relevant market is user time and attention; it follows that Meta’s differentiation is the fact it marshals so much user time and attention, and that said marshaling was achieved via social networking is interesting but not necessarily strategically relevant. Indeed, Instagram in the end simply copied TikTok, surfacing content from anywhere on your network, and did so to great success.

### Llama 3

This is the appropriate framework to understand Meta’s AI strategy with its Llama family of models: Llama 3 was [released last week](https://ai.meta.com/blog/meta-llama-3/), and like Llama 2, it is open source, or, perhaps more accurately, open weights (with the caveat that hyperscalers [need a license](https://stratechery.com/2023/streaming-residuals-and-spotify-llama-2-open-sourced-llamas-license/) to offer Llama as a managed model). I explained why open weights makes sense in a [May 2023 Update](https://stratechery.com/2023/free-meta-open-sources-another-ai-model-moats-and-open-source-apple-and-meta/) predicting the Llama 2 release:

> Meta isn’t selling its capabilities; rather, it sells a canvas for users to put whatever content they desire, and to consume the content created by other users. It follows, then, that Meta ought to be fairly agnostic about how and where that content is created; by extension, if Meta were to open source its content creation models, the most obvious place where the content of those models would be published is on Meta platforms. To put it another way, Meta’s entire business is predicated on content being a commodity; making creation into a commodity as well simply provides more grist for the mill.
> 
> What is compelling about this reality, and the reason I latched onto Zuckerberg’s comments in that call, is that Meta is uniquely positioned to overcome all of the limitations of open source, from training to verification to RLHF to data quality, precisely because the company’s business model doesn’t depend on having the best models, but simply on the world having a lot of them.

The best analogy for Meta’s approach with Llama is what the company did in the data center. Google had revolutionized data center design in the 2000s, pioneering the use of commodity hardware with software-defined functionality; Facebook didn’t have the scale to duplicate Google’s differentiation in 2011, so it went in the opposite direction and created the Open Compute Project. Zuckerberg explained what happened next in [an interview with Dwarkesh Patel](https://www.dwarkeshpatel.com/p/mark-zuckerberg):

> We don’t tend to open source our product. We don’t take the code for Instagram and make it open source. We take a lot of the low-level infrastructure and we make that open source. Probably the biggest one in our history was our Open Compute Project where we took the designs for all of our servers, network switches, and data centers, and made it open source and it ended up being super helpful. Although a lot of people can design servers the industry now standardized on our design, which meant that the supply chains basically all got built out around our design. So volumes went up, it got cheaper for everyone, and it saved us billions of dollars which was awesome.

Zuckerberg then made the analogy I’m referring to:

> So there’s multiple ways where open source could be helpful for us. One is if people figure out how to run the models more cheaply. We’re going to be spending tens, or a hundred billion dollars or more over time on all this stuff. So if we can do that 10% more efficiently, we’re saving billions or tens of billions of dollars. That’s probably worth a lot by itself. Especially if there are other competitive models out there, it’s not like our thing is giving away some kind of crazy advantage.

It’s not just about having a better model, though: it’s about ensuring that Meta doesn’t have a dependency on any one model as well. Zuckerberg continued:

> Here’s one analogy on this. One thing that I think generally sucks about the mobile ecosystem is that you have these two gatekeeper companies, Apple and Google, that can tell you what you’re allowed to build. There’s the economic version of that which is like when we build something and they just take a bunch of your money. But then there’s the qualitative version, which is actually what upsets me more. There’s a bunch of times when we’ve launched or wanted to launch features and Apple’s just like “nope, you’re not launching that.” That sucks, right? So the question is, are we set up for a world like that with AI? You’re going to get a handful of companies that run these closed models that are going to be in control of the APIs and therefore able to tell you what you can build?
> 
> For us I can say it is worth it to go build a model ourselves to make sure that we’re not in that position. I don’t want any of those other companies telling us what we can build. From an open source perspective, I think a lot of developers don’t want those companies telling them what they can build either. So the question is, what is the ecosystem that gets built out around that? What are interesting new things? How much does that improve our products? I think there are lots of cases where if this ends up being like our databases or caching systems or architecture, we’ll get valuable contributions from the community that will make our stuff better. Our app specific work that we do will then still be so differentiated that it won’t really matter. We’ll be able to do what we do. We’ll benefit and all the systems, ours and the communities’, will be better because it’s open source.

There is another analogy here, which is Google and Android; Bill Gurley wrote the definitive Android post in 2011 on his blog [Above the Crowd](https://abovethecrowd.com/2011/03/24/freight-train-that-is-android/):

> Android, as well as Chrome and Chrome OS for that matter, are not “products” in the classic business sense. They have no plan to become their own “economic castles.” Rather they are very expensive and very aggressive “moats,” funded by the height and magnitude of Google’s castle. Google’s aim is defensive not offensive. They are not trying to make a profit on Android or Chrome. They want to take any layer that lives between themselves and the consumer and make it free (or even less than free). Because these layers are basically software products with no variable costs, this is a very viable defensive strategy. In essence, they are not just building a moat; Google is also scorching the earth for 250 miles around the outside of the castle to ensure no one can approach it. And best I can tell, they are doing a damn good job of it.

The positive economic impact of Android (and Chrome) is massive: the company pays Apple around $20 billion a year for default placement on about 30% of worldwide smartphones (and Safari on Apple’s other platforms), which accounts for about 40% of the company’s overall spend on traffic acquisition costs across every other platform and browser. That total would almost certainly be much higher — if Google were even allowed to make a deal, which might not be the case if Microsoft controlled the rest of the market — absent Android and Chrome.

### Metaverse Motivations

Android is also a natural segue to this news about Horizon OS. Meta is, like Google before it, a horizontal services company funded by advertising, which means it is incentivized to serve everyone, and to have no one between itself and its customers. And so Meta is, like Google before it, spending a huge amount of money to build a contender for what Zuckerberg believes is a future platform. It’s also fair to note that Meta is spending a lot more than the $40 billion Google has put into Android, but I think it’s reasonable: the risk — and opportunity — for Meta in the metaverse is even higher than the risk Google perceived in smartphones.

Back in 2013, when Facebook was facing the reality that mobile was ending its dreams of being a platform in its own right, I wrote [Mobile Makes Facebook Just an App; That’s Great News](https://stratechery.com/2013/mobile-makes-facebook-just-an-app-thats-great-news/):

> First off, mobile apps own the entire (small) screen. You see nothing but the app that you are using at any one particular time. Secondly, mobile apps are just that: apps, not platforms. There is no need for Facebook to “reserve space” in their mobile apps for partners or other apps. That’s why my quote above is actually the bull case for Facebook.
> 
> Specifically, it’s better for an advertising business to not be a platform. There are certain roles and responsibilities a platform must bear with regards to the user experience, and many of these work against effective advertising. That’s why, for example, you don’t see any advertising in Android, despite the fact it’s built by the top advertising company in the world. A Facebook app owns the entire screen, and can use all of that screen for what benefits Facebook, and Facebook alone.

This optimism was certainly borne out by Facebook’s astronomical growth over the last decade, which has been almost entirely about exploiting this mobile advertising opportunity. It also, at first glance, calls into question the wisdom of building Horizon OS, given the platform advertising challenges I just detailed.

The reality, though, is that a headset is fundamentally different than a smartphone: the latter is something you hold in a hand, and which an app can monopolize; the former monopolizes your vision, reducing an app to a window. Consider this PR image of the Vision Pro:

[![Meta doesn't want to be just an app](https://proxy-prod.omnivore-image-cache.app/640x377,shODajRhex56vqV9AOchCKokfhg7YkU44nVMRLUsSkXk/https://i0.wp.com/stratechery.com/wp-content/uploads/2024/04/metaopen-1.png?resize=640%2C377&ssl=1)](https://www.apple.com/newsroom/2023/06/introducing-apple-vision-pro/)

This isn’t the only canvas for apps in the Vision Pro: apps can also take over the entire view and provide an immersive experience, and I can imagine that Meta will, when and if the Vision Pro gains meaningful marketshare, build just that; remember, Meta is a horizontal services company, and that means serving everyone. Ultimately, though, Zuckerberg sees the chief allure of the metaverse as being about presence, which means the sensation of feeling like you are in the same place as other people enjoying the same experiences and apps; that, by extension, means owning the layer within which apps live — it means owning your entire vision.

Just as importantly — probably most importantly, to Zuckerberg — owning the OS means not being subject to Apple’s dictate on what can or cannot be built, or tracked, or monetized. And, as Zuckerberg noted in that interview, Meta isn’t particularly keen to subject itself to Google, either. It might be tempting for Meta’s investors to dismiss these concerns, but [ATT should have focused minds](https://stratechery.com/2024/meta-earnings-meta-ai-and-att-metas-new-playbook/) about just how much this lack of control can cost.

Finally, not all devices will be platforms: Meta’s RayBan sunglasses, for example, could not be “just an app”; what they could be is that much better of a product [if Apple made public the same sort of private APIs it makes available to its own accessories](https://stratechery.com/2024/more-on-humane-limitless-the-iphone-integration-barrier/). Meta isn’t going to fix its smartphone challenges in that regard, but it is more motivation to do their own thing.

### Horizon OS

Motivations, of course, aren’t enough: unlike AI models, where Meta wants a competitive model, but will achieve its strategic goals as long as a closed model doesn’t win, the company does actually need to win in the metaverse by controlling the most devices (assuming, of course, that the metaverse actually becomes a thing).

The first thing to note is that pursuing an Apple-like fully-integrated model would actually be bad for Meta’s larger goals, which, as a horizontal services company, is reaching the maximum number of people possible; there is a reason that the iPhone, by far the most dominant integrated product ever, still only has about 30% marketshare worldwide. Indeed, I would pushback on Zuckerberg’s continued insistence that Apple “won” mobile: they certainly did as far as revenue and profits go, but the nature of their winning is not the sort of winning that Meta should aspire to; from a horizontal services company perspective, Android “won” because it has the most marketshare.

Second, the best route to achieving that marketshare is exactly what Meta announced: licensing their operating system to device manufacturers who are not only motivated to sell devices, but also provide the necessary R&D and disparate channels to develop headsets for a far wider array of customers and use cases.

Third, Meta does have the opportunity to actually accomplish what pundits were sure would befall the iPhone: monopolize developer time and attention. A big reason why pundits were wrong about the iPhone, back when they were sure that [it was doomed to disruption](https://stratechery.com/2013/clayton-christensen-got-wrong/), was that they misunderstood history. I wrote in 2013’s [The Truth About Windows Versus the Mac](https://stratechery.com/2013/apple-open-and-learning-from-history/):

> You’ve heard the phrase, “No one ever got fired for buying IBM.” That axiom in fact predates Microsoft or Apple, having originated during IBM’s System/360 heyday. But it had a powerful effect on the PC market. In the late 1970s and very early 1980s, a new breed of personal computers were appearing on the scene, including the Commodore, MITS Altair, Apple II, and more. Some employees were bringing them into the workplace, which major corporations found unacceptable, so IT departments asked IBM for something similar. After all, “No one ever got fired…”
> 
> IBM spun up a separate team in Florida to put together something they could sell IT departments. Pressed for time, the Florida team put together a minicomputer using mostly off-the shelf components; IBM’s RISC processors and the OS they had under development were technically superior, but Intel had a CISC processor for sale immediately, and a new company called Microsoft said their OS — DOS — could be ready in six months. For the sake of expediency, IBM decided to go with Intel and Microsoft.
> 
> The rest, as they say, is history. The demand from corporations for IBM PCs was overwhelming, and DOS — and applications written for it — became entrenched. By the time the Mac appeared in 1984, the die had long since been cast. Ultimately, it would take Microsoft a decade to approach the Mac’s ease-of-use, but Windows’ DOS underpinnings and associated application library meant the Microsoft position was secure regardless.
> 
> Evans is correct: the market today for mobile phones is completely different than the old market for PCs. And, so is Apple’s starting position; iOS was the first modern smartphone platform, and has always had the app advantage. Neither was the case in PCs. The Mac didn’t lose to Windows; it failed to challenge an already-entrenched DOS. The lessons that can be drawn are minimal.

The headset market is the opposite of the smartphone market: Meta has been at this for a while, and has a much larger developer base than Apple does, particularly in terms of games. It’s not overwhelming like Microsoft’s DOS advantage already was, to be sure, and I’m certainly not counting out Apple, but this also isn’t the smartphone era when Apple had a multi-year head start.

To that end, it’s notable that Meta isn’t just licensing Horizon OS, it is also opening up the allowable app model. From the [Oculus Developer blog](https://developer.oculus.com/blog/a-more-open-ecosystem-for-developers/):

> We’re also significantly changing the way we manage the Meta Horizon Store. We’re shifting our model from two independent surfaces, Store and App Lab, to a single, unified, open storefront. This shift will happen in stages, first by making many App Lab titles available in a dedicated section of the Store, which will expand the opportunity for those titles to reach their audiences. In the future, new titles submitted will go directly to the Store, and App Lab will no longer be a separate distribution channel. All titles will still need to meet basic technical, content, and privacy requirements to publish to the Store. Titles are reviewed at submission and may be re-reviewed as they scale to more people. Like App Lab today, all titles that meet these requirements will be published.

App Lab apps are a middle ground between side-loading (which Horizon OS supports) and normal app store distribution: developers get the benefit of an App Store (easy install, upgrades, etc.) without having to go through full App Review; clear a basic bar and your app will be published. This allows for more experimentation.

What it does not allow for is new business models: App Lab apps, if they monetize, still must use Horizon OS’s in-app payment system. To that end, I think that Meta should consider going even further, and offering up a truly open store: granted, this would reduce the long-run monetization potential of Horizon OS, but it seems to me like that would be an excellent problem to have, given it would mean there was a long-run to monetize in the first place.

### The Meaning of Open

This remaining limitation does get at the rather fuzzy meaning of “open”: in the case of Horizon OS, Meta means a licensing model for its OS and more freedom for developers relative to Apple; in the case of Llama Meta means open weights and making models into a commodity; in the case of data centers Meta means open specifications, and in the case of projects like React and PyTorch Meta means true open source code.

Meta, in other words, is not taking some sort of philosophical stand: rather, they are clear-eyed about what their market is (time and attention), and their core differentiation (horizontal services that capture more time and attention than anyone); everything that matters in pursuit of that market and maintenance of that differentiation is worth investing in, and if “openness” means that investment goes further or performs better or handicaps a competitor, then Meta will be open.

_I wrote a follow-up to this Article in [this Daily Update](https://stratechery.com/2024/does-vr-matter-modular-products-and-defining-new-markets-tiktok-acquirers/)._

---

_This Article is available as a video essay on [YouTube](https://www.youtube.com/watch?v=QJSSx3qymjM)_

---

Anniversaries are strange: no one but those involved have any reason to even know they exist, which makes them easy to skip; for example, last year I mostly ignored the [10 year anniversary of starting Stratechery](https://stratechery.com/2013/welcome-to-stratechery/) because I was more eager to write about [ChatGPT Getting a Computer](https://stratechery.com/2023/chatgpt-learns-computing/). That leaves today, April 16, as my last chance to mark a tin anniversary: ten years ago Stratechery [added a subscription option](https://stratechery.com/2014/welcome-stratechery-20/), making this my full-time job.

It was, for the record, a miserable day: I had a convoluted plan to offer different site experiences for subscribers and non-subscribers: the former would receive daily linked-list updates (a la [Daring Fireball](https://daringfireball.net/)) while the latter would still have access to longer-form Articles; I scrapped the concept [two days later](https://stratechery.com/2014/free-stratechery-daily-email/) in favor of simply sending subscribers a daily email, and so the paid newsletter model was born.

That accident of history ended up being why this anniversary is actually more meaningful to me: while I am most well-known for Stratechery, I am equally proud of the paid newsletter model — services like Substack [were based on Stratechery](https://pressgazette.co.uk/platforms/platform-profiles/substack-newsletter-platform/) — and gratified that so many writers are making a living connecting directly with readers.

Of course newsletters aren’t the only medium where this happens (and, in fact, I’ve never viewed Stratechery as a newsletter; it’s a blog that you can read via email); there are also podcasts (which [Stratechery has expanded into](https://stratechery.com/stratechery-plus/)) and YouTube (like and subscribe to the [Stratechery](https://www.youtube.com/@Stratechery) and [Sharp Tech](https://www.youtube.com/@SharpTechPodcast) channels!). The king of the latter, at least when it comes to tech, is Marques Brownlee, aka [MKBHD](https://twitter.com/mkbhd).

### The Humane AI Pin

Humane introduced the wearable AI Pin at [a TED Talk 11 months ago](https://www.youtube.com/watch?v=gMsQO5u7-NQ), painting the vision of a future without screens, powered by AI. I was, for the record, pretty skeptical: most new tech categories layer on top of what came before, as opposed to outright replacing them; Humane’s proposal of a wearable device that was completely independent of the phone in your pocket seemed unlikely to succeed. Still, I was cheering for them: I applaud any company trying to build something new, and AI provides the opening for new experimentation.

Unfortunately, last week the reviews of the AI Pin came out and they were universally terrible; The Verge’s headline summed up the sentiment: [Humane AI Pin review: not even close](https://www.theverge.com/24126502/humane-ai-pin-review). David Pierce wrote:

> I came into this review with two big questions about the AI Pin. The first is the big-picture one: is this thing… anything? In just shy of two weeks of testing, I’ve come to realize that there are, in fact, a lot of things for which my phone actually sucks. Often, all I want to do is check the time or write something down or text my wife, and I end up sucked in by TikTok or my email or whatever unwanted notification is sitting there on my screen. Plus, have you ever thought about how often your hands are occupied with groceries / clothes / leashes / children / steering wheels, and how annoying / unsafe it is to try to balance your phone at the same time? I’ve learned I do lots of things on my phone that I might like to do somewhere else. So, yeah, this is something. Maybe something big. AI models aren’t good enough to handle everything yet, but I’ve seen enough glimmers of what’s coming that I’m optimistic about the future.
> 
> That raises the second question: should you buy this thing? That one’s easy. Nope. Nuh-uh. No way. The AI Pin is an interesting idea that is so thoroughly unfinished and so totally broken in so many unacceptable ways that I can’t think of anyone to whom I’d recommend spending the $699 for the device and the $24 monthly subscription.

Brownlee agreed; he said at the start of his [YouTube review](https://www.youtube.com/watch?v=TitZV6k8zfA&t=18s):

> So this is the Humane AI Pin. It is a brand new product in a really interesting new form factor of an ultra-futuristic wearable computer. In a time of all these crazy gadgets and Vision Pro and wearable glasses, it’s so sick that we get so many genuinely new first generation products like this to give a shot.
> 
> Unfortunately it’s also the new worst product I think I’ve ever reviewed in its current state. There’s just so many things bad about it. It’s so bad, in fact, that I actually think it’s kind of distracting to understand what the point of the device is as we go through it, so I’m going to have to separate it out for this video. First, I’m going to tell you what it is and what it’s supposed to do, and then I’ll tell you what my experience has actually been using it.

Brownlee proceeded to do just that: he presented Humane’s vision, detailed how poorly it lived up to it (including the probably fatal flaw inherent in its decision to pretend smartphones don’t exist), and granted that future software updates might improve the experience. I thought it was a fair,

[1](#fn1-12783 "Actually, the deference Brownlee gave the vision and the potential of future upgrades was arguably generous") if brutal, review, but what had some people up in arms was the title and thumbnail:

I don’t tweet much these days — if you want one of my tips for lasting over a decade, that is one of them, for my own peace of mind more than anything — but Vassallo’s sentiment bothered me enough to fire off a response:

I honestly think I had this anniversary on my mind: I remember when I first started, with only a few hundred followers on Twitter, armed with nothing but my honest takes about tech; my only hope was that those takes would be original enough and valuable enough to build an audience. That they were didn’t diminish the desire to be honest; indeed, one of the biggest challenges creators face as they grow is retaining their edge even when they know people are actually paying attention to what they have to say.

### MKBHD’s Responsibility

The more interesting Vassallo tweet, though, and the one that inspired this Article, was this exchange in response to his original tweet:

Ignore the vaguely threatening “for now” ; Vassallo is touching on something profound about Brownlee, that I myself understand intimately: what the Internet has made uniquely possible is total loyalty to your customers, and that is threatening.

Let me start with myself: every dollar of income I have comes from my subscribers,

[2](#fn2-12783 "I previously spoke for pay, and even more previously offered consulting, and even more previously than that had ads; however, I ended ads in 2014, consulting in 2015, and haven’t accepted any paid speaking opportunities since 2017. This is all covered on <a href="https://stratechery.com/about/">my about page</a>.") all of whom pay the same price.

[3](#fn3-12783 "$12/month or $120/year for the last five years, increasing to $15/month and $150/year on April 22") If someone doesn’t like what I write, I make it easy to unsubscribe; if they accuse me of writing for favor or illegitimate profit I am happy to unsubscribe them myself, and refund their money. After all, to use Brownlee’s reponse to Vassallo:

My job is to make my subscribers happy, and the best way I’ve found to do that is to stay as true as I can to what I set out to do in the beginning: write things that are original and valuable. When I succeed I’m happy, and the numbers take care of themselves; when I publish something I’m not happy with, I have trouble sleeping. When tech companies or investors or anyone else is mad, I am free to not pay them any attention.

Brownlee, though, is, to Vassallo’s point, something else entirely: 18 million subscribers is an incredible number, even if only — “only” — 3.5 million people have viewed his Humane video. If Humane’s AI Pin wasn’t already dead in the water, it’s fair to say that [@levelsio](https://twitter.com/levelsio/status/1779842724771893524) is right:

Who, though, is to blame, and who benefited? Surely the responsibility for the Humane AI Pin lies with Humane; the people who benefited from Brownlee’s honesty were his viewers, the only people to whom Brownlee owes anything. To think of this review — or even just the title — as “distasteful” or “unethical” is to view Humane — a recognizable entity, to be sure — as of more worth than the 3.5 million individuals who watched Brownlee’s review.

This is one of the challenges of scale: Brownlee has so many viewers that it is almost easier to pretend like they are some unimportant blob. Brownlee, though, is successful because he remembers his job is not to go easy on individual companies, but to inform individual viewers who will make individual decisions about spending $700 on a product that doesn’t work. Thanks to the Internet he has absolutely no responsibility or incentive to do anything but that.

### Media and the Internet

While Stratechery mostly covers tech, I also spend a lot of time on media; in the early days of Stratechery, this mostly meant newspapers, and my argument was that was in fact a particularly useful angle on the impact of technology broadly: the fact that newspapers were text meant that they felt the impact of the Internet almost immediately, effects that would, as devices became more powerful and ubiquitous, and broadband faster and more reliable, impact everything. And, of course, Stratechery was a written product, so I had a stake in the game.

To that end, I wrote a series of Articles in the run-up to April 16, 2014, laying the groundwork for why I thought my subscription offering would work. The last of these was entitled [Newspapers Are Dead; Long Live Journalism](https://stratechery.com/2014/newspapers-are-dead-long-live-journalism/), where I wrote:

> Remember how the New York Times was started as [a means of making money](http://archive.org/stream/historyofnewyork00davi/historyofnewyork00davi%5Fdjvu.txt)? After the first year the paper had a circulation of 26,000 in a city of over half a million, but had incurred up-front capital costs of $50,000, and first-year expenses of $78,000 (In 1851 dollars; the modern equivalent would be $1.4 million and $2.2 million respectively). Compare that to this blog (which, by happy coincidence, turns [one year old](http://stratechery.com/2013/welcome-to-stratechery/) tomorrow, making this comparison timely): [FiveThirtyEight and the End of Average](http://stratechery.com/2014/fivethirtyeight-end-average/), the first article in this series, has been read by over 30,000 people; meanwhile, I’ve spent less than $2,000\. More readers, way less money.
> 
> You may consider the comparison unfair — an entire newsroom putting out a daily edition as compared to a solo blogger posting one Article — but _the unfairness is the point_. No one shared my article because it was from Stratechery, but then again, no one shares an article today just because it’s from the New York Times; all that matters is the individual article and its worth to the reader and potential sharer. As a writer, _this is amazing._ When it comes to reader attention, I am competing on an equal footing with The New York Freaking Times! Unfortunately for The New York Times, when it comes to making money they’re competing with Google and Facebook. Most distressingly, though, when it comes to costs, they’re competing with the last 150 years. Everything from printing presses to sales and marketing is deadweight if advertising is not a sustainable model.

The New York Times has, [to its immense credit](https://stratechery.com/2024/the-new-york-times-ai-opportunity/), figured out how to go direct to readers; most other newspapers have [struggled](https://stratechery.com/2017/the-local-news-business-model/): cost structures that were predicated on owning printing presses and delivery trucks simply don’t make sense in a world where [distribution is free](https://stratechery.com/2014/economic-power-age-abundance/).

Free distribution, meanwhile, made Stratechery possible: I just needed to write compelling content on my own website. Brownlee, meanwhile, got his free distribution from YouTube (and, to the extent you want to complain about his accurate but attention-grabbing headline, the realities of the YouTube algorithm, the one non-viewer incentive Brownlee needs to respond to, looms large). The key point is that he could do everything else on his own, starting with the webcam on his HP Pavilion laptop that he used to record [his first video](https://www.youtube.com/watch?v=9gk%5Frl3y%5FSU):

Today Brownlee has a [top-of-the-line studio](https://www.youtube.com/watch?v=jz%5FqFyTrS8w) and a staff, but the fundamental principle remains: in media one person can do it all, and build a thriving business that makes everyone from Humane to Apple care deeply about what he or she has to say — far more than they care about any traditional publication.

### AI and Intelligence

I mentioned at the beginning that last year I wrote about [ChatGPT Gets a Computer](https://stratechery.com/2023/chatgpt-learns-computing/) in lieu of an anniversary post; that Article, which was built around OpenAI’s announcement of (now-discontinued) ChatGPT plugins, was about the nature of the brain and how large learning models did or did not compare.

> Computers are deterministic: if circuit X is open, then the proposition represented by X is true; 1 plus 1 is always 2; clicking “back” on your browser will exit this page. There are, of course, a huge number of abstractions and massive amounts of logic between an individual transistor and any action we might take with a computer — and an effectively infinite number of places for bugs — but the appropriate mental model for a computer is that they do exactly what they are told (indeed, a bug is not the computer making a mistake, but rather a manifestation of the programmer telling the computer to do the wrong thing).
> 
> I’ve already mentioned Bing Chat and ChatGPT; on March 14 Anthropic released another AI assistant named Claude: while the announcement doesn’t say so explicitly, I assume the name is in honor of the aforementioned Claude Shannon. This is certainly a noble sentiment — Shannon’s contributions to information theory broadly extend far beyond what Dixon laid out above — but it also feels misplaced: while technically speaking everything an AI assistant is doing is ultimately composed of 1s and 0s, the manner in which they operate is emergent from their training, not proscribed, which leads to the experience feeling fundamentally different from logical computers — something nearly human — which takes us back to hallucinations; Sydney was interesting, but what about homework?

I added in [an August Update](https://stratechery.com/2023/chatgpt-enterprise-connectors-and-small-businesses-nvidia-competitors/):

> The point of that Article was that ChatGPT’s plugin architecture gave hallucinating creative LLMs access to determinative computers to ascertain truth, not dissimilar to the way a creative being like you or I might use a calculator to solve a math problem. In other words, the LLM is the interface to the source of truth, not the source of truth itself.
> 
> That is exactly what this “coming soon” feature is all about: you don’t make an LLM useful for your business by adding your business’s data to the LLM; that is simply a bit more text in a sea of it. Rather, you leverage the LLM as an interface to “computers” that deterministically give you the right answer. In this case, those computers will be “connecting the applications you already have”, which sounds to me an awful lot like enterprise-specific plug-ins.

The specifics of product implementations are not the point, but rather the distinction between a natural language interface based on probabilities and computers based on deterministic calculations; I think using the former to access the latter will remain one of the most important applications of large language models.

There is, though, one more piece: who actually tells the AI what to do, such that it needs access to a computer of its own? In _ChatGPT Gets a Computer_, which analogized large language models to Jeff Hawkins’ theory of the brain, I expressed hope that the beliefs he expressed about the nature of intelligence in [A Thousand Brains: A New Theory of Intelligence](https://www.numenta.com/resources/books/a-thousand-brains-by-jeff-hawkins/) extended to large language models. Hawkins writes:

> Intelligence is the ability of a system to learn a model of the world. However, the resulting model by itself is valueless, emotionless, and has no goals. Goals and values are provided by whatever system is using the model. It’s similar to how the explorers of the sixteenth through the twentieth centuries worked to create an accurate map of Earth. A ruthless military general might use the map to plan the best way to surround and murder an opposing army. A trader could use the exact same map to peacefully exchange goods. The map itself does not dictate these uses, nor does it impart any value to how it is used. It is just a map, neither murderous nor peaceful. Of course, maps vary in detail and in what they cover. Therefore, some maps might be better for war and others better for trade. But the desire to wage war or trade comes from the person using the map.
> 
> Similarly, the neocortex learns a model of the world, which by itself has no goals or values. The emotions that direct our behaviors are determined by the old brain. If one human’s old brain is aggressive, then it will use the model in the neocortex to better execute aggressive behavior. If another person’s old brain is benevolent, then it will use the model in the neocortex to better achieve its benevolent goals. As with maps, one person’s model of the world might be better suited for a particular set of aims, but the neocortex does not create the goals.

To the extent this is an analogy to AI, large language models are intelligent, but they do not have goals or values or drive. They are tools to be used by, well, anyone who is willing and able to take the initiative to use them.

### AI and the Sovereign Individual

I don’t think either Brownlee or I particularly need AI, or, to put it another way, are overly threatened by it. Yes, ChatGPT would have written several thousand words far more quickly than the hours it took me to write this Article, but I am (perhaps foolishly) confident that they would not be original and valuable enough to take away my audience; I think it’s the same for Brownlee.

The connection between us and AI, though, is precisely the fact that we haven’t needed it: the nature of media is such that we could already create text and video on our own, and take advantage of the Internet to — at least in the case of Brownlee — deliver finishing blows to $230 million startups.

How many industries, though, are not media, in that they still need a team to implement the vision of one person? How many apps or services are there that haven’t been built, not because one person can’t imagine them or create them in their mind, but because they haven’t had the resources or team or coordination capabilities to actually ship them?

This gets at the vector through which AI impacts the world above and beyond cost savings in customer support, or whatever other obvious low-hanging fruit there may be: as the ability of large language models to understand and execute complex commands — with deterministic computing as needed — increases, so too does the potential power of the sovereign individual telling AI what to do. The Internet removed the necessity — and inherent defensibility — of complex cost structures for media; AI has the potential to do the same for a far greater host of industries.

---

Brownlee’s 2nd most popular video is only two months old: it’s his [overview of the Apple Vision Pro](https://www.youtube.com/watch?v=dtp6b76pMak); it’s not, if fiction is our guide, an accident that Meta is developing the Quest and Apple has released the Vision Pro just as AI seems poised to threaten an ever-increasing number of jobs. This was the world painted by Pixar’s Wall-E:

[![Humans in Pixar's Wall-E](https://proxy-prod.omnivore-image-cache.app/640x268,slp4V3zFub6s7Rtxhz369aGwlIDD8GpJGM73ff9YIFEk/https://i0.wp.com/stratechery.com/wp-content/uploads/2024/04/mkbhd-2.png?resize=640%2C268&ssl=1)](https://www.pixar.com/feature-films/walle)

It’s funny, because before I looked up this photo, I could have sworn the humans in the film, lulled to insouciance by an AI that addressed all of their physical needs, were wearing headsets; I guess Pixar overestimated our ability to build space-faring cruise ships and underestimated the relentless progression of consumer electronics.

My suspicion, however, is that Pixar got it wrong, and this famous photo of Mark Zuckerberg at Mobile World Congress in 2016 is closer to the truth of the matter.

[![Mark Zuckerberg at Mobile World Congress](https://proxy-prod.omnivore-image-cache.app/640x426,sG8d6aPyeZ-43CoE3hWif2nN0gJl_p3-EGhKQVstBJAc/https://i0.wp.com/stratechery.com/wp-content/uploads/2024/04/mkbhd-1.png?resize=640%2C426&ssl=1)](https://www.facebook.com/photo/?fbid=10102665120179591&set=pcb.10102665126861201)

Wall-E erred by assuming that every human was the same, all gleefully enslaved by AUTO, the ship’s AI. In fact, though, I suspect humanity will be distributed bi-modally, with the vast majority of people happily wearing their Vision Pros or watching their streaming service or viewing their TikTok videos, while increasingly sovereign individuals, aided by AI, pilot the ship.

That may sound extreme, but again, this is why it is useful to look to media first: Brownlee — one man, who started out by reviewing a media center remote on his HP laptop — does in fact hold the fate of entire companies and products in his hand. My bet is not that AI replaces Brownlee, but that AI means Brownlee’s for everything, not just media.

As for me, I plan on documenting it every step of the way, thanks to every person who has supported Stratechery over the last 10 years, and to whom I alone owe accountability, and gratitude.

---

---

1. Actually, the deference Brownlee gave the vision and the potential of future upgrades was arguably generous [↩](#rf1-12783 "Return to footnote 1.")
2. I previously spoke for pay, and even more previously offered consulting, and even more previously than that had ads; however, I ended ads in 2014, consulting in 2015, and haven’t accepted any paid speaking opportunities since 2017\. This is all covered on [my about page](https://stratechery.com/about/). [↩](#rf2-12783 "Return to footnote 2.")
3. $12/month or $120/year for the last five years, increasing to $15/month and $150/year on April 22 [↩](#rf3-12783 "Return to footnote 3.")

_This Article is available as a video essay on [YouTube](https://youtu.be/3%5F5X5s30m-w?si=u6jZZxKARgsMWloJ)_

---

It was impossible to miss the leading message at [yesterday’s Google Cloud Next keynote](https://www.youtube.com/watch?v=V6DJYGn2SFk): Google has the best infrastructure for AI. This was CEO Sundar Pichai in his video greeting:

> I want to highlight just a few reasons Google Cloud is showing so much progress. One is our deep investments in AI. We’ve known for a while that AI would transform every industry and company, including our own. That’s why we’ve been building AI infrastructure for over a decade, including TPUs, now in their 5th generation. These advancements have helped customer train and serve cutting-edge language models. These investments put us in the forefront of the AI platform shift.

Google Cloud CEO Thomas Kurian made the priority clear as well:

> Today we’re going to focus on how Google is helping leading companies transform their operations and become digital and AI leaders, which is the new way to cloud. We have many important advances, starting with our infrastructure.

What was most interesting about the keynote, though, is what that infrastructure makes possible, and, by extension, what that says about Google’s ability to compete.

### Grounding

One of the most surprising things about large language models (LLMs) is how much they know; from the very beginning, though, hallucinations have been a concern. Hallucinations are, of course, part of what makes LLMs so impressive: a computer is actually being creative! It’s also a feature that isn’t particularly impressive to the enterprise customers that this keynote was directed at.

To that end, Kurian, shortly after going over Google’s infrastructure advantages, talked about “grounding”, both in terms of the company’s Gemini model broadly, and for enterprise use cases specifically in the context of Google’s Vertex AI model management service:

> To augment models, Vertex AI provides managed tooling to connect your model to enterprise applications and databases, using extensions and function-calling. Vertex also provides retrieval augmented generation (RAG) combining the strengths of retrieval and generative models to provide high quality personalized answers and recommendations. Vertex can augment models with up-to-date knowledge from the web and from your organization, combining generative AI with your enterprise truth.
> 
> Today we have a really important announcement: you can now ground with Google Search, perhaps the world’s most trusted source of factual information, with a deep understanding of the world’s knowledge. Grounding Gemini’s responses with Google Search improves response quality and significantly reduces hallucinations.
> 
> Second, we’re also making it easy to ground your models with data from your enterprise databases and applications, and any database anywhere. Once you’ve chosen the right model, tuned it, and connected it with your enterprise truth, Vertex’s MLOps can help you manage and monitor models.

A RAG implementation using Google Search is an obvious win, and mirrors ChatGPT’s integration with Bing (or Microsoft Copilot in Bing): the LLM provides answers when it can, and searches the web for things it doesn’t know, a particularly useful feature if you are looking for more recent information.

A more impressive demonstration of grounding, though, was in the context of integrating Gemini with Google’s [BigQuery data warehouse](https://cloud.google.com/bigquery) and [Looker business intelligence platform](https://cloud.google.com/looker):

In this demo, the worker gets an alert that a particular product is selling out; using generative AI the worker can see sales trends, find similar models, and create a plan of action for dealing with declining inventory for delivery to her team.

What is notable is not the demo specifics (which is unapologetically made-up for [Cymbal, Google’s demo brand](https://console.cloud.google.com/marketplace/product/cymbal/cymbal)); rather, note the role of the LLM: it is not providing information or taking specific actions, but rather serving as a much more accessible natural language interface to surface and collect data that would otherwise take considerably more expertise and time. In other words, it is trustworthy because it is grounded through integration Google is promising with its other enterprise data services.

### Gemini 1.5

At the same time, that last section didn’t really follow on from the introduction: yes, those LLMs leveraging Google or BigQuery are running on Google’s infrastructure, but [other companies](https://learn.microsoft.com/en-us/fabric/get-started/copilot-fabric-overview) or [startups](https://count.co/) can build something similar. This is where the rest of Pichai’s introduction comes in:

> We also continue to build capable AI models to make products like search, Maps, and Android radically more helpful. In December, we took our next big step with Gemini, our largest and most capable model yet. We’ve been bringing it to our products and to enterprises and developers through our APIs. We’ve already introduced our next generation Gemini 1.5 Pro. It’s been in private preview in Vertex AI. 1.5 Pro shows dramatically enhanced performance and includes a breakthrough in long context understanding. That means it can run 1 million tokens of information consistently, opening up new possibilities for enterprises to create, discover, and build using AI. There’s also Gemini’s multi-modal capabilities, which can process audio, video, text, code and more. With these two advances, enterprises can do things today that just weren’t possible with AI before.

Google hasn’t said how Gemini 1.5 was made, but clearly the company has overcome the key limitation of traditional transformers: memory requirements increase quadratically with context length. One promising approach is [Ring Attention with Blockwise Transformers](https://arxiv.org/abs/2310.01889), which breaks long contexts into pieces to be computed individually even as the various devices computing those pieces simultaneously communicate to make sense of the context as a whole; in this case memory requirements scale linearly with context length, and can be extended by simply adding more devices to the ring topology.

This is where Google’s infrastructure comes in: the company not only has a massive fleet of TPUs, but has also been developing those TPUs to run in parallel at every level of the stack, from chip to cluster to even data centers (this latter requirement is more pertinent for training than inference); if there is a solution that calls for scale, Google is the best placed to provide it, and it seems the company has done just that with Gemini 1.5.

### Demos

To that end, and per Pichai’s closing line, almost all of the other demos in the keynote were implicitly leveraging Gemini 1.5’s context window.

---

In a Gemini for Workspaces demo, the worker evaluated two statements of work against each other, and against the company’s compliance document:

Here are the key quotes:

> Google Drive is ready without any additional AI pre-work…
> 
> Each of these documents is over 70 pages. It would have taken me hours to review these docs, but instead Gemini is going to help me find a clean answer to save me a ton of time…
> 
> Before I proceed with this vendor, I need to ensure that no compliance issues exist, and I’m going to be honest, I have not memorized every rule in our compliance rulebook because it is over 100 pages. I would have to need to scour the 80 pages of this proposal and compare it manually with the 100 pages of the rulebook. So instead, in the side panel I ask, “Does this offer comply with the following” and I’m going to just @-mention our compliance rulebook, hit Enter, and see what Gemini has to say. So interesting: Gemini has found an issue, because the supplier has not listed their security certifications.
> 
> Because Gemini is grounded in my company’s data, with source citations to specific files, I can trust this response and start to troubleshoot before selecting a vendor.

The key distinction between this demo and the last one is that quote at the beginning: a large context window _just works_ in a far greater number of use cases, without any fiddly RAG implementations or special connections to external data stores; just upload the files you need to analyze, and you’re off.

---

In a Creative Agent with Imagen demo, the worker was seeking to create marketing images and storyboards for an outdoor product:

Here is the key quote:

> The creative agent can analyze our previous campaigns to understand our unique brand style and apply it to new ideas. In this case, the creative agent has analyzed over 3,000 brand images, descriptions, videos, and documents of other products that we have in our catalog, contained within Google Drive, to create this summary…The creative agent was able to use Gemini Pro’s 1 million token context window and its ability to reason across text, images, and video to generate this summary.

This was, to be fair, one of the weaker demos: the brand summary and marketing campaign weren’t _that_ impressive, and the idea of creating a podcast with synthetic voices is technically impressive and also something that will never be listened to. That, though, is impressive in its own right: as I noted in [an Update when Gemini 1.5 was first announced](https://stratechery.com/2024/groq-costs-gemini-pro-1-5-googles-timidity/), “a massively larger context window makes it possible to do silly stuff”, and silly stuff often turns into serious capabilities.

---

In a Gemini Code Assistant Demo (formerly Duet AI for Developers), a developer new to a job (and the codebase) was tasked with making a change to a site’s homepage:

Here is the key quote:

> For the developers out there, you know that this means we’re going to need to add padding in the homepage, modify some views, make sure the configs are changed for our microservices, and typically, it would take me a week or two to even just get familiarized with our company’s code base which has over 100,000 lines of code over 11 services. But now, with Gemini Code Assist, as a new engineer on the team, I can be more productive than ever and can accomplish all of this work in just a matter of minutes. This is because Gemini’s code transformations with full codebase awareness allows us to easily reason through our entire codebase, and in comparison, other models out there can’t handle anything beyond 12,000 to 15,000 lines of code. Gemini with Code Assist is so intelligent that we can just give it our business requirements, including the visual design…Gemini Code Assist doesn’t just suggest code edits; it provides clear recommendations, and makes sure that all of these recommendations align with \[the company’s\] security and compliance requirements…

And the conclusion:

> Let’s recap: behind the scenes Gemini has analyzed my entire codebase in GitLab; it has implemented a new feature; and has ensured that all of the code generated is compatible with my company’s standards and requirements.

Again, leave aside the implausibility of this demo: the key takeaway is the capabilities unlocked when the model is able to have all of the context around a problem while working; this is only possible with — and here the name is appropriate — a long _context_ window, and that is ultimately enabled by Google’s infrastructure.

### Google’s Nature

In case it isn’t clear, I think that this keynote was by far the most impressive presentation Google has made in the AI era, not least because the company knows exactly what its advantages are. Several years ago I wrote an Article called [Microsoft’s Monopoly Hangover](https://stratechery.com/2017/microsofts-monopoly-hangover/) that discussed the company’s then-ongoing transition away from Windows as the center of its strategy; the central conceit was a comparison to Lou Gerstner’s 1990’s transformation of IBM.

> The great thing about a monopoly is that a company can do anything, because there is no competition; the bad thing is that when the monopoly is finished the company is still capable of doing anything at a mediocre level, but nothing at a high one because it has become fat and lazy. To put it another way, for a former monopoly “big” is the only truly differentiated asset.

My argument was that business models could be changed: IBM did it, and Microsoft was in the process of doing so when I wrote that. Moreover, Gerstner had shown that culture could be changed as well, and [Nadella did just that at Microsoft](https://stratechery.com/2018/the-end-of-windows/). What couldn’t be changed was nature: IBM was a company predicated on breadth, not specialization; that’s why Gerstner was right to not break apart the company but to instead deliver Internet solutions to enterprises. Similarly, Microsoft was a company predicated on integration around Windows; the company’s shift to services centered on [Teams as Microsoft’s operating system in the cloud](https://stratechery.com/2020/the-slack-social-network/) was also true to the company’s nature.

Google is facing many of the same challenges after its decades long dominance of the open web: all of the products shown yesterday rely on a different business model than advertising, and to properly execute and deliver on them will require a cultural shift to supporting customers instead of tolerating them. What hasn’t changed — because it is the company’s nature, and thus cannot — is the reliance on scale and an overwhelming infrastructure advantage. That, more than anything, is what defines Google, and it was encouraging to see that so explicitly put forward as an advantage.

---

First, there is the moment when the news hits the wires: [U.S. Sues Apple, Alleges Tech Giant Exploits Illegal Monopoly](https://www.wsj.com/tech/apple-antitrust-lawsuit-16066694).

This, we know, is the beginning of a long journey: there will be months or years of filings and discovery and preliminary rulings; eventually we will have a trial, and months after that a decision. Then there are the appeals, first with three judges, then perhaps _en banc_, and maybe even the Supreme Court. At some point, should the government win, there will be a hearing about remedies, themselves subject to the same grinding schedule. Only then can a proper determination be made about the validity of the legal questions in this case.

Still, I think the initial moment matters: antitrust is inherently political, and tech companies are generally popular; this makes it hard to build and maintain the momentum necessary to endure the grind. One would certainly have expected that to be an advantage for Apple: the company gains power in market after market precisely by making consumers happy.

### Apple’s Integration

I explained in 2014 [How Apple Creates Leverage](https://stratechery.com/2014/apple-creates-leverage-future-apple-pay/) by marshaling loyal customers:

> Apple is certainly not shy about proclaiming their fealty towards building great products. And I believe Tim Cook, Jony Ive, and the rest of Apple’s leadership when they say their focus on the experience of using an Apple device comes from their desire to build something they themselves would want to use. But I also believe the strategic implications of this focus are serially undervalued.
> 
> Last year I wrote a piece called [What Clayton Christensen Got Wrong](http://stratechery.com/2013/clayton-christensen-got-wrong/) that explored the idea that the user experience was the sort of attribute that could never be overshot; as long as Apple provided a superior experience, they would always win the high-end subset of the consumer market that is willing to pay for nice things.
> 
> However, this telling of the story of iTunes and the iPhone suggests that this focus on the user experience not only defends against disruption, but it also provides an offensive advantage as well: namely, Apple increases its user experience advantage through the leverage it gains from consumers loyal to the company. In the case of iTunes, Apple was able to create the most seamless music acquisition process possible: the labels had no choice but to go along. Similarly, when it comes to smartphones, Apple devices from day one have not been cluttered with carrier branding or apps or control over updates. If carriers didn’t like Apple’s insistence on creating the best possible user experience, well, consumers who valued said experience were more than happy to take their business elsewhere. In effect, Apple builds incredible user experiences, which gains them loyal customers who collectively have massive market power, which Apple can then effectively wield to get its way — a way that involves maximizing the user experience. It’s a virtuous circle.

That Clayton Christensen reference was about his theory of low-end disruption, which I summarized in the aforementioned [What Clayton Christensen Got Wrong](https://stratechery.com/2013/clayton-christensen-got-wrong/):

> Briefly, an integrated approach wins at the beginning of a new market, because it produces a superior product that customers are willing to pay for. However, as a product category matures, even modular products become “good enough” — customers may know that the integrated product has superior features or specs, but they aren’t willing to pay more, and thus the low-priced providers, who build a product from parts with prices ground down by competition, come to own the market. Christensen was sure this would happen with the iPod, and he — and his many adherents — are sure it will happen to the iPhone.

That Article — where I argued that low end disruption would not happen to Apple — built on a paper I had written in business school in 2010 entitled [Apple and the Innovator’s Dilemma](https://stratechery.com/2010/apple-innovators-dilemma/):

> Steve Jobs, when asked why people want to work for Apple, [said](http://money.cnn.com/galleries/2008/fortune/0803/gallery.jobsqna.fortune/4.html):
> 
>> Our DNA is as a consumer company — for that individual customer who’s voting thumbs up or thumbs down. That’s who we think about. And we think that our job is to take responsibility for the complete user experience. And if it’s not up to par, it’s our fault, plain and simply.
> 
> This article has already laid out many of the strategic benefits of this intense focus on the user experience: it creates significant differentiation, sets customer expectations, and makes it impossible to overshoot customer needs — products are never “good enough” with regard to the user experience. From an organizational standpoint, if products are never “good enough”, then a highly integrated company is appropriate. Chrstensen and Raynor note in the Innovatorʼs Solution that the “not-good-enough circumstance mandate\[s\] interdependent product or value chain architectures and vertical integration.”
> 
> Another way to look at Appleʼs decisions regarding its organizational structure is to think of transaction costs: normally, in well-functioning markets, vertical integration is suboptimal. However, if transaction costs in the vertical chain outweigh the losses due to the inefficiencies of being vertically integrated, then vertical integration could be the correct course of action. Apple thinks the exact same way, but not about monetary cost; instead, the transaction costs they consider are the tax that modularization places on the user experience, and it is a cost they are not willing to bear. [A central tenet](https://web.archive.org/web/20090124163346/http://gowest.blogs.fortune.cnn.com:80/2009/01/22/the-cook-doctrine-at-apple/) is that Apple “need\[s\] to own and control the primary technologies behind the products \[it\] make\[s\].”

This is all a fancy way of repeating [Apple’s constant refrain](https://stratechery.com/2020/apples-shifting-differentiation/) that their success is built upon _integration_ — first hardware and software, then services, and now an entire ecosystem of products extending from the computer to the phone to smart watches to headphones and, most recently, [a headset](https://stratechery.com/2024/the-apple-vision-pro/). This integration makes customers happy, and one would expect members of the Apple ecosystem to rally to their cause.

In fact, though, that wasn’t the initial reaction, at least in the tech world which I inhabit: the response of many people was _finally._

### App Store Anger

The root of tech’s frustration with Apple — including long-time Apple developers, traditionally the company’s most ardent supporters — is the App Store. The App Store is the ultimate example of Apple leveraging consumers’ desire for their products to gain power over an ecosystem; in this case, though, the ecosystem isn’t music labels or cellular providers, but rather app developers, which is to say everyone else in tech. Smartphones are essential devices, and Apple makes the best smartphone, which means their power over developers is absolute.

Apple is not afraid to exercise this power, and it’s important to note that in the early days of the iPhone the company’s control worked in developers’ favor. Apple decreed that 3rd-party apps could only be installed via the App Store, which would review every app; free apps wouldn’t have to pay anything, while Apple would take 30% of paid apps. This led to an absolute explosion in the market: consumers, who had been scarred by the 2000’s era of malware and viruses, shook off their reticence to install software and embraced the App Store, leading to an explosion of app-based businesses. An important development was the 2009 addition of in-app purchase, which unlocked entirely new business models for games in particular. Subscriptions for publications came in 2011, although it took another five years for the business model to be available to all applications.

There was, throughout this period, a continuous burbling of discontent about some of Apple’s App Store policies: one of my early Articles on Stratechery in 2013 asked [Why Doesn’t Apple Enable Sustainable Businesses on the App Store?](https://stratechery.com/2013/why-doesnt-apple-enable-sustainable-businesses-on-the-app-store/), games developers groused about the 30% fee on in-app purchases, while 3rd-party content providers suffered under an anti-steering provision that didn’t allow them to link to their website — or even tell their users — that they could start a subscription or buy content outside of the app. Everyone, meanwhile, hated the seeming arbitrariness of App Store Review, which only weighed in on an app when it was finished; good luck building something ambitious with the ever-present risk of running afoul of App Store rules.

This discontent came to a head in 2020, when a number of developers had public confrontations with Apple. Some of these were COVID-related, as Apple wanted a piece of for-pay virtual meetings; others were due to an unannounced step-up in focus on subscription-based web apps. A [very public fight with Basecamp](https://stratechery.com/2020/xscale-and-arm-in-the-cloud-hey-versus-apple-apples-iap-campaign/) brought to light an organized campaign to force developers of all sizes to integrate in-app purchase even if they made all of their sales on their website:

That same month Apple announced App Tracking Transparency, a thinly veiled attempt [to displace Facebook’s role in customer acquisition for apps](https://stratechery.com/2020/apple-and-facebook/); some of the App Tracking Transparency changes had defensible privacy justifications ([albeit overstated](https://stratechery.com/2020/privacy-labels-and-lookalike-audiences/)), but it was hard to not notice [that Apple wasn’t holding itself to the same rules](https://stratechery.com/2022/data-and-definitions/), very much to its own benefit.

One year later and many developers cheered when Epic sued Apple for antitrust violations related to the App Store; I gave a list of relevant Articles a couple of months ago in [The Apple Vision Pros Missing Apps](https://stratechery.com/2024/the-apple-vision-pros-missing-apps/):

> * [Apple, Epic, and the App Store](https://stratechery.com/2020/apple-epic-and-the-app-store/), which provided a history of the App Store and Epic’s lawsuit at the time it was filed.
> * [App Store Arguments](https://stratechery.com/2021/app-store-arguments/), which I wrote at the conclusion of the trial, explained why I expected Epic to lose, even as I hoped that Apple would voluntarily make pro-developer changes in the App Store.
> * [The Apple v. Epic Decision](https://stratechery.com/2021/the-apple-v-epic-decision/), which reviewed the judge’s decision that favored Apple in 10 of the 11 counts.
> 
> The 11th count that Epic prevailed on required Apple to allow developers to steer users to a website to make a purchase; while its implementation was delayed while both parties [filed appeals](https://stratechery.com/2023/apple-epic-and-the-court-of-appeals-apples-federal-victory-epics-california-win/), the lawsuit reached the end of the road last week when the Supreme Court denied certiorari. That meant that Apple had to allow steering, and the company did so in the most restrictive way possible: developers had to use an Apple-granted entitlement to put a link on one screen of their app, and pay Apple 27% of any conversions that happened on the developer’s website within 7 days of clicking said link.
> 
> Many developers were outraged, but the company’s tactics were [exactly what I expected](https://stratechery.com/2024/the-supreme-court-declines-to-hear-apple-epic-apples-predictable-response/)…Apple has shown, again and again and again, that it is only going to give up App Store revenue kicking-and-screaming; indeed, the company has actually gone the other way, particularly with its crackdown over the last few years on apps that only sold subscriptions on the web (and didn’t include an in-app purchase as well). This is who Apple is, at least when it comes to the App Store.

Here is the most important thing to understand about this entire App Store discussion — the topic that has many people who are normally skeptical of government involvement in tech cheering on the Department of Justice: basically none of it is pertinent to this case. Oh sure, [the initial case filing](https://www.justice.gov/opa/media/1344546/dl?inline) aired all of these grievances — along with a bizarre and factually wrong assertion that iTunes was only ever on Windows because of a DOJ Consent Decree — but the actual assertions of wrongdoing barely mention the App Store at all.

### The DOJ’s Case

Steven Sinofsky has a (critical) overview of the case at [Hardcore Software](https://hardcoresoftware.learningbyshipping.com/p/216-united-states-v-apple-complaint); here is his (correct) summary of the DOJ’s actual complaints:

> There are two sets of claims in the filing. The first set are written as a narrative for laypeople. The claims are broad and kind of all over the map. Before listing the specifics there is a lot of language and froth about how Apple uses its place in the market. This is the “story.” It is very exciting to read but you have to get to the actual behavior, which the DOJ claims is that “Apple has used one or both mechanisms (control of app distribution or control of APIs) to suppress the following technologies, among others” which includes:
> 
> “Supressing Super apps”
> 
> “Supressing cloud streaming game apps”
> 
> “\[P\]rohibiting third-party apps from sending or receiving carrier-based messages”
> 
> “\[S\]uppressing key functions of third-party smartwatches”
> 
> “\[D\]enied users access to digital wallets”

The first two are the closest the case comes to App Store complaints, and the key thing to note is that they are not relevant to the vast majority of developers. There is nothing about Apple’s 30% fee, nothing about App Tracking Transparency, and nothing about the steering provision that is, in my estimation, the most noxious of all Apple’s policies. Here is an overview of the five objections:

**Super Apps**

> For years, Apple denied its users access to super apps because it viewed them as “fundamentally disruptive” to “existing app distribution and development paradigms” and ultimately Apple’s monopoly power. Apple feared super apps because it recognized that as they become popular, “demand for iPhone is reduced.” So, Apple used its control over app distribution and app creation to effectively prohibit developers from offering super apps instead of competing on the merits.
> 
> A super app is an app that can serve as a platform for smaller “mini” programs developed using programming languages such as HTML5 and JavaScript. By using programming languages standard in most web pages, mini programs are cross platform, meaning they work the same on any web browser and on any device. Developers can therefore write a single mini program that works whether users have an iPhone or another smartphone.
> 
> Super apps can provide significant benefits to users. For example, a super app that incorporates a multitude of mini programs might allow users to easily discover and access a wide variety of content and services without setting up and logging into multiple apps, not unlike how Netflix and Hulu allow users to find and watch thousands of movies and television shows in a single app. As one Apple executive put it, “who doesn’t want faster, easier to discover apps that do everything a full app does?” Restricting super apps makes users worse off and sacrifices the short-term profitability of iPhones for Apple.

As the DOJ complaint correctly notes, [Apple has faced challenges in China](https://stratechery.com/2017/apples-china-problem/) because of the WeChat “super app”; it is easier to switch if all of your essential services are in one place. At the same time, I am skeptical that “super apps” — even without Apple’s restrictions — would ever become a meaningful UI paradigm in western markets [long since defined by distinct apps](https://stratechery.com/2013/apps-people-jobs-to-be-done/).

Moreover, that installable apps are only available from Apple has always been a part of the iPhone’s brand promise: that is why it is important to remember the early days of the App Store and how it created consumer demand in the first place. This brand promise around security and safety will surely be a core part of Apple’s defense.

**Cloud Streaming Game Apps**

> For years, Apple blocked cloud gaming apps that would have given users access to desirable apps and content without needing to pay for expensive Apple hardware because this would threaten its monopoly power. In Apple’s own words, it feared a world where “all that matters is who has the cheapest hardware” and consumers could “buy\[\] a \[expletive\] Android for 25 bux at a garage sale and . . . have a solid cloud computing device” that “works fine.” Apple’s conduct made its own product worse because consumers missed out on apps and content. This conduct also cost Apple substantial revenues from third-party developers. At the same time, Apple also made other smartphones worse by stifling the growth of these cross-platform apps on other smartphones. Importantly, Apple prevented the emergence of technologies that could lower the price that consumers pay for iPhones.
> 
> Cloud streaming apps let users run a computationally intensive program without having to process or store the program on the smartphone itself. Instead, a user’s smartphone leverages the computing power of a remote server, which runs the program and streams the result back to the phone. Cloud streaming allows developers to bring cutting-edge technologies and services to smartphone consumers—including gaming and interactive artificial intelligence services—even if their smartphone includes hardware that is less powerful than an iPhone.

Apple long required that every individual cloud streaming game be an individual standalone app, and frankly, I think this is the DOJ’s strongest argument: cloud streaming apps don’t pose any of the (theoretical or not) security and safety concerns of apps installed outside of the App Store; the entire point is that you don’t need to install any apps at all, so to have such a requirement seems like a clear attempt to kill competition.

To that end, one gets the impression that [Apple’s January announcement](https://developer.apple.com/news/?id=f1v8pyay) that it would now allow cloud streaming services to be self-contained in a single app was a preemptive response to this filing; however, those single apps still have to include an in-app purchase option — you can’t simply offer an app that lets you sign in to the subscription you made elsewhere.

**SMS and Private APIs**

> Apple undermines cross-platform messaging to reinforce “obstacle\[s\] to iPhone families giving their kids Android phones.” Apple could have made a better cross-platform messaging experience itself by creating iMessage for Android but concluded that doing so “will hurt us more than help us.” Apple therefore continues to impede innovation in smartphone messaging, even though doing so sacrifices the profits Apple would earn from increasing the value of the iPhone to users, because it helps build and maintain its monopoly power.

This entire section is pretty nuts. The core complaint is that Apple doesn’t allow 3rd-party messaging apps like WhatsApp to access private API’s for SMS; the vast majority of the complaint, though, is effectively accusing Apple of acting anti-competitive by not building iMessage for Android, and making teenagers feel bad about green bubbles. Leaving aside the fact that green bubbles actually serve a product function — they are not encrypted, while blue iMessage bubbles are — the entire idea that Apple needs to proactively build features to facilitate communication with Android flies in the face of Supreme Court precedent in [Verizon v. Trinko](https://www.courtlistener.com/opinion/131153/verizon-communications-inc-v-law-offices-of-curtis-v-trinko-llp/):

> Firms may acquire monopoly power by establishing an infrastructure that renders them uniquely suited to serve their customers. Compelling such firms to share the source of their advantage is in some tension with the underlying purpose of antitrust law, since it may lessen the incentive for the monopolist, the rival, or both to invest in those economically beneficial facilities. Enforced sharing also requires antitrust courts to act as central planners, identifying the proper price, quantity, and other terms of dealing — a role for which they are ill-suited. Moreover, compelling negotiation between competitors may facilitate the supreme evil of antitrust: collusion. Thus, as a general matter, the Sherman Act “does not restrict the long recognized right of \[a\] trader or manufacturer engaged in an entirely private business, freely to exercise his own independent discretion as to parties with whom he will deal.”

I expect _Trinko_ to be a substantial obstacle for the DOJ in this case. It is one thing to change the rules or withdraw capabilities to maintain a monopoly; there was a Supreme Case called _Aspen Skiing_ where a company was found guilty of doing just that, but the Court drew a clear distinction in _Trinko_ between changes in policy and never actually providing pro-competition capability in the first place:

> _Aspen Skiing_ is at or near the outer boundary of §2 liability. The Court there found significance in the defendant’s decision to cease participation in a cooperative venture. The unilateral termination of a voluntary (and thus presumably profitable) course of dealing suggested a willingness to forsake short-term profits to achieve an anticompetitive end. Similarly, the defendant’s unwillingness to renew the ticket even if compensated at retail price revealed a distinctly anticompetitive bent.
> 
> The refusal to deal alleged in the present case does not fit within the limited exception recognized in _Aspen Skiing_. The complaint does not allege that Verizon voluntarily engaged in a course of dealing with its rivals, or would ever have done so absent statutory compulsion. Here, therefore, the defendant’s prior conduct sheds no light upon the motivation of its refusal to deal — upon whether its regulatory lapses were prompted not by competitive zeal but by anticompetitive malice.

This also hints at how a standard like RCS could be forced upon Apple: through legislation (statutory compulsion); passing new laws remains [the most appropriate way to deal with Aggregator power](https://stratechery.com/2019/a-framework-for-regulating-competition-on-the-internet/).

**Smartwatch Integration**

> Apple’s smartwatch — Apple Watch — is only compatible with the iPhone. So, if Apple can steer a user towards buying an Apple Watch, it becomes more costly for that user to purchase a different kind of smartphone because doing so requires the user to abandon their costly Apple Watch and purchase a new, Android-compatible smartwatch…
> 
> Apple uses its control of the iPhone, including its technical and contractual control of critical APIs, to degrade the functionality of third-party cross-platform smartwatches in at least three significant ways: First, Apple deprives iPhone users with third-party smartwatches of the ability to respond to notifications. Second, Apple inhibits third-party smartwatches from maintaining a reliable connection with the iPhone. And third, Apple undermines the performance of third-party smartwatches that connect directly with a cellular network. In doing so, Apple constrains user choice and crushes innovation that might help fill in the moat around Apple’s smartphone monopoly.

This is the part of the case that should concern Apple the most, because it is a direct attack on Apple’s core differentiation: the deep integration of software, hardware, and services across its devices. The Apple Watch has access to private APIs and system-level integrations that Apple claims provide for better battery life, messaging management, etc.; the DOJ says that these integrations should be modularized and made available to all smart watches. There is no consideration as to whether or not Apple’s claims are true, or acknowledgment that Apple’s integration was supposedly a losing proposition a decade ago: now that the company has been proven successful, said proposition is alleged to be monopoly maintenance.

**NFC Access for Digital Wallets**

> Apple recognizes that paying for products and services with a digital wallet will eventually become “something people do every day of their lives.” But Apple has used its control over app creation, including its technical and contractual control over API access, to effectively block third-party developers from creating digital wallets on the iPhone with tap-to-pay functionality, which is an important feature of a digital wallet for smartphones. As a result, Apple maintains complete control over how users make tap-to-pay payments with their iPhone. Apple also deprives users of the benefits and innovations third-party wallets would provide so that it can protect “Apple’s most important and successful business, iPhone.”

This is a valid complaint framed in a very odd way. I think there is a case to be made that Apple has reserved NFC tap-to-pay access for itself in order to leverage its iPhone control into control of an adjacent market (digital wallets), but I have a hard time buying the DOJ’s argument that this imposes unacceptable switching costs to another smartphone. It’s also, in my estimation, fairly weak gruel for an antitrust case of this magnitude, particularly given that an integrated wallet is, once again, very much in line with Apple’s longstanding brand promise.

### Apple’s Mistake

I have, for years, been urging Apple to take a different approach to the App Store, particularly in terms of non-gaming apps and the anti-steering provision, even if the company’s approach were technically legal. The danger I foresaw was not simply the loss of developer goodwill, but something even more important to Apple: its fundamental differentiation, i.e. integration. I stated the risk explicitly in 2021’s [Integrated Apple and App Store Risk](https://stratechery.com/2021/integrated-apple-and-app-store-risk/):

> If you were to boil Apple’s philosophy and attractiveness to customers to one word, that word would be “integration.” And guess what? First party integration is bad for third-party developers — everything is a tradeoff. This is where the nuance I discussed in _App Store Arguments_ becomes much more black-and-white. Yes, Apple created the iPhone and the App Store and, under current U.S. antitrust doctrine, almost certainly has the right to impose whatever taxes it wishes on third parties, including 30% on purchases and the first year of subscriptions, and completely cutting off developers from their customers. Antitrust law, though, while governed by Supreme Court precedent, is not a matter of constitutionality: it stems from laws passed by Congress, and it can be changed by new laws passed by Congress.
> 
> One of the central planks of many of those pushing for new laws in this area are significant limitations on the ability of platforms to offer apps and services, or integrate them in any way that advantages their offerings. In this potential world it’s not simply problematic that Apple charges Spotify 30%, or else forces the music streaming service to hope that users figure out how to subscribe on the web, even as Apple Music has a fully integrated sign-up flow and no 30% tax; it is also illegal to incorporate Apple Music into SharePlay or Shared-with-you or Photos, or in the most extreme versions of these proposed laws, even have Apple Music at all. This limitation would apply to basically every WWDC announcement: say good-bye to Quick Note or SharePlay-as-an-exclusive-service, or any number of Apple’s integrated offerings.
> 
> I think these sorts of limitations would be disappointing as a user — integration really does often lead to better outcomes sooner — and would be a disaster for Apple. The entire company’s differentiation is predicated on integration, including its ability to abuse its App Store position, and it would be a huge misstep if the inability to resist the latter imperiled the former.

Last week this danger manifested, not as new legislation, but as this lawsuit, which attacks Apple’s integration much more than it attacks the App Store. I think, though, that it was Apple’s policies around the App Store that created the conditions for this lawsuit in the first place.

In short, I suspect the DOJ doesn’t want to follow in Epic’s footsteps, but they do want to sue Apple, so they framed Apple’s defining characteristic — integration — in the most uncharitable light possible to make their case. To put it another way, the _Epic_ case may have shown that Apple’s policies around the App Store were (mostly) legal, but that didn’t mean they were right; now the DOJ, looking for another point of vulnerability, is trying to make the case that Apple’s right approach in delivering an integrated experience is in fact illegal.

During the Epic trial John Gruber [wished that Apple would relax its approach to the App Store](https://daringfireball.net/2021/06/app%5Fstore%5Fthe%5Fschiller%5Fcut):

> What’s weirdest about Apple’s antitrust and PR problems related to the App Store is that the App Store is a side hustle for Apple. Yes it’s earning Apple $10+ billion a year, and even for Apple that’s significant. But it’s not Apple’s main business by a long shot. To my knowledge no company in history has ever gotten into antitrust hot water over a side business so comparatively small to its overall business. Apple doesn’t need this.
> 
> I think Apple’s senior leadership — Cook in particular — truly does believe that Apple has earned every dollar it generates from third-party software in the App Store, and that their policies in place are just and fair. That righteousness came out on the stand in the Epic trial. But even if Apple’s executives are correct — if the current rules and revenue splits could somehow be proven to be dialed in to a hypothetical Platonic ideal of fairness to all parties involved — that doesn’t change the fact that so many developers see it otherwise.
> 
> I don’t think the developers are wrong, but even if they are wrong, it’s not good for Apple that they’re so unhappy, and feel so aggrieved. It’s not good for Apple that developers don’t see the App Store as a platform that works in their interests. Like the Apple logo, “developer goodwill” has no price tag.

To the extent I am right — and yes, it is impossible to prove a counterfactual — the price tag of Apple’s “side hustle” is even higher than Gruber thought: I believe that if Apple had done even the bare minimum with the App Store — i.e. removing the anti-steering provision and not going after small developers with online services — it wouldn’t be in a position of having to defend what actually makes Apple Apple. It would, at a minimum, have a lot more people on its side.

_I wrote a follow-up to this Article in [this Daily Update](https://stratechery.com/2024/apple-and-the-monopoly-question-iphone-market-share-apples-durability/)._

_This Article is available as a video essay on [YouTube](https://www.youtube.com/watch?v=U1ABzvPIdu4)_

---

From the [Wall Street Journal](https://www.wsj.com/tech/ai/nvidia-annual-conference-chips-7692760d):

> The Nvidia frenzy over artificial intelligence has come to this: Chief Executive Jensen Huang unveiled his company’s latest chips on Monday in a sports arena at an event one analyst dubbed the “AI Woodstock.”
> 
> Customers, partners and fans of the chip company descended on the SAP Center, the home of the National Hockey League’s San Jose Sharks, for Huang’s keynote speech at an annual Nvidia conference that, this year, has a seating capacity of about 11,000\. Professional wrestling’s WWE Monday Night RAW event took place there in February. Justin Timberlake is scheduled to play the arena in May. Even Apple’s much-watched launch events for the iPhone and iPad didn’t fill a venue this large. At the center of the tech world’s attention is Huang, who has gone from a semiconductor CEO with a devoted following among videogame enthusiasts to an AI impresario with broad-enough appeal to draw thousands to a corporate event.

Or, as Nvidia Research Manager Jim Fan [put it on X](https://twitter.com/DrJimFan/status/1769817948930072930):

I’m disappointed that the Wall Street Journal used this lead for their article about the event, but not because I thought they should have talked about the actual announcements: rather, they and I had the exact same idea. It was the spectacle, even more than the announcements, that was the most striking takeaway of [Huang’s keynote](https://www.youtube.com/watch?v=Y2F8yisiS6E).

I do think, contra the Wall Street Journal, that iPhone announcements are a relevant analogy; Apple could have, particularly in the early days of the iPhone, easily filled an 11,000 seat arena. Perhaps an even better analogy, though, was the release of Windows 95\. Lance Ulanoff wrote [a retrospective on Medium in 2001](https://onezero.medium.com/remembering-the-iconic-windows-95-launch-94cfcf215d50):

> It’s hard to imagine an operating system, by itself, garnering the kind of near-global attention the Windows 95 launch attracted in 1995\. Journalists arrived from around the world on August 24, 1995, settling on the lush green, and still relatively small Microsoft Campus in Redmond, Washington. There were tickets (I still have mine) featuring the original Windows Start Button (“Start” was a major theme for the entire event) granting admission to the invite-only, carnival-like event…It was a relatively happy and innocent time in technology. Perhaps the last major launch before the internet dominated everything, when a software platform, and not blog post or a piece of hardware, could change the world.

One can envision an article in 2040 looking back on the “relatively happy and innocent time in technology” as we witnessed “perhaps the last major launch before AI dominated everything” when a chip “could change the world”; perhaps retrospectives of the before times will be the last refuge of human authors like myself.

### GTCs of Old

What is interesting to a once-and-future old fogey like myself, who has watched multiple Huang keynotes, is how relatively focused this event was: yes, Huang talked about things like weather and robotics and Omniverse and cars, but this was, first-and-foremost, a chip launch — the Blackwell B200 generation of GPUs — with a huge chunk of the keynote talking about its various features and permutations, performance, partnerships, etc.

I thought this stood in marked contrast to [GTC 2022](https://www.youtube.com/watch?v=39ubNuxnrK8) when Huang announced the Hopper H100 generation of GPUs: that had a much shorter section on the chips/system architecture, accompanied by a lot of talk about potential use cases and a list of all of the various libraries Nvidia was developing for CUDA. This was normal for GTC, as I explained [a year earlier](https://stratechery.com/2021/nvidias-gtc-keynote-the-nvidia-stack-the-omniverse/):

> This was, frankly, a pretty overwhelming keynote; [Liberty thinks this is cool](https://www.libertyrpf.com/p/201-cloudflare-q3-highlights-microsoft):
> 
>> Robots and digital twins and games and machine learning accelerators and data-center-scale computing and cybersecurity and self-driving cars and computational biology and quantum computing and metaverse-building-tools and trillion-parameter AI models! Yes plz
> 
> Something Huang emphasized in the introduction to [the keynote](https://www.youtube.com/watch?v=jhDiaUL%5FRaM&t=781s), though, is that there is a rhyme and reason to this volume…

I then went on an extended explainer of CUDA and why it was essential to understanding Nvidia’s long-term opportunity, and concluded:

> This is a useful way to think about Nvidia’s stack: writing shaders is like writing assembly, as in its really hard and very few people can do it well. CUDA abstracted that away into a universal API that was much more generalized and approachable — it’s the operating system in this analogy. Just like with operating systems, though, it is useful to have libraries that reduce duplicative work amongst programmers, freeing them to focus on their own programs. So it is with CUDA and all of those SDKs that Huang referenced: those are libraries that make it much simpler to implement programs that run on Nvidia GPUs.
> 
> This is how it is that a single keynote can cover “Robots and digital twins and games and machine learning accelerators and data-center-scale computing and cybersecurity and self-driving cars and computational biology and quantum computing and metaverse-building-tools and trillion-parameter AI models”; most of those are new or updated libraries on top of CUDA, and the more that Nvidia makes, the more they can make.
> 
> ![](https://proxy-prod.omnivore-image-cache.app/640x343,sGFl9wWQiJZ-VI72UCRjlQ64kAfy5YVSFaULIXgFPHGQ/https://i0.wp.com/stratechery.com/wp-content/uploads/2021/11/nvidiagdc-4.png?resize=640%2C343&ssl=1)
> 
> This isn’t the only part of the Nvidia stack: the company has also invested in networking and infrastructure, both on the hardware and software level, that allows applications to scale across an entire data center, running on top of thousands of chips. This too requires a distinct software plane, which reinforces that the most important thing to understand about Nvidia is that it is not a hardware company, and not a software company: it is a company that integrates both.

Those GTCs were, in retrospect, put on by a company before it had achieved astronomical product-market fit. Sure, Huang and Nvidia knew about transformers and GPT models — Huang referenced [his hand-delivery of the first DGX supercomputer to OpenAI](https://finance.yahoo.com/news/jensen-huang-elon-musk-openai-182851783.html) in 2016 in yesterday’s opening remarks — but notice how his hand-drawn slide of computing history seems to exclude a lot of the stuff that used to be at GTC:

[![Huang's drawing of computing journey to today](https://proxy-prod.omnivore-image-cache.app/640x360,sOsenz-euGdYAHhtM-78WsGEr0HWmLhhO6wigOTvljg4/https://i0.wp.com/stratechery.com/wp-content/uploads/2024/03/gtc2024-1.png?resize=640%2C360&ssl=1)](https://www.youtube.com/watch?v=Y2F8yisiS6E)

Suddenly all that matters in those intervening years was transformers!

I am not, to be clear, short-changing Huang or Nvidia in any way; quite the opposite. What is absolutely correct is that Nvidia had on their hands a new way of computing, and the point of those previous GTC’s was to experiment and push the world to find use cases for it; today, in this post-ChatGPT world, the largest use case — generative AI — is abundantly clear, and the most important message for Huang to deliver is why Nvidia will continue to dominate that use case for the foreseeable future.

### Blackwell

So about Blackwell itself; from [Bloomberg](https://www.bloomberg.com/news/articles/2024-03-19/nvidia-s-nvda-blackwell-b200-chip-why-it-s-so-powerful-what-it-means-for-ai):

> Nvidia Corp. unveiled its most powerful chip architecture at the annual GPU Technology Conference, dubbed Woodstock for AI by some analysts. Chief Executive Officer Jensen Huang took the stage to show off the new Blackwell computing platform, headlined by the B200 chip, a 208-billion-transistor powerhouse that exceeds the performance of Nvidia’s already class-leading AI accelerators. The chip promises to extend Nvidia’s lead on rivals at a time when major businesses and even nations are making AI development a priority. After riding Blackwell’s predecessor, Hopper, to surpass a valuation of more than $2 trillion, Nvidia is setting high expectations with its latest product.

The first thing to note about Blackwell is that it is actually two dies fused into one chip, with what the company says is full coherence; what this means in practice is that a big portion of Blackwell’s gains relative to Hopper is that it is simply much bigger. Here is Huang holding a Hopper and Blackwell chip up for comparison:

[![Huang holding a Hopper GPU and a Blackwell GPU](https://proxy-prod.omnivore-image-cache.app/640x319,s0xQzshugptct9zMXjqveYksSxpco2IogNJikMK_i1y0/https://i0.wp.com/stratechery.com/wp-content/uploads/2024/03/gtc2024-2.png?resize=640%2C319&ssl=1)](https://www.youtube.com/watch?v=Y2F8yisiS6E)

The “Blackwell is bigger” theme holds for the systems Nvidia is building around it. The fully integrated GB200 platform has two Blackwell chips with one Grace CPU chip, as opposed to Hopper’s 1 to 1 architecture. Huang also unveiled the GB200 NVL72, a liquid-cooled rack sized system that included 72 GPUs interconnected with a new generation of NVLink, which [the company claims](https://nvidianews.nvidia.com/news/nvidia-blackwell-platform-arrives-to-power-a-new-era-of-computing) provides a 30x performance increase over the same number of H100 GPUs for LLM inference (thanks in part to dedicated hardware for transformer-based inference), with a 25x reduction in cost and energy consumption. One set of numbers I found notable were on these slides:

[![Blackwell's increased performance in training relative to Hopper](https://proxy-prod.omnivore-image-cache.app/640x431,sae-WyIz2wcnaUy_DL5C98sof4ld8z0kJxkDLEL_sxdk/https://i0.wp.com/stratechery.com/wp-content/uploads/2024/03/gtc2024-3.png?resize=640%2C431&ssl=1)](https://www.youtube.com/watch?v=Y2F8yisiS6E)

What is interesting to note is that both training runs take the same amount of time — 90 days. This is because the actual calculation speed is basically the same; this makes sense because Blackwell is, like Hopper, fabbed on TSMC’s 4nm process,

[1](#fn1-12539 "<a href="https://stratechery.com/2024/nvidia-earnings-inference-and-meta/">I was mistaken about this previously</a>") and the actual calculations are fairly serial in nature (and thus primarily governed by the underlying speed of the chip). “Accelerated computing”, though, isn’t about serial speed, but rather parallelism, and every new generation of chips, combined with new networking, enables ever greater amounts of efficient parallelism that keeps those GPUs full; that’s why the big improvment is in the number of GPUs necessary and thus the overall amount of power drawn.

That, by extension, means that a Hopper-sized fleet of Blackwell GPUs will be capable of building that much larger of a model, and given that there appears to be a linear relationship between scale and model capability, the path to GPT-6 and beyond remains clear (GPT-5 was presumably trained on Hopper GPUs; GPT-4 was trained on Ampere A100s).

What is interesting to note is that there are reports that while the B100 costs twice as much as the H100 to manufacture, Nvidia is increasing the price much less than expected; this explains [the somewhat lower margins the company is expecting going forward](https://stratechery.com/2024/nvidia-earnings-inference-and-meta/). The report — which has since disappeared from the Internet (perhaps because it was published before the keynote?) — speculated that Nvidia is concerned about preserving its market share in the face of AMD being aggressive in price, and its biggest customers trying to build their own chips. There is, needless to say, tremendous incentives to find alternatives, particularly for inference.

### Nvidia Inference Microservices (NIM)

I think this provides useful context for another GTC announcement; from the [Nvidia developer blog](https://developer.nvidia.com/blog/nvidia-nim-offers-optimized-inference-microservices-for-deploying-ai-models-at-scale/):

> The rise in generative AI adoption has been remarkable. Catalyzed by the launch of OpenAI’s ChatGPT in 2022, the new technology amassed over 100M users within months and drove a surge of development activities across almost every industry. By 2023, developers began POCs \[Proof of Concepts\] using APIs and open-source community models from Meta, Mistral, Stability, and more.
> 
> Entering 2024, organizations are shifting their focus to full-scale production deployments, which involve connecting AI models to existing enterprise infrastructure, optimizing system latency and throughput, logging, monitoring, and security, among others. This path to production is complex and time-consuming — it requires specialized skills, platforms, and processes, especially at scale.
> 
> NVIDIA NIM, part of NVIDIA AI Enterprise, provides a streamlined path for developing AI-powered enterprise applications and deploying AI models in production.
> 
> NIM is a set of optimized cloud-native microservices designed to shorten time-to-market and simplify deployment of generative AI models anywhere, across cloud, data center, and GPU-accelerated workstations. It expands the developer pool by abstracting away the complexities of AI model development and packaging for production ‌using industry-standard APIs.

NIM’s are pre-built containers that contain everything an organization needs to get started with model deployment, and they are addressing a real need not just today, but in the future; Huang laid out a compelling scenario where companies’ use multiple NIMs in an agent-type of framework to accomplish complex tasks:

> Think about what an AI API is: an AI API is an interface that you just talk to. So this is a piece of software that in the future that has a really simple API, and that API is called human. These packages, incredible bodies of software, will be optimized and packaged and we’ll put it on a website, and you can download it, you can take it with you, you can run it on any cloud, you can run it in your datacenter, you can run it on workstations if it fits, and all you have to do is come to ai.nvidia.com. We call it Nvidia Inference Microservices, but inside the company we all call it NIMs.
> 
> Just imagine, someday there’s going to be one of these chatbots, and these chatbots is just going to be in a NIM. You’ll assemble a whole bunch of chatbots, and that’s the way that software is going to be built some day. How do we build software in the future? It is unlikely that you’ll write it from scratch, or write a whole bunch of Python code or anything like that. It is very likely that you assemble a team of AIs.
> 
> There’s probably going to be a super-AI that you use that takes the mission that you give it and breaks it down into an execution plan. Some of that execution plan could be handed off to another NIM, that NIM would maybe understand SAP. The language of SAP is ABAP. It might understand ServiceNow and go and retrieve some information from their platforms. It might then hand that result to another NIM, who goes off and does some calculation on it. Maybe it’s an optimization software, a combinatorial optimization algorithm. Maybe it’s just some basic calculator. Maybe it’s pandas to do some numerical analysis on it. And then it comes back with its answer, and it gets combined with everybody else’s, and because it’s been presented with “This is what the right answer should look like,” it knows what right answers to produce, and it presents it to you. We can get a report every single day, top-of-the-hour, that has something to do with a build plan or some forecast or some customer alert or some bugs databased or whatever it happens to be, and we can assemble it using all these NIMs.
> 
> And because these NIMs have been packaged up and ready to work on your system, so long as you have Nvidia GPUs in your datacenter or in the cloud, these NIMs will work together as a team and do amazing things.

Did you notice the catch? NIMs — which Nvidia is going to both create itself and also spur the broader ecosystem to create, with the goal of making them freely available — will only run on Nvidia GPUs.

[![NIM's only run on Nvidia GPUs](https://proxy-prod.omnivore-image-cache.app/640x340,stDhpts6fExE9Nb1K8w2ITVvEqCjitib7CpLvaNRQYcw/https://i0.wp.com/stratechery.com/wp-content/uploads/2024/03/gtc2024-4.png?resize=640%2C340&ssl=1)](https://www.youtube.com/watch?v=Y2F8yisiS6E)

This takes this Article full circle: in the before-times, i.e. before the release of ChatGPT, Nvidia was building quite the (free) software moat around its GPUs; the challenge is that it wasn’t entirely clear who was going to use all of that software. Today, meanwhile, the use cases for those GPUs is very clear, and those use cases are happening at a much higher level than CUDA frameworks (i.e. on top of models); that, combined with the massive incentives towards finding cheaper alternatives to Nvidia, means both the pressure to and the possibility of escaping CUDA is higher than it has ever been (even if it is still distant for lower level work, particularly when it comes to training).

Nvidia has already started responding: I think that [one way to understand DGX Cloud](https://stratechery.com/2023/nvidia-gtc-dgx-cloud-nvidias-partners/) is that it is Nvidia’s attempt to capture the same market that is still buying Intel server chips in a world where AMD chips are better (because they already standardized on them); NIM’s are another attempt to build lock-in.

In the meantime, though, it remains noteworthy that Nvidia appears to not be taking as much margin with Blackwell as many may have expected; the question as to whether they will have to give back more in future generations will depend on not just their chips’ performance, but also on re-digging a software moat increasingly threatened by the very wave that made GTC such a spectacle.

---

---

1. [I was mistaken about this previously](https://stratechery.com/2024/nvidia-earnings-inference-and-meta/) [↩](#rf1-12539 "Return to footnote 1.")

## Posts navigation
