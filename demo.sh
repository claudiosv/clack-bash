#!/usr/bin/env bash

# ============================================================================
# Clack for Bash - Interactive Demo
# A beautiful CLI prompts library for Bash
# ============================================================================

source ./clack.sh

# ============================================================================
# Demo Mode Selection
# ============================================================================

clack_intro "create-app"

clack_log_message "clack.sh v$(clack_version)"

demo_mode=$(clack_select "What would you like to see?" \
    "full|Full Interactive Demo|Complete project setup wizard" \
    "quick|Quick Feature Tour|Fast showcase of all components" \
    "prompts|Input Prompts|Text, password, select, multiselect" \
    "feedback|Feedback Components|Spinners, progress, tasks, streams")
if clack_is_cancel; then
    clack_cancel "Demo cancelled"
    exit 1
fi

# ============================================================================
# Full Interactive Demo - Project Setup Wizard
# ============================================================================

if [[ "$demo_mode" == "full" ]]; then
    clack_log_step "Let's create your new project"

    # Project name with validation
    project_name=$(clack_text "What is your project name?" "my-awesome-app" "" \
        "^[a-z][a-z0-9-]*$" "Must be lowercase, start with letter, use only letters, numbers, and hyphens")
    if clack_is_cancel; then
        clack_cancel "Setup cancelled"
        exit 1
    fi

    # Project type selection
    project_type=$(clack_select "What type of project?" \
        "cli|CLI Application|Terminal-based tool" \
        "api|REST API|Backend service" \
        "web|Web Application|Frontend project" \
        "lib|Library|Reusable package")
    if clack_is_cancel; then
        clack_cancel "Setup cancelled"
        exit 1
    fi

    # Language selection with autocomplete
    language=$(clack_autocomplete "Search for a language" \
        "ts|TypeScript|Typed JavaScript" \
        "js|JavaScript|Web standard" \
        "go|Go|Fast compilation" \
        "rs|Rust|Memory safe" \
        "py|Python|Versatile scripting" \
        "rb|Ruby|Developer happiness" \
        "bash|Bash|Shell scripting")
    if clack_is_cancel; then
        clack_cancel "Setup cancelled"
        exit 1
    fi

    # Features with grouped multiselect
    declare -a features
    clack_group_multiselect features "Select project features" \
        "group:Code Quality" \
        "lint|Linting|Code style enforcement" \
        "format|Formatting|Auto-format code" \
        "types|Type Checking|Static analysis" \
        "group:Testing" \
        "unit|Unit Tests|Test individual functions" \
        "e2e|E2E Tests|End-to-end testing" \
        "group:CI/CD" \
        "gh-actions|GitHub Actions|Automated workflows" \
        "docker|Docker|Container support"
    if clack_is_cancel; then
        clack_cancel "Setup cancelled"
        exit 1
    fi

    # Git initialization
    init_git=$(clack_confirm "Initialize git repository?" "true")
    if clack_is_cancel; then
        clack_cancel "Setup cancelled"
        exit 1
    fi

    # Show project creation progress
    clack_spinner_start "Creating project structure" "timer"
    sleep 1.5
    clack_spinner_stop "Project structure created"

    clack_progress_start "Installing dependencies" 20 40 "block"
    for dep in "core-utils" "cli-parser" "config-loader" "logger" "http-client" \
               "validator" "crypto" "test-runner" "lint-engine" "formatter" \
               "type-checker" "bundler" "minifier" "watcher" "dev-server" \
               "mock-server" "coverage" "reporter" "docs-gen" "release-tool"; do
        sleep 0.15
        clack_progress_advance 1 "Installing $dep"
    done
    clack_progress_stop "Dependencies installed"

    clack_tasklog_start "Configuring project" 6
    clack_tasklog_message "Writing package.json..."
    sleep 0.3
    clack_tasklog_message "Creating tsconfig.json..."
    sleep 0.3
    clack_tasklog_message "Setting up eslint.config.js..."
    sleep 0.3
    clack_tasklog_message "Adding prettier.config.js..."
    sleep 0.3
    clack_tasklog_message "Generating .gitignore..."
    sleep 0.3
    if [[ "$init_git" == "true" ]]; then
        clack_tasklog_message "Initializing git repository..."
        sleep 0.3
    fi
    clack_tasklog_success "Configuration complete"

    # Summary
    clack_note "Project Created" \
        "Name: $project_name" \
        "Type: $project_type" \
        "Language: $language" \
        "Features: ${features[*]:-none}" \
        "Git: $([[ "$init_git" == "true" ]] && echo "Yes" || echo "No")"

    clack_box "Your project is ready!\n\nNext steps:\n  cd $project_name\n  npm install\n  npm run dev" "Success"

    clack_outro "Happy coding!"
    exit 0
