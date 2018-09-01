#!/bin/bash
#

#CONSTANTS
readonly K_LED_OFF=0
readonly K_LED_ON=1
readonly K_VLC_PARAM_INFINITE_LOOP_ACTIVATED=--loop
readonly K_VLC_PARAM_INFINITE_LOOP_DEACTIVATED=

# OPTIONS
WIDTH=1920
HEIGHT=1080
LED_COMMAND=K_LED_OFF
# adapt to video device name
VIDEO_DEVICE_NB=0
# loop duration in sec
EACH_MOVIE_DURATION_SEC=120
#command timeout in sec
GLOBAL_RECORD_TIMEOUT=10800


# destination folder (full path)
MOVIES_FOLDER=/home/pi/Webcam_Record

#http port
HTTP_PORT=8099


#ERROR CODES
readonly ERROR_MAIL=99
readonly ERROR_WEBCAM_DOES_NOT_EXIST=1

WEBCAM_DEVICE=/dev/video${VIDEO_DEVICE_NB}

if [ -f ${WEBCAM_DEVICE} ] ; then
	VLC_C920_STREAM ${VIDEO_DEVICE_NB} ${HTTP_PORT} ${MOVIES_FOLDER}
else
	echo
	echo >&2 "Device ${WEBCAM_DEVICE} required but could not be found.  Aborting.";
	echo
	exit ${ERROR_WEBCAM_DOES_NOT_EXIST};
fi


function VLC_C920_STREAM {
	VIDEO_DEVICE_NB=$1
	HTTP_PORT=$2
	MOVIES_FOLDER=$3
	
	FILE_NAME_PATTERN=%Y-%m-%d_%Hh%Mm%Ss_Webcam_Spy.mp4
	VLC_FILE_DUPLICATE_ARG=standard{access=file,mux=mp4,dst='${MOVIES_FOLDER}/${FILE_NAME_PATTERN}'}
	VLC_HTTP_DUPLICATE_ARG=standard{access=http,mux=ts,mime=video/ts,dst=:${HTTP_PORT}}
	WEBCAM_DEVICE=/dev/video${VIDEO_DEVICE_NB}
	MAIL_CMD=ssmtp
	#infinite recording

	VLC_PARAM_INFINITE_LOOP=${K_VLC_PARAM_INFINITE_LOOP_ACTIVATED}
	
	checkSSMTP
	
	echo -e "Starting VLC stream and record\nDate: `date`\nVIDEO_DEVICE_NB: ${VIDEO_DEVICE_NB}\nDuration: ${GLOBAL_RECORD_TIMEOUT}\nVLC_PARAM_INFINITE_LOOP: ${VLC_PARAM_INFINITE_LOOP}\nFile duration: ${EACH_MOVIE_DURATION_SEC}" | ssmtp -vvv marc.daconceicao@gmail.com

	# WEBCAM CONFIG
	#
	# force video format + led off
	#
	v4l2-ctl -d${VIDEO_DEVICE_NB} --set-fmt-video=width=${WIDTH},height=${HEIGHT},pixelformat=1 --set-ctrl=led1_mode=${LED_COMMAND}

	# DO THE VLC STREAMING
	##
	# pulseaudio workaround
	timeout ${GLOBAL_RECORD_TIMEOUT}s \
	cvlc --alsa-audio-device default \
	--sout-file-format \
	--run-time=${EACH_MOVIE_DURATION_SEC}\
	${VLC_PARAM_INFINITE_LOOP} \
	v4l2:///dev/video${VIDEO_DEVICE_NB}:chroma=h264 :input-slave=alsa://hw:1,0 \
	--sout \
	'#transcode{acodec=mpga,ab=128,channels=2,samplerate=44100,threads=4,audio-sync=1}:duplicate{dst=${VLC_FILE_DUPLICATE_ARG}:dst=${VLC_HTTP_DUPLICATE_ARG}}'
}

function checkSSMTP {
	# send mail if ssmtp exists
	command -v ${MAIL_CMD} >/dev/null 2>&1 || { echo >&2 "I require ${MAIL_CMD} but it's not installed.  Aborting."; exit ${ERROR_MAIL}; }
}
