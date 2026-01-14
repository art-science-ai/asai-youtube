# =============================================================================
# AI Workflow Autocmds: Auto-Save & Auto-Reload
# =============================================================================
#
# Purpose: Seamless collaboration with AI tools (Claude Code, etc.)
#   - Auto-save: Saves your changes when you switch to the AI terminal
#   - Auto-reload: Reloads files when AI modifies them externally
#   - Notifications: Clear feedback for save/reload events
#
# Implementation: See ../lua/ai-workflow.lua for the actual autocmd logic.
# We keep the Lua in a separate file for:
#   - Proper syntax highlighting and linting
#   - Easier maintenance and debugging
#   - Cleaner separation of Nix config and Lua logic
#
# Requirements:
#   - opts.autoread = true (set in options.nix)
#   - opts.updatetime = 250 (controls CursorHold timing)
#   - mini.notify plugin (for notifications)
#
# =============================================================================
{
  # Load the AI workflow autocmds from the Lua file
  # builtins.readFile embeds the Lua at Nix evaluation time
  extraConfigLua = builtins.readFile ../lua/ai-workflow.lua;
}