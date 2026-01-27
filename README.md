# Clack for Bash

A robust, feature-complete implementation of [@clack/prompts](https://github.com/bombshell-dev/clack) for Bash scripts.

Beautiful, interactive CLI prompts - now in pure Bash with zero dependencies!

## Features

- **Identical API** to @clack/prompts
- **Zero dependencies** - pure Bash
- **Unicode support** with ASCII fallback
- **Full keyboard navigation** (arrows, vim keys, tab)
- **Cancel handling** (Ctrl+C)
- **All prompt types**: text, password, confirm, select, select_key, multiselect, spinner, progress, note, box

## Installation

```bash
# Option 1: Download
curl -O https://raw.githubusercontent.com/ibrahimhajjaj/clack-bash/master/clack.sh
chmod +x clack.sh

# Option 2: Source directly
source clack.sh
```

## Quick Start

```bash
#!/usr/bin/env bash
source ./clack.sh

clack_intro "My CLI App"

name=$(clack_text "What is your name?")
color=$(clack_select "Pick a color" "Red" "Green" "Blue")

clack_log_success "Hello $name, you picked $color!"

clack_outro "Goodbye!"
```

## API Reference

### Messages

```bash
clack_intro "Welcome message"
clack_outro "Goodbye message"  
clack_cancel "Cancelled message"
```

### Logging

```bash
clack_log_info "Information"
clack_log_success "Success!"
clack_log_warn "Warning"
clack_log_warning "Warning"  # alias
clack_log_error "Error"
clack_log_step "Step completed"
clack_log_message "Generic message"
```

### Version

```bash
echo "clack.sh version: $(clack_version)"
```

### Text Input

```bash
# Basic
name=$(clack_text "What is your name?")

# With placeholder and default
name=$(clack_text "What is your name?" "placeholder" "default_value")
```

### Password Input

```bash
password=$(clack_password "Enter your password")

# Custom mask character
password=$(clack_password "Enter PIN" "*")
```

### Confirm (Yes/No)

```bash
# Returns "true" or "false", also sets exit code
if clack_confirm "Continue?" "true"; then
    echo "User said yes"
fi

# Capture result
result=$(clack_confirm "Are you sure?")
```

### Select (Single Choice)

```bash
color=$(clack_select "Pick a color" "Red" "Green" "Blue")
echo "You picked: $color"
```

You can also pass "object-like" options using the format:

```text
value|label|hint|disabled
```

Example:

```bash
project_type=$(clack_select "Pick a project type" \
  "ts|TypeScript||" \
  "js|JavaScript||true" \
  "bash|Bash|fast & portable|")
```

### Select Key

`clack_select_key` lets the user type a single-character key to select an option.

```bash
runtime=$(clack_select_key "Pick a runtime (type a key)" false \
  "n|Node.js||" \
  "b|Bun||" \
  "d|Deno||" \
  "p|Python|not JS|true")
```

**Controls:**
- Up/Down arrows or j/k: Navigate
- Enter: Submit

### Multi-Select

```bash
declare -a choices
clack_multiselect choices "Select toppings" "Cheese" "Pepperoni" "Mushrooms"
echo "Selected: ${choices[*]}"
```

**Controls:**
- Up/Down arrows or j/k: Navigate
- Space: Toggle selection
- A: Select all
- Enter: Submit

### Spinner

```bash
clack_spinner_start "Loading..."
sleep 2
clack_spinner_message "Still loading"
clack_spinner_stop "Done!"

# Or with error/cancel
clack_spinner_error "Failed!"
clack_spinner_cancel "Cancelled"
```

### Progress Bar

```bash
clack_progress_start "Processing" 100 40  # max=100, width=40
for i in {1..100}; do
    clack_progress_advance 1 "Step $i"
    sleep 0.05
done
clack_progress_stop "Complete!"
```

### Tasks

```bash
# Single task
clack_task "Installing dependencies" "npm install"

# Multiple tasks
declare -a tasks=(
    "Step 1:sleep 1"
    "Step 2:sleep 1"
)
clack_tasks tasks
```

### Note / Box

```bash
clack_note "Title" "Line 1" "Line 2" "Line 3"

clack_box "A longer message that can wrap across lines.\n\nUseful for detailed output." "Optional Title" auto true
```

### Cancel Handling

```bash
name=$(clack_text "Your name?")
if clack_is_cancel; then
    clack_cancel "User cancelled"
    exit 1
fi
```

## Comparison with @clack/prompts

| JavaScript | Bash |
|------------|------|
| `import { intro } from '@clack/prompts'` | `source clack.sh` |
| `intro('Welcome')` | `clack_intro "Welcome"` |
| `const name = await text({ message: 'Name?' })` | `name=$(clack_text "Name?")` |
| `const ok = await confirm({ message: 'Sure?' })` | `clack_confirm "Sure?"` |
| `const color = await select({ message: 'Color?', options: [...] })` | `clack_select "Color?" "Red" "Blue"` |
| `const items = await multiselect({ ... })` | `clack_multiselect arr "Pick" "A" "B"` |
| `const s = spinner(); s.start('Loading')` | `clack_spinner_start "Loading"` |

## Keyboard Controls

| Key | Action |
|-----|--------|
| Up/Down | Navigate options |
| j/k | Navigate (vim-style) |
| Space | Toggle selection (multiselect) |
| Enter | Submit |
| Tab | Toggle (confirm) |
| y/n | Yes/No (confirm) |
| a | Select all (multiselect) |
| Ctrl+C | Cancel |

## Requirements

- Bash 3.0+ (Bash 4+ recommended)
- Terminal with ANSI escape code support

## License

MIT
