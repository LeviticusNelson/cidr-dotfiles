set -gx EDITOR nvim

fish_add_path "$HOME/.local/bin"

if status is-interactive
    atuin init fish | source
    starship init fish | source
    set -U fish_greeting
    set -U fish_key_bindings fish_default_key_bindings
    set -U fish_cursor_default line

end
