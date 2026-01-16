---
title: Luma Demo Dashboard
---

- Old approach - recreating the data and ingesting
	 - DONE Step 1: Rename the datasets in source-datasets and dim-tables to match the names used in queries.
		 - source-datasets
			 - Dashboard - EE - IoT.csv (luma_basics_iot_interaction_events_api)

			 - Dashboard - EE - Mobile App1.csv (luma_basics_mobile_interaction_events_api)

			 - Dashboard - EE - Mobile App2.csv

			 - Dashboard - EE - POS.csv (luma_basics_pos_transaction_events_api)

			 - Dashboard - EE - Website - 1.csv (luma_basics_web_interaction_events_api)

			 - Dashboard - EE - Website - 2.csv

			 - Dashboard - Profiles.csv (luma_basics_profile_data_api)

		 - dim-tables
			 - CustomGeo.csv

			 - device_type.csv

			 - dim_ChannelData.csv (aep_demo_dim_channel)

			 - dim_Products.csv

			 - dim_call_details.csv

			 - dim_sourceData.csv	

			 - dim_store.csv	

			 - dim_uniqueGeo.csv (aep_dim_unique_geocodes)

			 - event_type.csv (aep_dim_eventtype)

			 - gender.csv (aep_dim_gender)

			 - loyalty.csv (aep_dim_loyalty)

		 - Datasets missing
			 - luma_custom_call_center_interaction_events_api ?

	 - DONE Ingestion
		 - Error ingesting Dashboard - EE - POS.csv
			 - ![](https://firebasestorage.googleapis.com/v0/b/firescript-577a2.appspot.com/o/imgs%2Fapp%2Fnikhil-maddirala%2FWwuxQ3mc6p.png?alt=media&token=1ed828c9-d7ca-4283-a996-cc3015ab2046)

- Issues
	 - Dashboard is not beautiful

	 - Tableau - AEP connection keeps breaking whenever new queries are executed.

	 - Takes a long time to execute queries
