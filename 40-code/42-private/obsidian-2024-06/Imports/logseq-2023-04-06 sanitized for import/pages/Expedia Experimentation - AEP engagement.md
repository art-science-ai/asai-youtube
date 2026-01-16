---
title: Expedia Experimentation - AEP engagement
---

- Mixpanel
	 - About MixPanel
		 - MixPanel is a self-serve analytics tool that is purpose built for the product manager persona to enable product analytics.

		 - MixPanel returns most user-level query results within seconds.

		 - Expedia sends 1-2 billion events per day to Mixpanel. They demo'd a query on about two weeks of data (~14 billion events) and it returns in <10 sec.

	 - MixPanel's advantages: Superior Query Performance
		 - MixPanel is able to optimize query performance through a combination of (1) custom query language, and (2) optimized data layout.

		 - Custom query language: MixPanel uses their own proprietary query language called JavaScript Query Language (JQL)

		 - Optimized data layout: MixPanel's data layout is optimized for user based querying rather than event based querying. It is similar to AEP's Profile Export. 

	 - MixPanel's disadvantages
		 - Complex and proprietary query language: Users need to invest time in learning JQL. But SQL is more widely used.

		 - Limited capabilities: MixPanel is just a point solution for product analytics; does not have additional capabilities for Data Science, Trust, etc.

	 - How can AEP optimize query performance for Expedia?
		 - **Computed attributes**: ... 

		 - **Profile Exports**: ...

	 - Ref
		 - [MixPanel Architecture White Paper](https://mixpanel.com/wp-content/uploads/2018/06/System-architecture_June2018.pdf)

		 - [BlueJeans discussion with Rohit Gossain on MixPanel](https://bluejeans.com/s/@6jMNmNSgRz/)
