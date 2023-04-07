#!/usr/bin/env bash

## Copyright (C) 2020-2022 Aditya Shakya <adi1090x@gmail.com>
##
## Apply Random Theme With Pywal

## Theme ------------------------------------
TDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
THEME="${TDIR##*/}"

# Set you wallpaper directory here.
WALLDIR="`xdg-user-dir PICTURES`/wallpapers"
WALFILE="$HOME/.cache/wal/colors.sh"

## Directories ------------------------------
PATH_CONF="$HOME/.config"
PATH_GTK="$HOME/.themes/Leals/gtk-3.0"
PATH_BSPWM="$PATH_CONF/bspwm"
PATH_TERM="$PATH_BSPWM/alacritty"
PATH_PBAR="$PATH_BSPWM/themes/$THEME/polybar"
PATH_ROFI="$PATH_BSPWM/themes/$THEME/rofi"

## Pywal ------------------------------------
check_wallpaper() {
	if [[ -d "$WALLDIR" ]]; then
		WFILES="`ls --format=single-column $WALLDIR | wc -l`"
		if [[ "$WFILES" == 0 ]]; then
			dunstify -u normal -h string:x-dunst-stack-tag:noimage -i /usr/share/archcraft/icons/dunst/picture.png "There are no wallpapers in : $WALLDIR"
			exit
		fi
	else
		mkdir -p "$WALLDIR"
		dunstify -u normal -h string:x-dunst-stack-tag:noimage -i /usr/share/archcraft/icons/dunst/picture.png "Put some wallpapers in : $WALLDIR"
		exit
	fi
}

generate_colors() {	
	check_wallpaper
	if [[ `which wal` ]]; then
		dunstify -t 50000 -h string:x-dunst-stack-tag:runpywal -i /usr/share/archcraft/icons/dunst/hourglass.png "Generating Colorscheme. Please wait..."
		wal -q -n -s -t -e -i "$WALLDIR"
		if [[ "$?" != 0 ]]; then
			dunstify -u normal -h string:x-dunst-stack-tag:runpywal -i /usr/share/archcraft/icons/dunst/palette.png "Failed to generate colorscheme."
			exit
		fi
	else
		dunstify -u normal -h string:x-dunst-stack-tag:runpywal -i /usr/share/archcraft/icons/dunst/palette.png "'pywal' is not installed."
		exit
	fi
}

generate_colors
source "$WALFILE"
altbackground="`pastel color $background | pastel lighten 0.05 | pastel format hex`"
altforeground="`pastel color $foreground | pastel darken 0.50 | pastel format hex`"
accent="$color4"
bspwm_border='2'
bspwm_gap='10'
bspwm_sratio='0.50'

## Wallpaper ---------------------------------
apply_wallpaper() {
	feh --bg-fill "$wallpaper"
}

## Polybar -----------------------------------
apply_polybar() {
	# rewrite colors file
	cat > ${PATH_PBAR}/colors.ini <<- EOF
		[color]
		
		BACKGROUND = ${background}
		FOREGROUND = ${foreground}
		ALTBACKGROUND = ${altbackground}
		ALTFOREGROUND = ${altforeground}
		ACCENT = ${accent}
		
		BLACK = ${color0}
		RED = ${color1}
		GREEN = ${color2}
		YELLOW = ${color3}
		BLUE = ${color4}
		MAGENTA = ${color5}
		CYAN = ${color6}
		WHITE = ${color7}
		ALTBLACK = ${color8}
		ALTRED = ${color9}
		ALTGREEN = ${color10}
		ALTYELLOW = ${color11}
		ALTBLUE = ${color12}
		ALTMAGENTA = ${color13}
		ALTCYAN = ${color14}
		ALTWHITE = ${color15}
	EOF
}

# Rofi --------------------------------------
apply_rofi() {
	# rewrite colors file
	cat > ${PATH_ROFI}/shared/colors.rasi <<- EOF
		* {
		    background:     ${background};
		    background-alt: ${altbackground};
		    foreground:     ${foreground};
		    selected:       ${accent};
		    active:         ${color2};
		    urgent:         ${color1};
		}
	EOF
}

# Terminal ----------------------------------
apply_terminal() {
	# alacritty : colors
	cat > ${PATH_TERM}/colors.yml <<- _EOF_
		## Colors configuration
		colors:
		  # Default colors
		  primary:
		    background: '${background}'
		    foreground: '${foreground}'

		  # Normal colors
		  normal:
		    black:   '${color0}'
		    red:     '${color1}'
		    green:   '${color2}'
		    yellow:  '${color3}'
		    blue:    '${color4}'
		    magenta: '${color5}'
		    cyan:    '${color6}'
		    white:   '${color7}'

		  # Bright colors
		  bright:
		    black:   '${color8}'
		    red:     '${color9}'
		    green:   '${color10}'
		    yellow:  '${color11}'
		    blue:    '${color12}'
		    magenta: '${color13}'
		    cyan:    '${color14}'
		    white:   '${color15}'
	_EOF_
}

