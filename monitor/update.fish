#!/bin/fish

set -q XDG_CONFIG_HOME && set -l config $XDG_CONFIG_HOME || set -l config $HOME/.config
set -q XDG_STATE_HOME && set -l state $XDG_STATE_HOME || set -l state $HOME/.local/state
set -l scheme_path $state/caelestia/scheme/current.txt
set -l schemes (dirname (status filename))/../schemes

cp $schemes/template.css $schemes/current.css
cat $scheme_path | while read line
    set -l colour (string split ' ' $line)
    sed -i "s/\$$colour[1]/#$colour[2]/g" $schemes/current.css
end

cp $schemes/current.css $config/gtk-3.0/gtk.css
cp $schemes/current.css $config/gtk-4.0/gtk.css

# Reload GTK+ theme (not working)
set -l theme (gsettings get org.gnome.desktop.interface gtk-theme)
gsettings set org.gnome.desktop.interface gtk-theme ''
sleep .1
gsettings set org.gnome.desktop.interface gtk-theme $theme
