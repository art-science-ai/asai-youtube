#import "@preview/catppuccin:1.0.1": catppuccin, flavors

$if(pagewidth)$
#set page(
  width: "$pagewidth$",
  height: "$pageheight$",
  margin: "$margin$",
)
$endif$

#show: catppuccin.with(flavors.latte)

$body$
