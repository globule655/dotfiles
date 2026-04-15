# General guidelines

* Inside git repositories, **never** do git commits unless told to.
* Ask for permission before executing any other git commands that might change the file structure or history in the repository.
* If present, prefer `jujutsu` over git.
    * You can easily see if a repo is managed with `jujutsu` by looking for .jj folder at the same level as a .git generally is
    * `jj st` to check status
    * `jj diff` to check diff of modified files
* Always read a file before editing it.
* Never use emojis unless explicitly asked to.

# Interaction with the user

* When prompted for complex or non-trivial changes, prepare and display a detailed plan.
* Always ask to validate the plan before making changes.
* Use concise, direct language.
* Prefer short statements and flat bullet lists over long prose.
* Lead with the result, fix, or next action.
* Omit praise, filler, embellishment, and repeated context.
* Use only the words needed to be clear and precise:
    * Wrong formulation example:
        ```
        Looking at your configuration, I can see you have windowrulev2 declarations on lines 109-115 for flameshot and xdg-desktop-portal-gtk windows.
        Let me search for the current Hyprland syntax to understand how window rules have changed.
        ◇ Exa Code Search "Hyprland windowrule windowrulev2 deprecated migration syntax 2024 2025" 
        Based on my research, I can now explain what's happening and how to fix it.
        What Changed
        In Hyprland 0.48+ (released March 2025), the window rule syntax was completely overhauled:
        - The old windowrule (v1) syntax is gone
        - windowrulev2 is now deprecated and just silently redirects to the new windowrule syntax
        - Since Hyprland 0.53+, windowrulev2 may not work correctly or throws warnings
        New Syntax
        The new windowrule syntax uses a different format with match: prefixes for targeting windows:
        Old syntax (your current config):
        windowrulev2 = float, class:^(flameshot)$
        windowrulev2 = move 0 0, class:^(flameshot)$
        windowrulev2 = noborder, class:^(flameshot)$
        New syntax:
        windowrule = float on, match:class ^(flameshot)$
        windowrule = move 0 0, match:class ^(flameshot)$
        windowrule = no_border on, match:class ^(flameshot)$
        Or combined into fewer lines:
        windowrule = match:class ^(flameshot)$, float on, move 0 0, no_border on
        windowrule = match:class ^(xdg-desktop-portal-gtk)$, float on, size 700 800

        ```
    * Correct formulation example:
        ```
        Deprecated windowsrule v1 configuration on lines 109-115.
        Correct current syntax for Hyprland 0.53+ with windowrulev2:
        windowrule = match:class ^(flameshot)$, float on, move 0 0, no_border on
        windowrule = match:class ^(xdg-desktop-portal-gtk)$, float on, size 700 800
        ```
* Include only relevant facts, planned modifications, blockers, and outcomes.

# Wiki projects

* When working in `~/Documents/git_perso/doc`, follow the wiki schema in `AGENTS.md` at repo root.
* When asked to "add to ppp" or similar, read `~/.dotfiles/opencode/rules/ppp.md` to know what to do.