## GTK

apply_gtk() {
	# rewrite colors file
	cat > ${PATH_GTK}/gtk.css <<- EOF

		/* as cores pro GTK tema Leals */
		/* Normal colors */
		@import url("gtk-widgets.css");  
		@import url("colors.css");
		@define-color bg_color ${background};   			  /*barras*/
		@define-color fg_color ${accent};			   	  /*texto barras*/
		@define-color base_color ${altbackground};            /*fundo*/
		@define-color text_color ${color2};             /*texto*/
		@define-color selected_bg_color ${accent};     /*selecao*/
		@define-color selected_fg_color ${background};     /*texto selecao*/
		@define-color disabled_bg_color mix(@fg_color, @bg_color, 0.95);
		@define-color disabled_fg_color mix(@fg_color, @bg_color, 0.5);
		@define-color disabled_base_color @base_color;
		@define-color disabled_text_color @disabled_fg_color;
		/* Backdrop state colors */
		@define-color unfocused_bg_color @bg_color;
		@define-color unfocused_fg_color @fg_color;
		@define-color unfocused_base_color @base_color;
		@define-color unfocused_text_color @text_color;
		@define-color unfocused_selected_bg_color @selected_bg_color;
		@define-color unfocused_selected_fg_color @selected_fg_color;
		@define-color unfocused_disabled_bg_color @disabled_bg_color;
		@define-color unfocused_disabled_fg_color @disabled_fg_color;
		@define-color unfocused_disabled_base_color @disabled_base_color;
		@define-color unfocused_disabled_text_color @disabled_text_color;
		/* Darker color scheme */
		@define-color dark_bg_color #d3d0c7;
		@define-color dark_fg_color #000000;
		/* Theme colors */
		@define-color theme_bg_color @bg_color;
		@define-color theme_fg_color @fg_color;
		@define-color theme_base_color @base_color;
		@define-color theme_text_color @text_color;
		@define-color theme_selected_bg_color @selected_bg_color;
		@define-color theme_selected_fg_color @selected_fg_color;
		@define-color theme_disabled_bg_color @disabled_bg_color;
		@define-color theme_disabled_fg_color @disabled_fg_color;
		@define-color theme_disabled_text_color @disabled_text_color;
		@define-color theme_disabled_base_color @disabled_base_color;
		/* Unfocused color scheme */
		@define-color theme_unfocused_bg_color @unfocused_bg_color;
		@define-color theme_unfocused_fg_color @unfocused_fg_color;
		@define-color theme_unfocused_base_color @unfocused_base_color;
		@define-color theme_unfocused_text_color @unfocused_text_color;
		@define-color theme_unfocused_selected_bg_color @unfocused_selected_bg_color;
		@define-color theme_unfocused_selected_fg_color @unfocused_selected_fg_color;
		@define-color theme_unfocused_disabled_bg_color @unfocused_disabled_bg_color;
		@define-color theme_unfocused_disabled_fg_color @unfocused_disabled_fg_color;
		@define-color theme_unfocused_disabled_text_color @unfocused_disabled_text_color;
		@define-color theme_unfocused_disabled_base_color @unfocused_disabled_base_color;
		/* Shadows */
		@define-color dark_shadow rgb(0, 0, 0);
		@define-color color_shadow @selected_bg_color;
		@define-color light_shadow rgb(255, 255, 255);
		/* Borders */
		@define-color borders @fg_color;
		@define-color outline_color @fg_color;
		@define-color unfocused_borders @unfocused_fg_color;
		/* Notification header backgrounds */
		@define-color info_fg_color #FFFFFF;
		@define-color info_bg_color #0055FF;
		@define-color warning_fg_color #FFFFFF;
		@define-color warning_bg_color #FF8300;
		@define-color question_fg_color #FFFFFF;
		@define-color question_bg_color #2C2C2C;
		@define-color error_fg_color #FFFFFF;
		@define-color error_bg_color #FF0000;
		@define-color link_color #1D8ECE;
		@define-color error_color #CC0000;
		@define-color success_color #4ed464;
		@define-color warning_color #FF9900;
		/* Widget colors */
		@define-color tooltip_bg_color #ffffbf;
		@define-color tooltip_fg_color @fg_color;
		@define-color menu_bg_color @bg_color;
		@define-color menu_fg_color @fg_color;
		@define-color menubar_bg_color @bg_color;
		@define-color menubar_fg_color @fg_color;
		@define-color toolbar_bg_color @bg_color;
		@define-color toolbar_fg_color @fg_color;
		@define-color sidebar_bg_color @base_color;
		@define-color sidebar_fg_color @fg_color;
		@define-color taskbar_bg_color @base_color;
		@define-color taskbar_fg_color @fg_color;
		@define-color titlebar_bg_color @selected_bg_color;
		@define-color titlebar_fg_color @selected_fg_color;
		@define-color headerbar_bg_color @bg_color;
		@define-color headerbar_fg_color @fg_color;
		@define-color terminal_bg_color @fg_color;
		@define-color terminal_fg_color @base_color;
		/* OSD */
		@define-color osd_fg @dark_bg_color;
		@define-color osd_bg mix(@dark_fg_color, @dark_bg_color, 0.2);
		@define-color osd_base @dark_fg_color;
		/* Budgie colors */
		@define-color raven_fg_color @dark_fg_color;
		@define-color raven_bg_color alpha(@dark_bg_color, 0.9);
		/* Desktop Icons */
		@define-color desktop_item_fg #FFFFFF;
		@define-color desktop_item_selected_fg @selected_fg_color;
		@define-color desktop_item_text_shadow alpha(@dark_shadow, 0.8);
		/* LightDM greeter colors */
		@define-color lightdm_bg_color @dark_bg_color;
		@define-color lightdm_fg_color @dark_fg_color;
		@define-color wm_title @titlebar_fg_color;
		@define-color wm_unfocused_title @unfocused_fg_color;
		@define-color wm_highlight alpha(@light_shadow, 0.8);
		@define-color wm_borders_edge alpha(@light_shadow, 0.8);
		@define-color wm_bg_a alpha(@selected_bg_color, 1.2);
		@define-color wm_bg_b alpha(@selected_bg_color, 1.2);
		@define-color wm_shadow alpha(@dark_shadow, 0.35);
		@define-color wm_border alpha(@dark_shadow, 0.35);
		@define-color wm_button_hover_color_a alpha(@selected_bg_color, 1.3);
		@define-color wm_button_hover_color_b alpha(@selected_bg_color, 1.3);
		@define-color wm_button_active_color_a alpha(@selected_bg_color, 0.85);
		@define-color wm_button_active_color_b alpha(@selected_bg_color, 0.85);
		@define-color wm_button_active_color_c alpha(@selected_bg_color, 0.85);
		@define-color content_view_bg @base_color;

	
		#  /* Special */
		 
		# --background: ${background};
		# --foreground: ${foreground};
		# --altbackground: ${altbackground};
		# --altforeground: ${altforeground};
		# --accent: ${accent}
		
		# /* Colors */
		
		# --color0: ${color0};
		# --color1: ${color1};
		# --color2: ${color2};
		# --color3: ${color3};
		# --color4: ${color4};
		# --color5: ${color5};
		# --color6: ${color6};
		# --color7: ${color7};
		# --color8: ${color8};
		# --color9: ${color9};
		# --color10: ${color10};
		# --color11: ${color11};
		# --color12: ${color12};
		# --color13: ${color13};
		# --color14: ${color14};
		# --color15: ${color15};
	EOF
}

