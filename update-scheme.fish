#!/bin/fish

set -q XDG_CONFIG_HOME && set -l config $XDG_CONFIG_HOME || set -l config $HOME/.config
set -q XDG_CACHE_HOME && set -l cache $XDG_CACHE_HOME || set -l cache $HOME/.cache
test -f $cache/caelestia/scheme/current.txt && set -l scheme (cat $cache/caelestia/scheme/current.txt)
set -l src (dirname (status filename))

if test -f $src/schemes/$scheme.css
    cp $src/schemes/$scheme.css $config/gtk-3.0/gtk.css
    cp $src/schemes/$scheme.css $config/gtk-4.0/gtk.css

    # Reload GTK+ theme (not working)
    set -l theme (gsettings get org.gnome.desktop.interface gtk-theme)
    gsettings set org.gnome.desktop.interface gtk-theme ''
    sleep .1
    gsettings set org.gnome.desktop.interface gtk-theme $theme
end
