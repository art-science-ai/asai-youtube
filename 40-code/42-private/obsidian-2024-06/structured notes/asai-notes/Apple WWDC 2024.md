# 1 Podcast  
## 1.1 Screen share
- iPad calculator: https://youtu.be/qkYoBNdcXBU?si=uZeaf_8rw1XnkBbh&t=490
- Apple Intelligence architecture: https://www.threads.net/@cspenn/post/C8IljVVuXO9
- Zuck on closed AI: https://youtu.be/bc6uFV9CJGg?si=BRG0fVdrXEOv_x0m&t=4098

## 1.2 What did apple announce?
Let's summarize all the AI stuff Apple announced. Apple structured their keynote differently
- AI in Apple Apps
	- Calculator app on iPad: Handwriting recognition and math
	- Mail app: proofread and rewrite emails, categorize emails
	- Photos app: clean up images (remove people in background)
	- Safari app: Highlights of website
	- Image playground in Apple apps for image creation and emoji creation
	- Many more!
- AI in Siri - AI assistant that works across multiple apps
	- Example: “Send the photos from the barbecue on Saturday to Malia,”
	- Example: “Play that podcast that Jamie recommended,”
	- Example: “When is Mom’s flight landing?” and Siri will find the flight details and cross-reference them with real-time flight tracking to give an arrival time.
- Third party apps integration
	- Previous examples work with Apple apps, but what about third party apps?
	- "When is Mom's flight landing?" Whatsapp / Gmail / etc.?

## 1.3 Apple Intelligence deep dive and privacy considerations (debunking Elon's meme)
Architecture
- What's the key problem with ai assistants right now? It doesn't have access to all the data and context you need it to have. Apple just solved this problem.
- RAG solution 
- Why was RAG difficult to implement? Your data is in many places! Only apple has personal knowledge access. But others can't get this access. 

- Three tiers
	- On device compute 
	- Apple Private cloud compute
	- Third party cloud compute - OpenAI
- Is Elon musk right?
	- 80% on-device vs. 20% off-device
	- Off-device: 80% Apple Cloud vs. 20% third-party cloud
	- Requests going to third party cloud = 0.2 * 0.2 =  4%
- How to determine?
	- Spotlight api for RAG. Context size determines on device vs private cloud. 
- Why this approach?
	- De-risk OpenAI reliance
	- Commodification of models  


## 1.4 Implications for ecosystem
For end users, this is great step forward, and might be a key turning point in AI's iPhone moment. For almost everyone else in the AI ecosystem, this is probably really bad news.

There are multiple layers at which AI can exist:
1. Stand-alone general purpose AI: ChatGPT, Claude, etc.
2. AI integrated into applications: Notion AI, Gmail AI, Adobe Acrobat AI, etc.
3. AI assistant integrated into your entire workflow: Rabbit, Humane, Adept, etc.

- AI assistants are dead
	- Apple ai is the best ai assistant and it's unfair 
	- Apple intelligence is the real LAM that rabbit couldn't deliver. Rabbit and humane could not deliver because of Apple's gatekeep. Show video of rabbit. 
- OS owners will control AI assistants: Apple, Google, Microsoft
	- Compare to Microsoft copilot pc recall
- Commodification of models
	- Apple clearly has the upper hand over OpenAI in this relationship
	- Integration with other model providers in addition to Openai.
- Commodification of apps
	- 3p devs. Wants to own the interface users. Think Netflix not adopting Apple tv. Think apple car play taking over UI. Tesla doesn't allow it. Apple is commodotizing everything else. 
	- UI of app is diminished. Eg. Whatsapp and Gmail likely not to integrate. They don't have a chance to offer their own AI. 
- 



# 2 Diagrams
### 2.1.1 Previous flow - by me
![[Apple WWDC 2024 2024-06-12 10.09.43.excalidraw]]


### 2.1.2 New flow - from threads
https://www.threads.net/@cspenn/post/C8IljVVuXO9

![[Apple WWDC 2024-1718387959496.jpeg]]



# 3 Raw notes from keynote
- Vision OS
- iOS 18 new features
	- Control center customizations
	- Share sheet updates
	- Locking and hiding apps
	- SMS improvements - text effects, schedule send
	- Tap to cash - p2p payments
	- Mail on-device categorization AI
- Airpods
	- Nod to say yes or no to Siri
- Watch
	- Training effort rating
	- Vitals - top health metrics
- iPad 
	- Calculator
	- Handwriting - on device ML
- MacOS
	- Auto snapping window grids
	- Passwords app - competitor to 1Password
	- Safari Highlights - AI
- Apple Intelligence
	- Prioritize notifications
	- Email writing - in mail app
	- System wide writing tools
	- Image creation - in Apple Apps
	- Personal context understanding from Apple Apps - Maps, Contacts
	- On device compute or private cloud compute
	- Siri + ChatGPT
