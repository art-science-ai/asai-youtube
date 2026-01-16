---
title: AEP Insights
---

- SQL exploration
	 - Highlights
		 - Use **interactive SQL queries to explore and experiment** with stitched omni-channel data (or raw data) inside Adobe Experience Platform​.

		 - Provides **purpose-built functions** to support marketing use cases including pathing and attribution.​

	 - Key benefits
		 - **Reduced time to insights** for quick exploration and experimentation

		 - Customers can **preview and validate AEP Insights** capabilities before operationalization. 

	 - Note
		 - GTM: Bundled with CJA and CDP SKUs

	 - Archive

- SQL Prep
	 - Scheduled SQL queries
		 - Use **UI or API to run scheduled batch SQL queries** on stitched omni-channel data (or raw data) inside Adobe Experience Platform​. Use cases include filtering, data format translations, metadata lookups, etc.​

	 - Integrated trust, privacy, and governance
		 - **Seamless propagation of usage labels**, data usage policies, and privacy policies to all of your datasets to ensure trust, privacy, and governance.  

	 - Seamless egress to destinations
		 - Seamlessly **egress data to the destination of your choice** within Adobe (Customer Journey Analytics, Data Science Workspace, Experience Dashboards) or outside Adobe (Cloud Data Lakes, Azure Blob, Amazon S3, etc.).

	 - Diagram
		 - To
			 - Enterprise sy

	 - Archive
		 - Leverage PostgreSQL client applications to execute custom SQL queries on Experience Platform datasets​

		 - Prepare and validate data for CJA, DSW, reporting, and enterprise sync

- Roadmap
	 - Ad-hoc SQL for Data Exploration
		 - ADF Parity with CJA: Parity with Customer Journey Analytics (CJA) for Adobe Defined Functions (ADFs) such as sessionization, attribution, etc.

		 - Materialized composition views: Enable users to run queries on CJA's materialized composition views inside AEP.

		 - Auto-scaling queries: Improve query performance for customers with large volumes of data.

		 - Query recommendations: Notify users that their queries may time out by leveraging statistics from Iceberg.

	 - Batch SQL for Data Preparation
		 - UI for query scheduling: Interactive user-friendly interface for query scheduling.

		 - Trust and governance: Propagation of usage labels, data usage policies, and privacy policies for CTAS queries. 

		 - Query orchestration: UI, monitoring, and lifecycle management for conditional and/or chained queries. 

		 - Event triggered scheduling: Schedule queries based on event triggers (e.g. dataset ingestion) rather than time.​

	 - SQL core (common)​
		 - Usage metering​ and limits: Monitor session and query usage.

		 - Query optimization: Leverage data and AI to optimize individual queries for cost optimization and performance improvement.

		 - Queue and priority management​: Prioritize queries based on cost, time, and importance.
