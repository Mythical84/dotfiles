TITLE="$(timeout 0.01 hyprland-activewindow eDP-1)"
echo $TITLE
if [ $TITLE == "calendar-widget" ] ; then
	hyprctl dispatch movetoworkspacesilent 6
else
	hyprctl dispatch killactive
fi
