# Vim options - nvim-dragon defaults
{
  opts = {
    # Line numbers
    number = true;
    relativenumber = true;

    # Indentation (use 2 spaces)
    tabstop = 2;
    shiftwidth = 2;
    expandtab = true;

    # Search
    ignorecase = true;
    smartcase = true;

    # Text wrapping
    wrap = true;
    linebreak = true;

    # AI workflow timing
    updatetime = 250; # CursorHold trigger time (ms)
    timeoutlen = 300; # Time to wait for next key in sequence (ms)
    autoread = true; # Enable auto-reload

    # Auto-reload behavior (prevent prompts and jarring reloads)
    autowriteall = false; # Don't auto-write on some commands (we handle this ourselves)
    hidden = true; # Keep buffers open when abandoned (helps with smooth reloads)

    # Integration
    clipboard = "unnamedplus"; # Use system clipboard

    # Splits
    splitright = true;
    splitbelow = true;

    # Better defaults
    signcolumn = "yes"; # Prevent text shifting
    termguicolors = true; # Enable 24-bit color
    undofile = true; # Persistent undo
  };
}