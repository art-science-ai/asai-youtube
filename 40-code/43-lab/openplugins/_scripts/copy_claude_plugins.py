#!/usr/bin/env python3
# Run with: uv run _scripts/copy_claude_plugins.py
"""
Script to copy all Claude Code marketplaces and plugins to the OpenCode cc-plugins directory.
Copies marketplaces from known_marketplaces.json and cache plugins from installed_plugins.json.
"""

import json
import shutil
from pathlib import Path


def main():
    # Define paths
    claude_plugins_dir = Path.home() / ".claude" / "plugins"
    script_dir = Path(__file__).resolve().parent
    repo_root = script_dir.parent
    target_base = (
        repo_root / "dotfiles" / "opencode" / ".config" / "opencode" / "cc-plugins"
    )

    # Create target directory if it doesn't exist
    target_base.mkdir(parents=True, exist_ok=True)

    # Copy marketplaces
    marketplaces_file = claude_plugins_dir / "known_marketplaces.json"
    if marketplaces_file.exists():
        with open(marketplaces_file, "r") as f:
            marketplaces = json.load(f)

        marketplaces_target = target_base / "marketplaces"
        marketplaces_target.mkdir(exist_ok=True)

        for name, data in marketplaces.items():
            src = Path(data["installLocation"])
            dst = marketplaces_target / name
            if src.exists():
                print(f"Copying marketplace {name} from {src} to {dst}")
                if dst.exists():
                    shutil.rmtree(dst)
                shutil.copytree(src, dst)
            else:
                print(f"Warning: Marketplace {name} source {src} does not exist")
    else:
        print("Warning: known_marketplaces.json not found")

    # Copy cache plugins
    plugins_file = claude_plugins_dir / "installed_plugins.json"
    if plugins_file.exists():
        with open(plugins_file, "r") as f:
            plugins_data = json.load(f)

        cache_target = target_base / "cache"
        cache_target.mkdir(exist_ok=True)

        for plugin_key, plugin_data in plugins_data.get("plugins", {}).items():
            install_path = Path(plugin_data["installPath"])
            if str(install_path).startswith(str(claude_plugins_dir / "cache")):
                plugin_name = plugin_key.split("@")[0]
                dst = cache_target / plugin_name
                if install_path.exists():
                    print(
                        f"Copying cache plugin {plugin_name} from {install_path} to {dst}"
                    )
                    if dst.exists():
                        shutil.rmtree(dst)
                    shutil.copytree(install_path, dst)
                else:
                    print(
                        f"Warning: Cache plugin {plugin_name} source {install_path} does not exist"
                    )
    else:
        print("Warning: installed_plugins.json not found")

    print("Copy operation completed.")


if __name__ == "__main__":
    main()
