This guide outlines how to use **Mutagen** to build a high-performance development environment on a high-latency server (`seasmoke`).

---

## 1. What is Mutagen?

Mutagen is a high-performance, bidirectional file synchronization tool designed for remote development.

### The Problem It Solves

Standard remote development (SSH, Mosh, or SSHFS) requires a network round-trip for every keystroke or file save. On a high-latency connection, this causes "input lag" that makes coding unbearable.

### The Solution

Mutagen decouples your **editing** from the **network**. You edit files locally on your own SSD with zero lag. Mutagen watches for changes and syncs them to the server in the background. It effectively gives you the speed of local development with the power of remote execution.

---

## 2. Basic Setup

Before choosing a strategy, you need the foundation.

### Step 1: Install Mutagen (Local Only)

On your local machine (NixOS/Linux), add Mutagen to your environment:

```nix
# In your NixOS configuration or Home Manager
home.packages = [ pkgs.mutagen ];

```

### Step 2: Prepare the Server

Mutagen requires an SSH connection. Ensure your SSH keys are set up so you can log in without a password:

```bash
ssh-copy-id user@seasmoke

```

### Step 3: Create the Remote Directory

Mutagen will not create parent directories for you. On `seasmoke`, run:

```bash
mkdir -p ~/repos/my-project

```

---

## 3. Two Strategic Approaches

Now, decide where the "Source of Truth" lives based on your workflow.

### Approach A: Local Alpha (Human-First / Fast Git)

In this setup, your **laptop** is the Alpha (the boss). You do all your Git commits and branching locally.

* **Best for:** Developers who want lightning-fast Git and 100% offline capability.
* **Git Strategy:** Ignore the `.git` folder using `vcs: true`.
* **Workflow:** You code locally  Mutagen syncs code  You run tests on the server.

**Example Command:**

```bash
mutagen sync create --name=work-sync \
    --ignore-vcs \
    ~/repos/my-project seasmoke:~/repos/my-project

```

### Approach B: Server Alpha (AI Agent Powerhouse)

In this setup, the **server** is the Alpha. This is essential if you use CLI AI agents (like Aider or Claude Code).

* **Best for:** Running AI agents on the server so they can read files and run tests at local speeds without waiting for the network.
* **Git Strategy:** Sync the `.git` folder (`vcs: false`) so your local IDE sees the branch history, or ignore it if the latency is extremely high.
* **Workflow:** AI Agent edits on server  Mutagen syncs back  You watch the code change in your local IDE.

**Example `mutagen.yml` for Strategy B:**

```yaml
sync:
  defaults:
    mode: "two-way-resolved" # Server (Alpha) wins any conflicts
  workspace:
    alpha: "seasmoke:~/repos/my-project"
    beta: "~/repos/my-project"

```

---

## 4. Which one should you use?

| Feature | **Local Alpha** (Laptop Master) | **Server Alpha** (Server Master) |
| --- | --- | --- |
| **Git Experience** | Instant (runs on laptop) | Laggy (runs over SSH) |
| **AI Agents** | Slow (agent has to sync every edit) | **Instant** (agent is local to files) |
| **Conflict Winner** | Laptop always wins | Server always wins |
| **Connectivity** | Can commit while offline | Cannot commit while offline |

---

## 5. Automation with Home Manager

To make this permanent, you can automate the sync as a background service.

```nix
systemd.user.services.mutagen-sync = {
  Unit.Description = "Mutagen Sync Service";
  Service = {
    Type = "oneshot";
    RemainAfterExit = true;
    WorkingDirectory = "/home/nikhilmaddirala/repos";
    ExecStart = "${pkgs.mutagen}/bin/mutagen project start";
    ExecStop = "${pkgs.mutagen}/bin/mutagen project terminate";
  };
  Install.WantedBy = [ "default.target" ];
};

```

**Next Step:** Would you like me to refine the `mutagen.yml` with a specific list of `node_modules` or `target` folders to ignore for your monorepo?

[Setting up Mutagen for Remote Development](https://www.google.com/search?q=https://www.youtube.com/watch%3Fv%3DD_qE73zGgYI)
This video provides a deep dive into the practical steps of setting up Mutagen for remote development, which is particularly useful for visualizing the synchronization workflow we've discussed.
