---
title: QS-CJA
---

- This page describes the interaction between Query Service (QS) and Customer Journey Analytics ([[CJA]])

- What are the use cases for which CJA customers will rely on QS?
	 - Data exploration: A quick way to explore data before importing into CJA.

	 - Data preparation: Prepare data before importing into CJA.

	 - Complex queries: Some queries are too complex for CJA (e.g. multi-level breakdowns and queries that require shuffle steps). QS is needed for such queries.

	 - Identity stitching: as an interim alternative to AEP UIS ([Identity Stitching: What It Is and What AW/P Needs from AEP](https://adobe.sharepoint.com/:w:/r/sites/CG-AEPDataAnalyticServices/_layouts/15/Doc.aspx?sourcedoc=%7BCCBE6558-CBAD-4B47-A8A5-9A79BC29DF3C%7D&file=Stitching%20Whitepaper.docx&action=default&mobileredirect=true)).

- What additional capabilities does QS need in order to support the use-cases?
	 - Adobe Defined Functions (ADFs) in QS need parity with CJA (especially sessionization and attribution). Results need to be as close as possible.

	 - Performance improvement for large customers.

	 - [[Composition views]]

- GTM
	 - Query Adhoc for CJA
		 - **Use cases: **Data exploration,  discovery, & analytics experimentation​

		 - **Concurrency **=1 user​

		 - **Timeout **= 10 mins​

		 - **Compute:** 3 flavors (S, M, L) of Query Adhoc Compute for the 3 CJA/CDP SKU offerings​

	 - Query Adhoc Add-on

	 - CJA

	 - Limits

	 - DONE How to attribute costs to CJA?Î
