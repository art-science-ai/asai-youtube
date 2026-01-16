**TLDR**
Content consumption analyzer that imports my personal content consumption from sources such as Youtube, Spotify (podcasts), Kindle (ebooks), Libby (audiobooks), etc. and then analyzes and provides recommendations.

**Requirements**
- Data sources: Youtube, Spotify (podcasts), Kindle (ebooks), Audible (audiobooks), browser history (articles), etc. We need to evaluate the various data export / data portability API options offered by those platforms as well as third parties.
- Data pipeline
	- A periodically running data ingestion pipeline starting  with an initial run to get historical data, as well as an incremental run that can be run every day or every week to get new data
	- Code in python, execute as Github Action
- Data storage
	- Each individual piece of content should be stored as an individual markdown file with metadata as YAML frontmatter.
	- I will also use this as an Obsidian vault.
	- We need to define the YAML properties for various page types such as: YouTube channel, YouTube video, YouTube creator, etc. 
- Data analysis
	- Write Obsidian data-view queries to visualize some of the data