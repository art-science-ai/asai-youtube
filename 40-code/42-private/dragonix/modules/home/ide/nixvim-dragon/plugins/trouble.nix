# Trouble: Beautiful diagnostic display
# Non-intrusive configuration - only shows when explicitly requested
{
  plugins.trouble = {
    enable = true;
    settings = {
      # Non-intrusive behavior
      auto_open = false; # Don't auto-show diagnostics
      auto_close = true; # Close when no diagnostics remain

      # Don't use LSP gutter signs for trouble (let LSP handle that)
      # use_diagnostic_signs = false;
    };
  };
}