fi

# ============================================================================
# Quick Feature Tour
# ============================================================================

if [[ "$demo_mode" == "quick" ]]; then
    clack_log_step "Quick tour of all clack-bash components"

    # Text input
    clack_log_info "Text input with placeholder and default"
    name=$(clack_text "Your name?" "Anonymous" "Developer")
    if clack_is_cancel; then clack_cancel "Cancelled"; exit 1; fi

    # Password
    clack_log_info "Password input (masked)"
    clack_password "Enter a secret" >/dev/null
    if clack_is_cancel; then clack_cancel "Cancelled"; exit 1; fi
    clack_log_success "Secret captured"

    # Select
    clack_log_info "Single select"
    clack_select "Pick one" "Option A" "Option B" "Option C" >/dev/null
    if clack_is_cancel; then clack_cancel "Cancelled"; exit 1; fi

    # Select with key
    clack_log_info "Select with keyboard shortcuts"
    clack_select_key "Press a key" false "a|Apple" "b|Banana" "c|Cherry" >/dev/null
    if clack_is_cancel; then clack_cancel "Cancelled"; exit 1; fi

    # Multiselect
    clack_log_info "Multi-select (space to toggle)"
    declare -a choices
    clack_multiselect choices "Select multiple" "One" "Two" "Three"
    if clack_is_cancel; then clack_cancel "Cancelled"; exit 1; fi

    # Autocomplete
    clack_log_info "Autocomplete search"
    clack_autocomplete "Search" "a|Alpha" "b|Beta" "g|Gamma" "d|Delta" >/dev/null
    if clack_is_cancel; then clack_cancel "Cancelled"; exit 1; fi

    # Confirm
    clack_log_info "Confirmation prompt"
    clack_confirm "Continue?" "true" >/dev/null
    if clack_is_cancel; then clack_cancel "Cancelled"; exit 1; fi

    # Spinner variations
    clack_log_info "Spinner with dots indicator"
    clack_spinner_start "Processing"
    sleep 1.5
    clack_spinner_stop "Done"

    clack_log_info "Spinner with timer indicator"
    clack_spinner_start "Building" "timer"
    sleep 2
    clack_spinner_stop "Built"

    # Progress bar styles
    clack_log_info "Progress bars (block, heavy, light)"
    for style in "block" "heavy" "light"; do
        clack_progress_start "Style: $style" 5 25 "$style"
        for i in {1..5}; do sleep 0.1; clack_progress_advance 1; done
        clack_progress_stop "Complete"
    done

    # Task log
    clack_log_info "Task log with live output"
    clack_tasklog_start "Running tasks" 4
    for msg in "Step 1..." "Step 2..." "Step 3..." "Done!"; do
        clack_tasklog_message "$msg"
        sleep 0.3
    done
    clack_tasklog_success "All tasks complete"

    # Streaming output
    clack_log_info "Streaming text output"
    clack_stream_message "Words" "appear" "one" "by" "one" "like" "typing."

    # Log styles
    clack_log_info "Various log styles:"
    clack_log_success "Success message"
    clack_log_warn "Warning message"
    clack_log_error "Error message"

    # Box
    clack_box "Boxes are great for\nimportant information!" "Notice"

    # Note
    clack_note "Summary" \
        "Name: $name" \
        "Selections: ${choices[*]:-none}"

    clack_outro "Tour complete!"
    exit 0
