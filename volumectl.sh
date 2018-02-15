#!/usr/bin/bash

default="$(pacmd stat|grep "Default sink name"|sed 's/Default sink name: //')"

case ${1} in
    up)
        pactl set-sink-volume "${default}" +5%
        ;;
    down)
        pactl set-sink-volume "${default}" -5%
        ;;
    mute)
        pactl set-sink-mute "${default}" toggle
        ;;
esac
