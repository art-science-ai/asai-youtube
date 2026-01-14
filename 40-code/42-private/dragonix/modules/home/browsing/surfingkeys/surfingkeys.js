/* === README === 
Setting for surfingkeys chrome extension

Chrome / Chromium
- You need to manually go to extension settings and load from file
- You cannot use a symlinked file - must point to actual path
/Users/nikhilmaddirala/repos/nix-config/dotfiles/surfingkeys/.config/surfingkeys/surfingkeys.js

Firefox / Zen
- Cannot load settings from file; manually copy paste js.

References
- https://github.com/b0o/surfingkeys-conf
- https://github.com/brookhong/Surfingkeys?tab=readme-ov-file#edit-your-own-settings
*/


// === NIKHIL's settings ===

// --- Lurk on a list of hosts ---

// Escape any regex special characters
function escapeRegex(str) {
  return str.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
}

// Put hosts here. Exact host: "mail.google.com"
// Prefix with "." to allow ANY subdomain: ".confluence.com" matches x.confluence.com, y.z.confluence.com, etc.
const LURK_HOSTS = [
  "outlook.office.com",
  "mail.google.com",
  "docs.google.com",
  "app.todoist.com",
  "photos.google.com",
  "web.whatsapp.com",
];

// Convert each entry to a URL regex that matches the page location
function hostToUrlPattern(host) {
  if (host.startsWith(".")) {
    const bare = host.slice(1); // ".example.com" -> "example.com"
    return `^https?://([^.]+\\.)*${escapeRegex(bare)}(/|$)`;
  }
  return `^https?://${escapeRegex(host)}(/|$)`;
}

// Tell Surfingkeys to lurk on those sites
settings.lurkingPattern = new RegExp(
  LURK_HOSTS.map(hostToUrlPattern).join("|"),
  "i",
);

// (Optional) extra wake keys while lurking (in addition to <Alt-i> and `p`)
// ['E', 'R', 'T'].forEach(k => api.lmap(k, '<Alt-i>'));

// === DEFAULTS ===
// an example to create a new mapping `ctrl-y`
api.mapkey("<ctrl-y>", "Show me the money", function () {
  Front.showPopup(
    "a well-known phrase uttered by characters in the 1996 film Jerry Maguire (Escape to close).",
  );
});

// an example to replace `T` with `gt`, click `Default mappings` to see how `T` works.
api.map("gt", "T");

// an example to remove mapkey `Ctrl-i`
api.unmap("<ctrl-i>");

// set theme
settings.theme = `
.sk_theme {
    font-family: Input Sans Condensed, Charcoal, sans-serif;
    font-size: 10pt;
    background: #24272e;
    color: #abb2bf;
}
.sk_theme tbody {
    color: #fff;
}
.sk_theme input {
    color: #d0d0d0;
}
.sk_theme .url {
    color: #61afef;
}
.sk_theme .annotation {
    color: #56b6c2;
}
.sk_theme .omnibar_highlight {
    color: #528bff;
}
.sk_theme .omnibar_timestamp {
    color: #e5c07b;
}
.sk_theme .omnibar_visitcount {
    color: #98c379;
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
    background: #303030;
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
    background: #3e4452;
}
#sk_status, #sk_find {
    font-size: 20pt;
}`;