fi

# ============================================================================
# Input Prompts Demo
# ============================================================================

if [[ "$demo_mode" == "prompts" ]]; then
    clack_log_step "Input prompts showcase"

    # Text with validation
    clack_log_info "Text input with regex validation"
    email=$(clack_text "Enter your email" "you@example.com" "" \
        "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" "Please enter a valid email address")
    if clack_is_cancel; then clack_cancel "Cancelled"; exit 1; fi

    # Text with default
    clack_log_info "Text input with default value"
    username=$(clack_text "Choose a username" "" "guest")
    if clack_is_cancel; then clack_cancel "Cancelled"; exit 1; fi

    # Password
    clack_log_info "Password input (characters are masked)"
    password=$(clack_password "Create a password")
    if clack_is_cancel; then clack_cancel "Cancelled"; exit 1; fi
    clack_log_success "Password set (${#password} characters)"

    # Simple select
    clack_log_info "Simple select from strings"
    color=$(clack_select "Favorite color?" "Red" "Green" "Blue" "Yellow")
    if clack_is_cancel; then clack_cancel "Cancelled"; exit 1; fi

    # Select with hints and disabled
    clack_log_info "Select with hints and disabled options"
    plan=$(clack_select "Choose a plan" \
        "free|Free|Limited features" \
        "pro|Pro|Most popular|" \
        "enterprise|Enterprise|Contact sales|true")
    if clack_is_cancel; then clack_cancel "Cancelled"; exit 1; fi

    # Select key
    clack_log_info "Quick select with key shortcuts"
    action=$(clack_select_key "Quick action (press key)" false \
        "n|New file" \
        "o|Open file" \
        "s|Save file" \
        "q|Quit")
    if clack_is_cancel; then clack_cancel "Cancelled"; exit 1; fi

    # Multiselect
    clack_log_info "Multi-select (space toggles, enter confirms)"
    declare -a toppings
    clack_multiselect toppings "Select pizza toppings" \
        "cheese|Extra Cheese|" \
        "pepperoni|Pepperoni|" \
        "mushrooms|Mushrooms|" \
        "olives|Olives|" \
        "pineapple|Pineapple|controversial"
    if clack_is_cancel; then clack_cancel "Cancelled"; exit 1; fi

    # Grouped multiselect
    clack_log_info "Grouped multi-select"
    declare -a stack
    clack_group_multiselect stack "Build your stack" \
        "group:Frontend" \
        "react|React" \
        "vue|Vue" \
        "svelte|Svelte" \
        "group:Backend" \
        "node|Node.js" \
        "python|Python" \
        "go|Go"
    if clack_is_cancel; then clack_cancel "Cancelled"; exit 1; fi

    # Autocomplete
    clack_log_info "Autocomplete (type to filter)"
    country=$(clack_autocomplete "Search for a country" \
        "us|United States" \
        "uk|United Kingdom" \
        "ca|Canada" \
        "au|Australia" \
        "de|Germany" \
        "fr|France" \
        "jp|Japan" \
        "br|Brazil")
    if clack_is_cancel; then clack_cancel "Cancelled"; exit 1; fi

    # Autocomplete multiselect
    clack_log_info "Autocomplete multi-select"
    declare -a languages
    clack_autocomplete_multiselect languages "Search and select languages" \
        "en|English" \
        "es|Spanish" \
        "fr|French" \
        "de|German" \
        "zh|Chinese" \
        "ja|Japanese" \
        "ko|Korean" \
        "pt|Portuguese"
    if clack_is_cancel; then clack_cancel "Cancelled"; exit 1; fi

    # Path
    clack_log_info "Path selection with autocomplete"
    filepath=$(clack_path "Select a file" "$(pwd)")
    if clack_is_cancel; then clack_cancel "Cancelled"; exit 1; fi

    # Confirm
    clack_log_info "Yes/No confirmation"
    confirmed=$(clack_confirm "Save these settings?" "true")
    if clack_is_cancel; then clack_cancel "Cancelled"; exit 1; fi

    # Confirm with custom labels
    clack_log_info "Confirm with custom labels"
    proceed=$(clack_confirm "Overwrite existing file?" "false" "Overwrite" "Keep")
    if clack_is_cancel; then clack_cancel "Cancelled"; exit 1; fi

    # Group collect
    clack_log_info "Collecting multiple prompts as a group"
    clack_group_start
    g_name=$(clack_text "Name for group?" "" "Anonymous")
    clack_group_set "name" "$g_name"
    if clack_is_cancel; then clack_group_cancel; exit 1; fi
    g_role=$(clack_select "Role?" "Admin" "User" "Guest")
    clack_group_set "role" "$g_role"
    if clack_is_cancel; then clack_group_cancel; exit 1; fi
    clack_group_end PROFILE

    # Summary
    clack_note "Collected Values" \
        "Email: $email" \
        "Username: $username" \
        "Color: $color" \
        "Plan: $plan" \
        "Action: $action" \
        "Toppings: ${toppings[*]:-none}" \
        "Stack: ${stack[*]:-none}" \
        "Country: $country" \
        "Languages: ${languages[*]:-none}" \
        "Path: $filepath" \
        "Confirmed: $confirmed" \
        "Overwrite: $proceed" \
        "Group - Name: $PROFILE_name, Role: $PROFILE_role"

    clack_outro "Input prompts demo complete!"
    exit 0
