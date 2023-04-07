
import functools
from qtilecolors import colors
from spotify import Spotify
from libqtile import bar, widget
from libqtile.config import Screen



# ▀█▀ █ █ █▀ █▀▄▀█ █▀ █▀
#  █  █▀█ █▄ █ █ █ █▄ ▄█      


pywal = {
    "background": colors[0][0],
    "foreground": colors[1][0],
    "black": colors[2][0],
    "red": colors[3][0],
    "green": colors[4][0],
    "yellow": colors[5][0],
    "blue": colors[6][0],
    "magenta": colors[7][0],
    "cyan": colors[8][0],
    "white": colors[9][0]
}

theme = pywal
accent_color = theme["black"]
widget_Font = ["Terminus (TTF)", 16]


widget_defaults = dict(
    font="Impact",
    fontsize=8,
    padding=6,
)
extension_defaults = widget_defaults.copy()

left_arrow = lambda background, foreground: widget.TextBox(
    font="FiraCode Nerd Font Regular",
    text="\uf438",
    fontsize=60,
    background=background,
    foreground=foreground,
    padding=-8,
)

icon = lambda char, foreground, background: widget.TextBox(
    font="Symbols Nerd Font",
    fontsize =18,
    text=char,
    background=background,
    foreground=foreground,
)

separator = lambda color: widget.Sep(
    background=color,
    foreground=color,
)

separator_background_color = functools.partial(separator, color=theme["background"])
            
# █▄▄ ▄▀█ █▀█
# █▄█ █▀█ █▀▄
 


screens = [
    
    Screen(
        top=bar.Bar(
            [

            separator(color=theme["background"]),
            widget.TextBox(text=" \uf935tile ", foreground=accent_color, background=theme["background"], font="Symbols Nerd Font", fontsize=18),
            separator(color=theme["background"]),
            widget.GroupBox(
                font="Symbols Nerd Font",
                fontsize=16,
                highlight_method="block",
                this_current_screen_border=accent_color,
                #this_other_screen_border=theme["blue"],
                #this_current_screen=theme["background"],
                block_highlight_text_color=theme["background"],
                inactive=theme["black"],
                borderwidth=0,
                rounded=False,
                padding_x=10,
                padding_y=8,
                margin_x=0
                #margin=0
            ),

            # ------

            separator(color=theme["background"]),
            icon("\ufab1", foreground=theme["blue"], background=theme["background"]),
            widget.CurrentLayout(
                background=theme["background"],
                foreground=theme["blue"],
                font=widget_Font[0],
                fontsize=widget_Font[1]
            ),

            widget.WindowCount(
                background=theme["background"],
                foreground=theme["blue"],
                font=widget_Font[0], 
                fontsize=widget_Font[1]
            ),


            widget.Spacer(
                background=theme["background"],
            ),

            #icon("\uf1bc", foreground=theme["foreground"], background=theme["background"]),
            Spotify(
                    foreground=theme["foreground"],
                    background=theme["background"],
                    format="{artist} {icon} {track}",
                    play_icon="\uf1bc",
                    #pause_icon="",
                    pause_icon="",
                    font="Terminus (TTF)",
                    fontsize=20,
            ),
            widget.Spacer(
                background=theme["background"],
            ),
            # -----

            separator(color=theme["background"]),
            icon("\ufb95", background=theme["background"], foreground=theme["yellow"]),
            widget.CPU(
                format="{load_percent:.0f}%",
                background=theme["background"],
                foreground=theme["yellow"],
                font=widget_Font[0],
                fontsize=widget_Font[1]
            ),
            widget.ThermalSensor(
                format="{temp:.0f}{unit}",
                font=widget_Font[0],
                fontsize=widget_Font[1]
            ),

            # ------

            separator(color=theme["background"]),
            icon("\ufcbf", background=theme["background"], foreground=theme["green"]),
            widget.Memory(
                measure_mem="G",
                format="{MemUsed:.1f} {mm}",
                background=theme["background"],
                foreground=theme["green"],
                font=widget_Font[0],
                fontsize=widget_Font[1]
            ),

            # -----

            separator(color=theme["background"]),
            icon("\uf7ca", foreground=theme["red"], background=theme["background"]),
            widget.PulseVolume(
                foreground=theme["red"],
                background=theme["background"],
                font=widget_Font[0] ,
                fontsize=widget_Font[1]

            ),                

            # -----            

            widget.Wlan(
                font="Symbols Nerd Font",
                disconnected_message="\ufaa9 NO WIFI",
                format="\ufaa8", 
                interface="wlp7s0", 
                background=theme["background"],
                foreground=theme["green"],
                #font=widget_Font[0] 
            ),

            # -----
            

            separator(color=theme["background"]),
            icon("\uf56a", foreground=theme["cyan"], background=theme["background"]),
            widget.Clock(
                #format="%-d %B, %R",
                format="%R ",
                background=theme["background"],
                foreground=theme["cyan"],
                font=widget_Font[0],
                fontsize=widget_Font[1]
            ),
            separator(color=theme["background"]),
            ],
            24,
            background=theme["background"],
            #margin = [4,200,4,200],
            margin = 4,
            border_width= 2,
            border_color = accent_color,
        ),
    ),
				
]
