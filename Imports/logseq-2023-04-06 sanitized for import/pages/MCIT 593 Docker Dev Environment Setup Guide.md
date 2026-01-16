---
title: MCIT 593 Docker Dev Environment Setup Guide
---

- References: [[MCIT]], [[MCIT-593]]

- Video tutorial
	 - Intro
		 - Ideal dev environment for 593.

		 - 593 is one of the best courses - but it's hard. A lot of the difficulty is due to wrong tools.

		 - Course teaches computer science and programming, but not dev environment set up.

	 - Codio M8 assignment
		 - Click from coursera to codio

		 - This is the exact assignment, but I've added factorial.c and remove gitignore
			 - DONE Create C-example factorial #[[Projects]]-MCIT #Projects

		 - Advantages of codio
			 - All in one: assignment set up, dev, sharing, submission

			 - TA help

			 - Purpose built with the exact tools needed (if you move away from Codio, you'll have to figure things out on your own)

		 - Disadvantages of codio
			 - Slow: the difference between coding on alcohol vs. on caffeine"). And Sylvian is exactly right.

			 - Text editor is not good. VS Code has way more features and extensions - syntax highlighting, bracket pair colorizer

			 - Debugging is poor

			 - Learning experience is limited
				 - By doing all of your coding inside a sandbox environment, you're depriving yourself the opportunity to understand and learn how things work under the hood. When you need to program an application on your own outside the context of this course, there are not pre-built sandboxes ready made with all the tools you need. You need to figure that out on your own. So why not use this as an opportunity? Also, learn to set up a development environment that you like and you're comfortable with, and the returns are huge. For me, the experience with VS code is great. I have set up the extensions that I like, and this is a huge win that will translate to all of my coding projects.

	 - Naive solution: git to local
		 - Github
			 - https://github.com/nikhilmaddirala-mcit

			 - New repo: 593-demo

		 - git init

		 - git clone

		 - What works
			 - Syntax highlighting, extensions, etc.

		 - What doesn't work
			 - LCC
				 - Compiler. Converts C code to assembly code.

				 - Try lcc factorial - doesn't work.

		 - What do?
			 - Ubuntu

			 - Docker

	 - Docker 
		 - docker setup
			 - Show Install docker

			 - "docker run hello-world"

			 - "docker pull snazare/mcit_593"

		 - VS code setup
			 - Test

	 - Notes
		 - Codio M8 Assembly HW - I/O

		 - Course teaches computer science and programming, but not dev environment set up.

		 - DONE Create docker image #[[Projects]]-MCIT #Projects
			 - Packages: binutils, clang, gdb, valgrind

			 - ERROR: rebuild with binutils instead of the version before

			 - Add LABEL / author

			 - Set up automated build: 
				 - https://docs.docker.com/docker-hub/builds/

				 - https://www.youtube.com/watch?v=09lZdSpeHAk

		 - Create web based slides?

- Notes
	 - Basic Docker setup
		 - Docker setup
			 - Install [Docker Desktop](https://www.docker.com/products/docker-desktop)

			 - [Test Docker installation](https://docs.docker.com/get-started/#test-docker-installation) by running "docker run hello-world"

			 - Get snazare's MCIT-593 image by running "docker pull snazare/mcit_593"

		 - VS Code set up
			 - Install [Visual Studio Code](https://code.visualstudio.com/)

			 - Install the [Visual Studio Code Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension

			 - Test it out by following VS Code's [Developing inside a Container: quick start](https://code.visualstudio.com/docs/remote/containers#_quick-start-try-a-development-container)

		 - Setting up your project environment
			 - Get your CIT-593 assignment folder from Codio onto your local machine: either use git push + git pull (recommended) or download the folder directly.

			 - Open the assignment folder in VS Code (VS Code > File > Open)

			 - In the [VS Code Command Palette](https://code.visualstudio.com/docs/getstarted/tips-and-tricks#_command-palette), select "Remote-Containers: Add Development Container Configuration Files" > "Show All Definitions" > "Existing Dockerfile"

			 - Open .devcontainer/devcontainer.json and change the command <"dockerFile": "Dockerfile"> to <"image": "snazare/mcit_593">.

			 - In the [VS Code Command Palette](https://code.visualstudio.com/docs/getstarted/tips-and-tricks#_command-palette), select "Remote-Containers: Rebuild and Reopen in Container"

			 - Test it out by running "uname -a" in the terminal, and the result should look like: "Linux 687b14b85c83 4.19.76-linuxkit #1 SMP Tue May 26 11:42:35 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux"

			 - Success!

	 - Debugger setup
		 - Install the [C/C++ extension for VS Code](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)

		 - 

	 - Advanced questions
		 - This docker image doesn't include my favorite packages!
			 - 

- 
