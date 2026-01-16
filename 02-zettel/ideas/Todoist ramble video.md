# How to integrate AI into your product UI
Here's a great example of how to integrate an AI natural language interface into an existing native UI: **Todoist Ramble**

Many AI products today simply "bolt-on" a chatbot UI that is disconnected from the product UI. Instead, Todoist integrates AI into the native product UI and workflows that the user is already familiar with. This makes it easier to trust that the AI is actually doing what you want it to do.

- Interface
	- ✅ AI chat directly updates the product UI in real-time
	- ❌ AI chat lives in a separate UI, disconnected from product UI
- Workflow
	- ✅ Integrated into existing product workflow
	- ❌ AI creates a parallel workflow
- Transparency
	- ✅ AI is transparently making clear verifiable changes
	- ❌ AI is a black-box and you don't believe it when it says "I did XYZ"

Source: https://www.youtube.com/watch?v=A-dnwDREZQI




# Extracting clip

download video
```bash
yt-dlp -f "bv*[height<=1080]+ba/b" "https://www.youtube.com/watch?v=A-dnwDREZQI" --merge-output-format mp4 --write-subs --write-auto-subs --sub-langs "en.*,en" --convert-subs srt -o "video.%(ext)s"
```

cut + subs
```bash
ffmpeg -i "video.mp4" -ss "00:00:35.000" -to "00:01:25.000" -vf "subtitles='video.en.cleaned.srt':force_style='FontName=Arial,FontSize=20,Outline=2,BorderStyle=1,OutlineColour=&H80000000&'" -c:v libx264 -preset medium -crf 18 -c:a aac -b:a 160k "clip_burned.mp4"
```

clean subtitles - avoid duplication
```bash
awk 'function ms(t){split(t,a,":");split(a[3],b,",");return ((a[1]*3600+a[2]*60+b[1])*1000+b[2])} BEGIN{RS="";ORS="\n\n"} {blk=$0; sub(/^[0-9]+\n/,"",blk); match(blk,/([0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3}) --> ([0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3})/); s=substr(blk,RSTART,RLENGTH); split(s,a," --> "); st=a[1]; en=a[2]; d=ms(en)-ms(st); txt=blk; sub(/.*\n.*\n/,"",txt); gsub(/\n+$/,"",txt); if(d<200) next; if(txt==lasttxt && (ms(st)-lastend)<500) next; ++i; print i"\n"st" --> "en"\n"txt; lasttxt=txt; lastend=ms(en)}' video.en.srt > video.en.cleaned.srt
```