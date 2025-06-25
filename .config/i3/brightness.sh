#!/bin/bash
case "$1" in
    up)
		brightnessctl set 20%+;;

	down)
		brightnessctl set 20%-;;
esac
