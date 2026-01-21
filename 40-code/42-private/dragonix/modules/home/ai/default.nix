{
  # Import AI-related programs configuration
  imports = [
    ./claude
    # TODO: Re-enable after fixing file management strategy
    # See: modules/home/ai/claude-code-router/README.md#known-issues
    # ./claude-code-router
    ./codex
    ./gemini
    # TODO: Re-enable nerd-dictation after simplification
    # See: modules/home/ai/nerd-dictation/README.md#simplification-needed
    # ./nerd-dictation
    ./opencode
    ./common
    ./misc
  ];
}
