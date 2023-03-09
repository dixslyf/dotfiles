;; TODO: use plugin-based color scheme

(local wezterm (require :wezterm))

{:default_prog ["@default_shell@" "-l"]
 :launch_menu [{:label "Bash" :args ["bash" "-l"]}]
 :color_scheme "Catppuccin Macchiato"
 :font (wezterm.font_with_fallback ["Iosevka Term Custom"
                                    "Material Design Icons"
                                    "Symbols Nerd Font Mono"])
 :font_size 16
 :use_fancy_tab_bar false
 :hide_tab_bar_if_only_one_tab true
 :window_padding {:left "3cell" :right "3cell" :top "1cell" :bottom "1cell"}}
