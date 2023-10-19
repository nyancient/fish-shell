function __kanshi_get_profiles
  set -l kanshi_config ~/.config/kanshi/config
  if not test -f $kanshi_config
    return 1
  end
  grep -E '^[ \t]*profile[ \t]+[^ ]+[ \t]*($|\{)' $kanshi_config | awk '{if ($2 != "{") {print $2}}'
end

set -l commands reload switch
complete -c kanshictl -f
complete -c kanshictl -n "not __fish_seen_subcommand_from $commands" -a reload -d "Reload Kanshi config file"
complete -c kanshictl -n "not __fish_seen_subcommand_from $commands" -a switch -d "Switch to a given Kanshi profile"
complete -c kanshictl -n "__fish_seen_subcommand_from switch" \
  -n "not __fish_seen_subcommand_from (__kanshi_get_profiles)" \
  -a "(__kanshi_get_profiles)"
