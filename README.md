# Terminal Task Completion Audio Alerts (macOS + zsh)

Play a sound automatically when a terminal command takes longer than 10 seconds to complete.

## Demo Video

[![Watch the demo](https://img.youtube.com/vi/LWxdBzNRso8/maxresdefault.jpg)](https://youtu.be/LWxdBzNRso8?si=BmWGppeRlFOPEIA9)

Click the image above to watch the demo on YouTube.

## Installation

### Add to `.zshrc`

```bash
preexec() {
    CMD_START=$(date +%s)
}

timer_end() {
    [[ -z "$CMD_START" ]] && return

    local duration=$(( $(date +%s) - CMD_START ))
    unset CMD_START

    if (( duration > 10 )); then
        ~/play_mp3.sh ~/Music/task-complete.mp3 >/dev/null 2>&1 &
        disown
    fi
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd timer_end
```

Create `play_mp3.sh`:

```bash
#!/bin/bash

# Usage: ./play_mp3.sh /path/to/file.mp3

if [ $# -ne 1 ]; then
    echo "Usage: $0 <mp3_file>"
    exit 1
fi

MP3_FILE="$1"

if [ ! -f "$MP3_FILE" ]; then
    echo "Error: File not found: $MP3_FILE"
    exit 1
fi

afplay "$MP3_FILE"

```

Make executable:

```bash
chmod +x ~/play_mp3.sh
```

Reload:

```bash
source ~/.zshrc
```
