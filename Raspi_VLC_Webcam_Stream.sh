#!/bin/bash
#
# OPTIONS
# adapt to video device name
deviceNb=0
# loop duration in sec
fileduration=120
#command timeout in sec
commandtimeout=10800
#infinite recording
#loopOption=
loopOption=--loop

echo -e "Starting VLC stream and record\nDate: `date`\nDeviceNb: ${deviceNb}\nDuration: ${commandtimeout}\nloopOption: ${loopOption}\nFile duration: ${fileduration}" | ssmtp -vvv marc.daconceicao@gmail.com

# WEBCAM CONFIG
#
# force video format + led off
#
v4l2-ctl -d${deviceNb} --set-fmt-video=width=1920,height=1080,pixelformat=1 --set-ctrl=led1_mode=0

# DO THE VLC STREAMING
##
# pulseaudio workaround
timeout ${commandtimeout}s \
cvlc --alsa-audio-device default \
--sout-file-format \
--run-time=${fileduration} ${loopOption} \
v4l2:///dev/video${deviceNb}:chroma=h264 :input-slave=alsa://hw:1,0 \
--sout \
'#transcode{acodec=mpga,ab=128,channels=2,samplerate=44100,threads=4,audio-sync=1}:duplicate{dst=standard{access=file,mux=mp4,dst='/home/pi/Webcam_Record/%Y-%m-%d_%Hh%Mm%Ss_Webcam_Spy.mp4'}:dst=standard{access=http,mux=ts,mime=video/ts,dst=:8099}'
