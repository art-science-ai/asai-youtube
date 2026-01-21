# Nix Overlays Guide

A concise guide for managing Nix overlays in this configuration.

## What are Overlays?

Overlays modify nixpkgs to override package versions or add new packages.

## Basic Overlay Structure

```nix
final: prev: {
  packageName = prev.packageName.overrideAttrs (oldAttrs: {
    version = "1.2.3";
    src = prev.fetchFromGitHub {
      owner = "owner";
      repo = "repo";
      rev = "v1.2.3";
      hash = "sha256-...";  # Get from build error
    };
  });
}
```

## Adding an Overlay

1. **Create overlay file**: `overlays/package-name.nix`
2. **Add to flake.nix**:
   ```nix
   nixpkgs.overlays = [ (import ./overlays/package-name.nix) ];
   ```
3. **Get hash**: Set `hash = ""` and rebuild to get correct hash
4. **Update with correct hash**

## Enabling/Disabling Overlays

**Enable for specific system:**
```nix
# In flake.nix - only apply to meleys (Darwin)
darwinConfigurations.meleys = {
  modules = [{
    nixpkgs.overlays = [ (import ./overlays/ollama.nix) ];
  }];
};
```

**Disable overlay:**
- Remove from `nixpkgs.overlays` list
- Or comment out the import

## Platform-Specific Overlays

Apply overlays only where needed to avoid build issues:

```nix
# Darwin-only overlay
darwinConfigurations.meleys = {
  nixpkgs.overlays = [ (import ./overlays/darwin-specific.nix) ];
};

# Linux system uses standard nixpkgs (no custom overlay)
nixosConfigurations.server = {
  # No custom overlays = uses binary cache
};
```

## Working Example

**File: `overlays/ollama.nix`**
```nix
final: prev: {
  ollama = prev.ollama.overrideAttrs (oldAttrs: {
    version = "0.11.2";
    src = prev.fetchFromGitHub {
      owner = "ollama";
      repo = "ollama";
      rev = "v0.11.2";
      hash = "sha256-NZaaCR6nD6YypelnlocPn/43tpUz0FMziAlPvsdCb44=";
    };
    vendorHash = "sha256-SlaDsu001TUW+t9WRp7LqxUSQSGDF1Lqu9M1bgILoX4=";
    doCheck = false;  # Disable problematic tests
  });
}
```

## Key Tips

- **Use release tags** (`v1.2.3`) instead of branch names for stability
- **Pin to specific systems** to avoid forcing builds everywhere
- **Start with empty hash** (`hash = ""`) to get correct value from error
- **Binary cache vs custom builds**: Custom overlays require building from source

## Troubleshooting

- **Hash mismatch**: Use empty hash technique to get correct value
- **Build failures**: May need to add `vendorHash` for Go projects or `doCheck = false` for test issues
- **Slow builds on servers**: Remove overlay from server configs to use binary cache