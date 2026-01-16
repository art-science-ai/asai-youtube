---
title: IDS Hadoop
---

- Jupyter for Presto: https://wiki.corp.adobe.com/display/IDS/JupyterHub+Presto

- https://stackoverflow.com/questions/21370431/how-to-access-hive-via-python/41028541

- 

- Settings from Steven
	 - 
```sql
set mapreduce.map.memory.mb=20480;
set mapreduce.reduce.java.opts=16384;
set mapreduce.map.java.opts=-Xmx16g;
set mapreduce.reduce.java.opts=-Xmx20g;
```

- Settings from Avinash Epuri (Service Now ticket)
	 - 
```sql
set mapred.min.split.size.per.node=536870912;
set mapred.min.split.size.per.rack=536870912;
set mapred.min.split.size=536870912;
set mapred.max.split.size=536870912;
```
