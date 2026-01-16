# Public instructions
Message to users
```
Instructions: https://bit.ly/nm-media

Username: manash316@gmail.com

Password: changeme
```


- About
	- This document contains information for accessing Nikhil's personal media server. Please do not share this information with anybody else.
	- Please understand that not everything works perfectly. Don't treat this as your primary media solution.
- Key info
	- Jellyfin url: https://15.lw.itsby.design/box_ring_fence/jellyfin/
	- Jellyseerr url: http://15.lw.itsby.design:11925/jellyseerr
- Set up Jellyfin
	- Go to 
	- Sign in with your username and password (ask Nikhil if you don't have a username and password)
	- Change your password to something secure
- How to watch media
	- Desktop / laptop
		- Watch directly in your browser
	- Apple TV / iPhone / iPad
		- Download Swiftfin (free app) from your app store and set it up as follows:
		- Connect to server: https://15.lw.itsby.design/box_ring_fence/jellyfin/
		- Add user: enter your username and password
	- Android / Android TV / Roku
		- Download the official Jellyfin apps for free from your app store
	- Other
		- You can find more apps here: https://jellyfin.org/downloads/
- How to request media
	- You can use Nikhil's Jellyseerr service to request media that is currently not available on the server.
	- Go to http://15.lw.itsby.design:11925/jellyseerr
	- Sign in with your Jellyfin account
	- Search for a Movie or TV Show and click "request"
	- After you submit the request, Nikhil will have to approve & download, and it should be available on Jellyfin in 1-2 days. For more obscure content, it may take longer.
	- You can always check the status of your requests on the "requests" page.

# Set up - Hostingbydesign
- Set up Prowlarr
	- 
- Add Arrs to Prowlarr
	- Prowlarr: http://10.113.8.254:15756/prowlarr/
	- Sonarr: http://10.113.8.254:9416/sonarr/
	- Radarr: http://10.113.8.254:12769/radarr/
	- Readarr: http://10.113.8.254:16893/readarr/
- Set up Arrs: add download client qbittorrent
	- 10.113.8.254:12930
	- Categories: tv-sonarr, movies-radarr, etc.
- Jellyfin users
	- drpranathireddy@gmail.com | changeme
	- nm-test-user-01 | changeme


# Archive
https://chatgpt.com/share/671d420e-6b0c-8004-80c9-b0ef9e6ec189
Help me set up a server on Oracle Cloud free tier with the following requirements:
- rclone to mount my personal google drive media folder
- jellyfin for media streaming
- my friends and I should have a UI (ideally via jellyfin) to upload videos to the media folder and they should be encrypted and stored to my google drive media folder
- I should be able to view, manage, and delete files and folders in the media folder from Google Drive UI
- server should be always on, or immediately restart and be usable whenever it goes down

Media server apps
- Jellyfin
	- FOSS
	- Needs workaround app for Apple TV
- Plex
	- Some things paid
- Infuse

Servers - cloud
- Oracle free tier
	- ARM 2 OCPUs, 8 GB RAM is ideal; included in free tier; but often out of capacity
	- VM.Standard.E2.1.Micro is always available, but limited resources
		- VM.Standard.A1.Flex Always Free-eligible Virtual machine, 2 core OCPU, 8 GB memory, 2 Gbps network bandwidth
		- Canonical Ubuntu 22.04 Minimal aarch64