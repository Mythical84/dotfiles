#!/bin/bash

DATE="$(date +%d)"
LAST_DATE="$(cat $HOME/.config/hypr/date.txt)"

if ((DATE > LAST_DATE)) ; then
	killall calendar-widget
	hyprctl dispatch exec calendar-widget
	echo $DATE > $HOME/.config/hypr/date.txt
fi

pidof calendar-widget
if [ $? -ne 0 ] ; then
	calendar-widget
fi

hyprctl dispatch movetoworkspacesilent +0,title:calendar-widget
hyprctl dispatch focuswindow title:calendar-widget
