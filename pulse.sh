#!/bin/sh
rm -r ~/.pulse ~/.config/pulse
pulseaudio -k
pulseaudio -D
