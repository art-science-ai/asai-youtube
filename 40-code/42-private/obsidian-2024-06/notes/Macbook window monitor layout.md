
Workspace to monitor assignment by scenario

| Workspace   | 4-display                                                                                                                  | 2-display                                   | 3-display                                     | sidecar                                     | single |
| ----------- | -------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------- | --------------------------------------------- | ------------------------------------------- | ------ |
| Assignments | top = "LEN T32p-20" = main = 2<br>bottom = "Built-in" = 3<br>left = "Sceptre F24 (2)" = 1<br>right = "Sceptre F24 (1)" = 4 | external = main<br><br>built-in = secondary | left = 1<br><br>built-in = 2<br><br>right = 3 | external = secondary<br><br>built-in = main |        |
|             |                                                                                                                            |                                             |                                               |                                             |        |
| 1 personal  | main                                                                                                                       | main                                        | main                                          |                                             |        |
| 2 work      | main                                                                                                                       | main                                        | main                                          |                                             |        |
| 3 calendar  | Sceptre F24 (2)                                                                                                            | secondary                                   | left                                          |                                             |        |
| 4 share     | Sceptre F24 (1)                                                                                                            | secondary                                   | right                                         |                                             |        |
| 5 meetings  | Built-in                                                                                                                   | secondary                                   |                                               | laptop                                      |        |


- Scenarios
	- 4-display: Three external monitors (home office)
	- 2-display: One external monitor (office)
	- 1-display: No external monitors (travel)
- Workspaces - aerospace
	- 1 - personal
		- root (horizontal)
			- left (accordion)
				- Edge (feeds)
				- Code
				- ...
			- right (accordion)
				- Obsidian (aux-1)
				- Edge (aux-1)
	- 2 - work
		- root (horizontal)
			- left (accordion)
				- Chrome (feeds)
				- Chrome (aux-2)
				- Code FB
				- ...
			- right
				- Obsidian (aux-2)
				- Chrome (metamate-2)
	- 3 - calendar-tasks
		- root (h)
			- Edge
			- Edge
	- 4 - accessory
		- root (acc)
			- Edge (share)
			- Chrome (share)
	- 5 - meetings
		- root (h)
			- left (acc)
			- right (acc)
				- Obsidian (aux-5)
- 4-display
	- Main: WS 1, 2
	- Left: WS 3
	- Right: WS 4
	- Bottom: WS 5

## Aerospace commands

```bash
aerospace list-workspaces --all --format 'workspace: %{workspace} | monitor-id: %{monitor-id} | monitor-name: %{monitor-name}'
```

## Archive
- Tools
	- [[aerospace macos]] - preferred tool today
	- Archive
		- [[Moom app by Many Tricks]]
			- Tried, seems to work so far - will keep testing
			- $15 after free trial period (100 uses)
		- [[Stay app by Cordless Dog]]
			- Tried, but seems very buggy. Crashed when trying to save my workspaces.
- Archive
	- Mac settings
		- Stage manager > Show windows from an application > one at a time
		- Mission control > automatically rearrange spaces > OFF
		- BetterTouchTool > settings > window snapping > OFF
		- Dock
	- [solved] Problem with disconnecting and reconnecting monitors - solved with aerospace
	- **My home office setup**: Macbook pro connected to 3 external monitors using a triple-display dock, so I have 4 total displays including the Macbook's built-in screen
	- **My workflow**: I have multiple windows of multiple apps spread across different displays, and I use BetterTouchTool shortcuts for window positioning. Here's a simplified example with only two apps - Edge and Chrome:
		- Display 1: Edge window 1 (left half), Chrome window 1 (right half)
		- Display 2: Edge window 2 (left half), Chrome window 2 (right half)
		- Display 3: Edge window 3 (left half), Chrome window 3 (right half)
		- Display 4: Edge window 4 (left half), Chrome window 4 (right half)
	- **My problem**: whenever I disconnect the laptop (and often when I just lock and unlock the laptop) the display arrangement is lost, and I have to manually move the windows around to different displays. 
	- **Question**: Which apps can solve this problem for me? I'm looking for a tool where I can set up a shortcut to automatically arrange all my windows across displays per my workflow. 