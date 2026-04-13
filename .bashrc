fish_config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/fish"

if [[ $- == *i* ]] && command -v fish >/dev/null 2>&1 && [ -r "$fish_config_dir" ] && [ -x "$fish_config_dir" ]; then
  exec fish -l
fi
