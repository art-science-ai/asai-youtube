---
title: QS cost model
---

- NM Model
	 - Add session_cost from Grafana

	 - Add provisioning report from Hazem
		 - Consolidate INT, STAGE, PROD

	 - Total session_cost = total cost

- [[Anil Malkani]] model
	 - Session cost: avg session count per org * 0.5 (session time) gives total no of session server by cluster does not accout for batch session separately
		 - Downsampling: http://opentsdb.net/docs/build/html/user_guide/query/downsampling.html

		 - DONE Why downsample?  #QS-CG #Projects

	 - DONE Query count: how did we separate batch vs. interactive? Can we do the same for bytes read?  #QS-CG #Projects

	 - {DONE}} ApriilCogs2020: What's the difference between Column B and F? I understand B = total of grafana session_cost. It's coming from "Sheet1" but what is it?

- Grafana Observabilty
	 - Query Service Metrics Observability Dashboard: https://grafana-va7.prod.observability20.adobe.net/d/L5-gSVdWk/query-service-metrics-observability

	 - COGSDashboard: https://grafana-va7.prod.observability20.adobe.net/d/0ldz1ewWk/cogsdashbaord?orgId=11

- CosmosDB
	 - Viewer: https://aepviewerui.stage.cloud.adobe.io/subscriptions

	 - 

- Actual Azure spend
	 - DMAI: Provides total cost per subscription

	 - [Workspace cost centers](https://wiki.corp.adobe.com/display/DMSArchitecture/Workspace+Cost+Centers) > Workspace > Usage: Provides cost per workspace
		 - DONE Unable to change time period beyond 30d #Projects #QS-CG #Waiting #2020-W36 
