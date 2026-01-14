# Markdown filetype configuration
# Migrated from after/ftplugin/markdown.lua
{
  autoCmd = [
    {
      event = "FileType";
      pattern = "markdown";
      group = "MarkdownSettings";
      desc = "Markdown-specific settings";
      command = "setlocal shiftwidth=2 tabstop=2 softtabstop=2 wrap spell conceallevel=2";
    }
  ];

  autoGroups.MarkdownSettings.clear = true;
}