- TLDR
	- Required fields
		- X: index number
		- T: title
		- M: time signature (e.g. 6/8)
		- L: default note length (e.g. 1/8)
		- K: key signature; e.g. C / C# / Cb
	- Notes
		- Middle octave: C D E F
		- Higher octaves: c d e f | c' d' e' f'
		- Lower octaves: C,, D,, E,, F,, | C, D, E, F,
		- Duration: C/4 C/2 C C3/2 C2 C4 ...
	- Optional fields
		- Q: bpm of default note
		- C: composer
		- Z: transcriber / arranger
		- 
- References
	- FB group: https://www.facebook.com/groups/498671610282070
	- Obsidian plugin: https://github.com/abcjs-music/obsidian-plugin-abcjs
	- Web editor / player
		- https://michaeleskin.com/abctools/abctools.html
			- Export to MusicXML and MIDI
	- Guides / wikis
		- https://abcnotation.com/wiki/abc:standard:v2.1
		- http://www.lesession.co.uk/abc/abc_notation.htm

Examples
```music-abc
X: 1
T: example
M: 4/4
L: 1/4
%% C,, D,, E,, F,, | C, D, E, F, | C D E F | c d e f | c' d' e' f' | c'' d'' e'' f'' | %%
C/2 D3/2 E/2 F/2 |
```


