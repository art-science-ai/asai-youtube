## Colab journey
Prompt: Take a youtube playlist url as input and download transcripts from all videos in youtube playlist using youtube-transcript-api

Response
```python
# prompt: Take a youtube playlist url as input and download transcripts from all videos in youtube playlist using youtube-transcript-api

!pip install youtube-transcript-api
import youtube_transcript_api as ytt
import re

def get_playlist_transcripts(playlist_url):
  # Extract playlist ID from URL
  playlist_id = re.search(r'(?<=list=)(.*)', playlist_url).group(1)

  # Get playlist videos
  playlist_videos = ytt.get_videos_from_playlist(playlist_id)

  # Get transcripts for each video
  transcripts = []
  for video in playlist_videos:
    try:
      video_transcripts = ytt.get_transcript(video.video_id)
      transcripts.append(video_transcripts)
    except:
      # Skip videos with unavailable transcripts
      continue

  return transcripts
```

```
AttributeError: module 'youtube_transcript_api' has no attribute 'get_videos_from_playlist'
```

Explain error in colab

