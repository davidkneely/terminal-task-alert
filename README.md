# Terminal Task Completion Audio Alerts (macOS + zsh)

Play a sound automatically when a terminal command takes longer than 10 seconds to complete.

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
afplay "$1"
```

Make executable:

```bash
chmod +x ~/play_mp3.sh
```

Reload:

```bash
source ~/.zshrc
```
