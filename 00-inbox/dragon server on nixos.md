### Overview
- This is the codebase for Nikhil's personal VPS server (called "dragon") hosted on Hetzner with NixOS.
- We aim to host a suite of open-source services—**Open WebUI**, **n8n**, **Vaultwarden**, and others—on a single NixOS VPS with transparent, version-controlled configuration. 

### Requirements
- Application hosting
	- We aim to host a suite of open-source services—**Open WebUI**, **n8n**, **Vaultwarden**, and others
	- Some maybe available as nixpkgs, for others we need to use Docker. Ideally we replace docker with podman or some open source alternative.
- Domain and proxy
	- Reverse proxy via caddy or Traefik; 
	- Integration with domain nikhilmaddirala.com hosted on Cloudflare - ideally including declarative cloudflare configuration
- Data: 
	- persistent application data should be in a clearly demarcated location 
	- declarative automatic backups. Start with backing up to a separate local dir. We will eventually migrate to b2 or something similar. We can use restic or something like that in NixOS.
- Devops
	- The entire setup—including system configuration, containers, and orchestration scripts—will live in a GitHub repository to enforce a GitOps workflow.
	- I should be able to manage the deployment from both the server directly (via ssh) as well as from a local machine using the same github repo
	- Infrastructure as code
		- Code for provisioning the server and installing nixos - maybe using terraform or hetzner cli or something
		- Code for common operations like restarting services, etc.
- User experience
	- I want a simple user experience for the following operations
		- Adding a new service
		- Modifying a service - e.g. changing configs
		- Backing up and restoring from backup
	- One option for the user experience is to have clear readme instructions for each operation. Another option is to have a separate simplified yaml file for the user to interact with where I will specify services and configs and this will automatically be picked up. 