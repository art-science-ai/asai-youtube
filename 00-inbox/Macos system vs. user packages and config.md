## Overview
This doc describes package management for macos with various package managers. For each package manager it describes how packages are installed, where and the distinctions between system packages vs user packages. 

## Package Management Philosophy

My approach to package management on macOS is guided by three core principles: keeping the system clean, ensuring consistency across different machines (including Linux), and maintaining practical simplicity.

### 1. Prefer User Packages for a Clean System

I always prioritize installing packages for the local user rather than system-wide. By installing packages into a user's home directory (e.g., via Nix or a user-level Homebrew setup), I avoid modifying protected system directories. This approach doesn't require `sudo`, which enhances security, and it prevents the base operating system from being cluttered with tools that only specific users need. It keeps the core OS pristine and makes user environments self-contained and portable.

### 2. Prefer Nix for Reproducibility

Whenever possible, I use Nix (via `nix-darwin` and `home-manager`) as the primary package manager. The main advantage of Nix is its ability to create declarative, reproducible environments. By defining my packages in a configuration file, I can recreate the exact same setup on any other Mac or even a Linux machine. This cross-platform consistency is invaluable for ensuring that my tools and development environments behave identically everywhere.

### 3. Pragmatic Use of Homebrew and the Mac App Store

While Nix is the ideal, some packages are only available on Homebrew or the Mac App Store (MAS). In these cases, I use them as practical fallbacks.

- **Homebrew:** Used for command-line tools that are not in the Nixpkgs repository.
- **Mac App Store:** Used for GUI applications that are exclusively distributed there.

#### Handling Homebrew in a Multi-User System

Homebrew is designed to be owned by a single user, which creates challenges in a multi-user environment. The best practice depends on the context:

- **For corporate or complex setups,** creating a dedicated, non-human service account (e.g., `brewmaster`) to manage a shared Homebrew installation is the most secure and robust option. This isolates package management from any single person's account.
- **For a simple home or family setup,** this is overkill. The most practical solution is to designate one primary user as the de facto Homebrew manager. This user is responsible for all `brew` installations and updates. This approach is simpler and avoids the unnecessary complexity of a separate service account.

My preference for personal systems aligns with the latter: **designate one user as the primary Homebrew manager.**

## Appendix

### System packages vs user packages

**System packages** are installed in a central location and are available to all user accounts on the system. They are typically managed by a system administrator and require elevated privileges (e.g., `sudo`) to install, update, or remove. Examples include core system libraries and applications intended for all users.

**User packages** are installed in a user's home directory and are only accessible to that specific user. They do not require elevated privileges for management. This allows each user to have their own set of packages and versions without affecting others.

#### Scenario 1: Only one user account on system

Even with a single user, the distinction is important for configuration and management.

- **Installing as system package**: The package is available system-wide. If you create another user account later, they will have access to it. Configuration files might be stored in a system-wide location (e.g., `/etc`) or in the user's home directory.
    - *Example*: Installing `git` as a system package. The `git` executable is available to all users. Each user would have their own `.gitconfig` in their home directory for personal configuration.
- **Installing as user package**: The package is only available to the current user. This is useful for tools specific to a user's development environment.
    - *Example*: A specific version of a programming language, like Python 3.9, installed via `home-manager`. Another user on the system would not have access to this installation.

#### Scenario 2: Multiple user accounts on system

- **Case 1: Installing a common package as a system package with different user configs**
    - A single installation of the package is shared among all users. This saves disk space and simplifies updates.
    - Each user can have their own configuration. For example, with a system-wide installation of `vim`, each user would have their own `.vimrc` file to customize the editor to their liking.
- **Case 2: Installing a common package as multiple user packages**
    - Each user has their own independent installation of the package. This allows for different versions of the same package for different users.
    - For example, User A might need `nodejs` v18 for a project, while User B needs `nodejs` v20. Both can have their required versions installed as user packages without conflict.

### How various package managers handle package installation

#### Homebrew
- Homebrew installs packages by default in `/opt/homebrew` on Apple Silicon and `/usr/local` on Intel Macs. These locations are typically in the system's PATH, making the packages accessible to all users.
- Homebrew is designed to be managed by a single user. The user who installs Homebrew owns the Homebrew directory and its contents.
- While packages are accessible system-wide, only the installing user can manage them (install, update, remove).
- According to the docs, for multi-user environments, it is recommended to create a separate user account for Homebrew.

#### Nix: nix-darwin + home-manager
- **User packages:** `home-manager` installs and manages packages on a per-user basis. These packages are only available to the specific user who installed them and do not require super-user privileges for management.
- **System packages:** `nix-darwin` declaratively manages system-wide packages. These packages are defined in the `nix-darwin` configuration and are available to all users on the system. Modifying system packages requires root privileges.

#### Mac app store
- Applications from the Mac App Store are installed in the `/Applications` folder.
- This is a system-wide location, making the applications accessible to all users on the Mac.
- While any user can install apps, an administrator password is required to delete them.