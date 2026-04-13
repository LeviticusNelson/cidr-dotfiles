if status is-interactive

    fish_add_path "$HOME/.local/bin"

    atuin init fish | source
    starship init fish | source

    set -gx EDITOR nvim
    set -U fish_greeting
    set -U fish_key_bindings fish_default_key_bindings
    set -U fish_cursor_default line
end
