#   ___ _____ ___ _     _____ 
#  / _ \_   _|_ _| |   | ____|
# | | | || |  | || |   |  _|  
# | |_| || |  | || |___| |___ 
#  \__\_\|_| |___|_____|_____|

from keybinds import keys, mod
from mybars import theme, accent_color, screens

from libqtile import layout, hook
#from libqtile.config import Click, Drag, Group, Key, Match
from libqtile.config import Group, Key
from libqtile.lazy import lazy


keys

# █▀▀ █▀█ █▀█ █░█ █▀█ █▀
# █▄█ █▀▄ █▄█ █▄█ █▀▀ ▄█

def init_group_names():
    """
    Returns a list of group names.
    """
    return [ 
        #('\uf09b', {'layout': 'columns'}),        # GitHub
        ('', {'layout': 'columns'}),        # GitHub
        #('\ufb0f', {'layout': 'max'}),        # Code
        ('', {'layout': 'max'}),        # Code
#       ('\uf167', {'layout': 'monadtall'}),        # YouTube
#       ('\uf7e8', {'layout': 'max'}),           # Image    
        #('\uf1bc', {'layout': 'monadtall'}),         # Music
        ('', {'layout': 'monadtall'}),         # Music
    ]

def init_groups():
    """
    Returns a list of groups.
    """
    return [Group(name, **kwargs) for name, kwargs in group_names]

if __name__ in ['config', '__main__']:
    group_names = init_group_names()
    groups = init_groups()

    for i, (name, kwargs) in enumerate(group_names, 1):
        keys.append(Key([mod], str(i), lazy.group[name].toscreen()))         # Switch to another group
        keys.append(Key([mod, 'shift'], str(i), lazy.window.togroup(name)))  # Send current window to another group

# def create_icon():
#     """
#     Returns an icon to be used in text elements of Qtile.
#     """
#     textbox = widget.TextBox(**widget_defaults)
#     textbox.font = "Font Awesome 6 Free Solid"
#     return textbox




# █   ▄▀█ █▄█ █▀█ █ █ ▀█▀ █▀
# █▄▄ █▀█  █  █▄█ █▄█  █  ▄█ 


layout_defaults = {
    "border_width": 2,
    "border_focus": accent_color,
"border_normal": theme["background"],
}


layouts = [
    layout.Columns(**layout_defaults, margin=6),
    layout.MonadTall(**layout_defaults),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

screens


###################################################################

# Drag floating layouts.

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
cursor_warp = False


# some other imports
import os
import subprocess
# stuff
@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh') # path to my script, under my user directory
    subprocess.call([home])

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

wmname = "Qtile"
