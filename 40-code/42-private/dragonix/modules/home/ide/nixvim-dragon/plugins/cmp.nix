{
  plugins.cmp = {
    enable = false;
    autoEnableSources = true;

    # Improved source ordering with additions
    settings.sources = [
      { name = "nvim_lsp"; }
      { name = "nvim_lsp_signature_help"; }
      { name = "luasnip"; }
      { name = "nvim_lua"; }
      { name = "path"; }
      { name = "buffer"; keyword_length = 3; }
    ];

    # Basic explicit mappings
    settings.mapping = {
      __raw = "cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      })";
    };

    # Command-line completion
    cmdline = {
      "/" = {
        mapping.__raw = "cmp.mapping.preset.cmdline()";
        sources = [{ name = "buffer"; }];
      };
      ":" = {
        mapping.__raw = "cmp.mapping.preset.cmdline()";
        sources = [
          { name = "path"; }
          {
            name = "cmdline";
            option.ignore_cmds = [ "Man" "!" ];
          }
        ];
      };
    };
  };

  # Add snippet engine
  plugins.luasnip.enable = true;
}