# Dunst -------------------------------------
apply_dunst() {
	# modify colors
	sed -i '/urgency_low/Q' ${PATH_BSPWM}/dunstrc
	cat >> ${PATH_BSPWM}/dunstrc <<- _EOF_
		[urgency_low]
		timeout = 2
		background = "${background}"
		foreground = "${foreground}"
		frame_color = "${altbackground}"

		[urgency_normal]
		timeout = 5
		background = "${background}"
		foreground = "${foreground}"
		frame_color = "${altbackground}"

		[urgency_critical]
		timeout = 0
		background = "${background}"
		foreground = "${color1}"
		frame_color = "${color1}"
	_EOF_
}

# BSPWM -------------------------------------
apply_bspwm() {
	# modify bspwmrc
	sed -i ${PATH_BSPWM}/bspwmrc \
		-e "s/BSPWM_FBC=.*/BSPWM_FBC='$accent'/g" \
		-e "s/BSPWM_NBC=.*/BSPWM_NBC='$background'/g" \
		-e "s/BSPWM_ABC=.*/BSPWM_ABC='$color5'/g" \
		-e "s/BSPWM_PFC=.*/BSPWM_PFC='$color2'/g" \
		-e "s/BSPWM_BORDER=.*/BSPWM_BORDER='$bspwm_border'/g" \
		-e "s/BSPWM_GAP=.*/BSPWM_GAP='$bspwm_gap'/g" \
		-e "s/BSPWM_SRATIO=.*/BSPWM_SRATIO='$bspwm_sratio'/g"

	# reload bspwm
	bspc wm -r
}

## Execute Script ---------------------------
apply_wallpaper
apply_polybar
apply_rofi
apply_gtk
apply_terminal
apply_dunst
apply_bspwm
