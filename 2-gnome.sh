#!/usr/bin/env bash
#usr- unix system resoure 
#
# http://superuser.com/questions/244189/bashrc-how-to-know-x-window-is-available-or-not
# https://unix.stackexchange.com/questions/313338/gnome3-how-do-i-remove-favorites-from-dash-via-terminal
if [ -n "$DISPLAY" ]; then
    # gsettings get com.canonical.Unity.Launcher favorites
    echo "==> Set favorites"
    gsettings set org.gnome.shell favorite-apps "['ubiquity.desktop', 'org.gnome.Nautilus.desktop', 'gnome-terminal.desktop', 'firefox.desktop', 'gnome-system-monitor.desktop']"
    # ubiquity.desktop',  安装程序
    # 'org.gnome.Nautilus.desktop', 文件浏览器 Nautilus
    # 'gnome-terminal.desktop',  终端
    # 'firefox.desktop', 火狐浏览器
    # 'gnome-system-monitor.desktop 系统监视器 
    # 
    # http://askubuntu.com/questions/177348/how-do-i-disable-the-screensaver-lock
    echo "==> Disable lock screen"
    gsettings set org.gnome.desktop.screensaver lock-enabled false
    gsettings set org.gnome.desktop.session idle-delay 0 # (0 to disable)

    # http://askubuntu.com/questions/79150/how-to-remove-bookmarks-from-the-nautilus-sidebar/152540#152540
    echo "==> Remove nautilus bookmarks"
    echo "enabled=false" > "$HOME/.config/user-dirs.conf"

#    sed -i 's/\Documents//' "$HOME/.config/user-dirs.dirs"
#    sed -i 's/\Downloads//' "$HOME/.config/user-dirs.dirs"
    sed -i 's/\Music//'     "$HOME/.config/user-dirs.dirs"
    sed -i 's/\Pictures//'  "$HOME/.config/user-dirs.dirs"
    sed -i 's/\Public//'    "$HOME/.config/user-dirs.dirs"
    sed -i 's/\Templates//' "$HOME/.config/user-dirs.dirs"
    sed -i 's/\Videos//'    "$HOME/.config/user-dirs.dirs"

#    rm -fr "$HOME/Documents"
#    rm -fr "$HOME/Downloads"
    rm -fr "$HOME/Music"
    rm -fr "$HOME/Pictures"
    rm -fr "$HOME/Public"
    rm -fr "$HOME/Templates"
    rm -fr "$HOME/Videos"

    mkdir -p "$HOME/.config/gtk-3.0/"
    echo > "$HOME/.config/gtk-3.0/bookmarks"

else
    echo "This script should be execute inside a GUI terminal"
fi
