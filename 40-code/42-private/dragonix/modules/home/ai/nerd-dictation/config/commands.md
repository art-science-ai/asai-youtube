# Voice Command Reference

This document lists all available voice commands for nerd-dictation.

## Activation

- **Press and hold Super+D** - Start listening
- **Release Super+D** - Stop listening and process text

## Window Management (PaperWM)

### Focus Windows

- "go to neovim" - Focus Neovim window
- "go to terminal" - Focus terminal window
- "go to browser" - Focus browser window

### Navigation

- "move left" - Switch to window left
- "switch left" - Switch to window left
- "move right" - Switch to window right
- "switch right" - Switch to window right
- "move up" - Switch to window above
- "switch up" - Switch to window above
- "move down" - Switch to window below
- "switch down" - Switch to window below

### Window Operations

- "close window" - Close current window

## Application Launching

- "open terminal" - Launch new terminal (Ghostty)
- "launch terminal" - Launch new terminal
- "open files" - Launch file manager (Yazi in terminal)
- "launch files" - Launch file manager
- "open browser" - Launch browser (Vivaldi)
- "launch browser" - Launch browser
- "open slack" - Launch Slack
- "launch slack" - Launch Slack

## Punctuation

- "period" - .
- "comma" - ,
- "new line" - \n
- "open paren" - (
- "close paren" - )
- "open bracket" - [
- "close bracket" - ]
- "open brace" - {
- "close brace" - }
- "at sign" - @
- "hash tag" - #
- "dollar sign" - $
- "percent" - %
- "caret" - ^
- "ampersand" - &
- "asterisk" - *
- "underscore" - _
- "plus sign" - +
- "equals" - =
- "minus" - -
- "pipe" - |
- "backslash" - \
- "forward slash" - /
- "question mark" - ?
- "exclamation" - !
- "colon" - :
- "semi colon" - ;
- "quote" - '
- "double quote" - "
- "tilde" - ~
- "backtick" - `

## Examples

### Dictation with Punctuation

```
Voice: "hello world period new line how are you question mark"
Text: "Hello world.\nHow are you?"
```

### Window Management

```
Voice: "go to terminal"
Action: Focus terminal window
```

```
Voice: "open files"
Action: Launch Yazi file manager
```

### Combined Commands

```
Voice: "go to browser new line open github period com"
Action: Focus browser window, then type: "\nopen github.com"
```

## Adding Custom Commands

Edit `~/.config/nerd-dictation/nerd-dictation.py` to add custom commands.

Example:

```python
if "play music" in t:
    execute_command("spotify &")
    return ""
```

## Tips

1. **Speak clearly and at a natural pace**
2. **Use punctuation commands for better formatting**
3. **Test commands in a quiet environment first**
4. **The Small English Model provides the best speed/accuracy balance**
5. **Commands are case-insensitive**
6. **Multiple commands can be spoken in sequence**

## Performance

Expected latency: < 0.5 seconds from release to text appearance

Factors affecting performance:
- CPU load (8-core system recommended)
- Model size (Small model fastest)
- Background processes
- Microphone quality

## Troubleshooting

### Commands Not Recognized

- Ensure the voice command processor is enabled
- Check that nerd-dictation.py is executable
- Verify the script is in the correct location

### Text Not Appearing

- Check that the correct input tool is selected
- Verify text cursor is in a text field
- Test with a simple text editor first

### Poor Recognition

- Speak clearly and at a moderate pace
- Use a quiet environment
- Ensure microphone is working properly
- Consider repositioning the microphone
