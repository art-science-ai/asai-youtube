---
title: iOS AOpen bugs
---

- Double counted events
	 - Workflow:Dynamic View:Tap Auto Open Once

	 - Workflow:Dynamic View:Tap Auto Open Always

	 - Workflow:Dynamic View:Enter Dynamic View icon tap with auto open promo message showing

	 - Workflow:Dynamic View:Invoked Auto Open

- Failure events
	 - Workflow:Dynamic View:OnDevice:Canceled conversion by hitting cancel:Upfront

	 - Workflow:Dynamic View:OnDevice:AfterTap:Update1 Failed-UserMsg

	 - Workflow:Dynamic View:OnDevice:AfterTap:Update1 IPDQ-UserMsg

	 - Workflow:Dynamic View:OnDevice:AfterTap:Update1 IPDQ-Pipeline

	 - PDFViewer:Document Closed

	 - Workflow:Dynamic View:OnDevice:BeforeTap:Update1 IPDQ

	 - Viewer:Context Board:Open Context Board 

	 - 

- Questionable events
	 - Workflow:Dynamic View:Stream:DV disabled - this event keeps occuring after AOpen

	 - 2625310556641177137:496843209489423754:19:1626345337
		 - Workflow:Dynamic View:Auto-Open Not Supported - occuring after invocation

	 - Session 1891678668475704092:3116154525518370845:19:1626390021
		 - Workflow:Dynamic View:Clear Sticky eVars - occurs 36 times in a row

	 - Session 2002340635458446060:1892196779279078291:74:1626346456 
		 - Viewer:Context Board:Open Context Board  what happened?

	 - Session 2326111203191357352:8842280097435358279:1599:1626340912
		 - Why is cohort assigned so many times?

	 - 

- Other questions
	 - Why are the events getting batched together?

	 - Why is auto open invoked when we have before tap IPDQ?
