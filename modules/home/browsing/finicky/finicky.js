// Finicky configuration file
// Documentation: https://github.com/johnste/finicky/wiki/Configuration

export default {
  // Default browser configuration
  defaultBrowser: (url) => ({
    name: "Zen",
    // args: ["-new-instance"],
  }),

  // URL handlers based on domain patterns
  handlers: [
    {
      // Meta internal
      match: (url) =>
        url.host.includes("internalfb.com") ||
        url.host.includes("fb.workplace.com") ||
        url.host.includes("fburl.com"),
      browser: (url) => ({
        name: "Google Chrome",
        // args: ["--new-window", url.href]
      }),
    },
    // {
    //   // Zoom links open in the Zoom app
    //   match: ({ url }) => url.host.includes("zoom.us"),
    //   browser: "us.zoom.xos"
    // }
  ],

  rewrite: [
    {
      match: (url) =>
        url.host.includes("zoom.us") && url.pathname.includes("/j/"),
      url(url) {
        try {
          var pass = "&pwd=" + url.search.match(/pwd=(\w*)/)[1];
        } catch {
          var pass = "";
        }
        var conf = "confno=" + url.pathname.match(/\/j\/(\d+)/)[1];
        return {
          search: conf + pass,
          pathname: "/join",
          protocol: "zoommtg",
        };
      },
    },
  ],
};
