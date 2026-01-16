- `yt-dlp -F "VIDEO_URL"`
	- List all formats
- Best Video: `yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" -o "%(title)s.%(ext)s" "VIDEO_URL"`
	- Best video in MP4 + best audio in M4A
	- If separate streams are not available, fall back to the best available MP4 format.
	- If no MP4 is available, it will choose the best format of any type.
- Best audio: `yt-dlp -f bestaudio --extract-audio --audio-format m4a --audio-quality 0 "URL"`
	- -f bestaudio: Selects the best available audio format
	- extract-audio: Extracts the audio from the video
	- audio-format m4a: Specifies m4a as the output audio format
	- audio-quality 0: Sets the audio quality to the highest available
- Playlist
	- `yt-dlp "PLAYLIST_URL"`
	- `yt-dlp -x --audio-format mp3 "PLAYLIST_URL"`
	- `yt-dlp -f bestaudio -x --audio-format mp3 --audio-quality 0 "PLAYLIST_URL"`
	- 

Scratchpad
```txt
yt-dlp -f bestaudio --extract-audio --audio-format m4a --audio-quality 0 "https://www.youtube.com/watch?v=udOvf8LqLYg"
```