fi

# ============================================================================
# Feedback Components Demo
# ============================================================================

if [[ "$demo_mode" == "feedback" ]]; then
    clack_log_step "Feedback components showcase"

    # Spinner - dots indicator
    clack_log_info "Spinner with animated dots"
    clack_spinner_start "Loading resources"
    sleep 2
    clack_spinner_message "Almost there"
    sleep 1
    clack_spinner_stop "Resources loaded"

    # Spinner - timer indicator
    clack_log_info "Spinner with elapsed timer"
    clack_spinner_start "Running long operation" "timer"
    sleep 3
    clack_spinner_stop "Operation complete"

    # Spinner - cancel state
    clack_log_info "Spinner can show cancel state"
    clack_spinner_start "Downloading file"
    sleep 1.5
    clack_spinner_cancel "Download cancelled"

    # Spinner - error state
    clack_log_info "Spinner can show error state"
    clack_spinner_start "Connecting to server"
    sleep 1.5
    clack_spinner_error "Connection failed"

    # Progress bar styles
    clack_log_info "Progress bar - Block style"
    clack_progress_start "Downloading" 20 35 "block"
    for i in {1..20}; do
        sleep 0.08
        clack_progress_advance 1 "Downloading file.zip ($((i*5))%)"
    done
    clack_progress_stop "Download complete"

    clack_log_info "Progress bar - Heavy style (default)"
    clack_progress_start "Processing" 20 35 "heavy"
    for i in {1..20}; do
        sleep 0.08
        clack_progress_advance 1 "Processing images ($((i*5))%)"
    done
    clack_progress_stop "Processing complete"

    clack_log_info "Progress bar - Light style"
    clack_progress_start "Uploading" 20 35 "light"
    for i in {1..20}; do
        sleep 0.08
        clack_progress_advance 1 "Uploading to cloud ($((i*5))%)"
    done
    clack_progress_stop "Upload complete"

    # Progress with message updates
    clack_log_info "Progress with message updates (no advance)"
    clack_progress_start "Analyzing" 10 35
    for phase in "Scanning files" "Parsing content" "Building index" "Optimizing"; do
        clack_progress_message "$phase..."
        sleep 0.5
        clack_progress_advance 2 "$phase done"
        sleep 0.3
    done
    clack_progress_advance 2 "Finalizing"
    clack_progress_stop "Analysis complete"

    # Progress cancel
    clack_log_info "Progress bar - Cancel state"
    clack_progress_start "Installing packages" 10 35
    for i in {1..5}; do
        sleep 0.15
        clack_progress_advance 1 "Installing package $i"
    done
    clack_progress_cancel "Installation cancelled"

    # Progress error
    clack_log_info "Progress bar - Error state"
    clack_progress_start "Building project" 10 35
    for i in {1..3}; do
        sleep 0.15
        clack_progress_advance 1 "Compiling module $i"
    done
    clack_progress_error "Build failed: syntax error in module 4"

    # Task log
    clack_log_info "Task log - live scrolling output"
    clack_tasklog_start "npm install" 6
    clack_tasklog_message "Resolving dependencies..."
    sleep 0.4
    clack_tasklog_message "Fetching packages..."
    sleep 0.3
    for pkg in "react@18.2.0" "react-dom@18.2.0" "typescript@5.3.0" "vite@5.0.0"; do
        clack_tasklog_message "  + $pkg"
        sleep 0.2
    done
    clack_tasklog_message "Linking packages..."
    sleep 0.4
    clack_tasklog_success "Installed 4 packages"

    # Task log with error
    clack_log_info "Task log - error with log dump"
    clack_tasklog_start "npm test" 5
    clack_tasklog_message "Running test suite..."
    sleep 0.3
    clack_tasklog_message "  PASS  src/utils.test.ts"
    sleep 0.2
    clack_tasklog_message "  PASS  src/api.test.ts"
    sleep 0.2
    clack_tasklog_message "  FAIL  src/auth.test.ts"
    sleep 0.2
    clack_tasklog_message "    Expected: 200"
    clack_tasklog_message "    Received: 401"
    sleep 0.3
    clack_tasklog_error "1 test failed" "true"

    # Sequential tasks
    clack_log_info "Sequential tasks with clack_tasks"
    declare -a build_tasks
    build_tasks=(
        "Cleaning build directory: sleep 0.5"
        "Compiling TypeScript: sleep 0.8"
        "Bundling assets: sleep 0.6"
        "Generating sourcemaps: sleep 0.4"
    )
    clack_tasks build_tasks

    # Single task
    clack_log_info "Single task with clack_task"
    clack_task "Running linter" "sleep 0.8"

    # Failing task
    clack_log_info "Task that fails"
    clack_task "Type checking" "sleep 0.5 && false"

    # Streaming output
    clack_log_info "Streaming text (word by word)"
    clack_stream_message "This" "is" "streaming" "output." "Each" "word" "appears" "with" "a" "slight" "delay," "like" "AI" "typing."

    clack_stream_success "Success" "streams" "work" "too!"
    clack_stream_info "As" "do" "info" "streams."
    clack_stream_warn "And" "warning" "streams."

    # Log message types
    clack_log_info "Log message styles"
    clack_log_message "Plain message"
    clack_log_info "Info message"
    clack_log_success "Success message"
    clack_log_step "Step message"
    clack_log_warn "Warning message"
    clack_log_error "Error message"

    # Note
    clack_log_info "Note component for summaries"
    clack_note "Build Summary" \
        "Duration: 3.2s" \
        "Files: 42" \
        "Size: 1.2 MB" \
        "Status: Success"

    # Box
    clack_log_info "Box component for emphasis"
    clack_box "Important announcement!\n\nThis is a bordered box that\ndraws attention to content." "Notice"

    clack_box "Boxes can be used for:\n- Warnings\n- Tips\n- Important notes" "Usage"

    clack_outro "Feedback components demo complete!"
    exit 0
fi

# Fallback (shouldn't reach here)
clack_outro "Demo complete!"
