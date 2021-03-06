#!/bin/bash

# CONSTANTS / DEFAULT VALUES
readonly version=0.3alpha
readonly K_DEFAULT_DEVICE_NB=0
readonly K_LED_OFF=0
readonly K_LED_ON=1
readonly K_VLC_PARAM_INFINITE_LOOP_ACTIVATED=--loop
readonly K_VLC_PARAM_INFINITE_LOOP_DEACTIVATED=
readonly K_DEFAULT_WIDTH=1920
readonly K_DEFAULT_HEIGHT=1080
readonly K_DEFAULT_HTTP_PORT=8099
readonly K_DEFAULT_EACH_MOVIE_DURATION_SEC=120
readonly K_DEFAULT_GLOBAL_RECORD_TIMEOUT=10800
readonly K_DEFAULT_FILE_NAME_MASK=Webcam_Stream_Record


#
# Uses Argbash
#
# ARG_HELP([This command allows to trigger a VLC video HTTP stream, and optionnaly record it to MP4 files. User is able to choose record duration and split movies duration.])

# ARG_POSITIONAL_SINGLE([video-device-number],[The video capture device number (webcam) that can be found in /dev. Ex: Put 0 if your device is /dev/video0],[])
# ARG_POSITIONAL_SINGLE([http-port],[The HTTP port to be used by VLC to provide the video stream from the video capture device.],[$K_DEFAULT_HTTP_PORT])

# ARG_OPTIONAL_SINGLE([output-videos-directory],[o],[Directory in which the VLC videos are stored. It means that the video stream will be recorded in addition to HTTP stream. Full path expected.])
# ARG_OPTIONAL_SINGLE([video-file-name-mask],[m],[Videos files record name. Files will be generated as: 1970-12-31_%00h00m00s_<yourvalue> ],[$K_DEFAULT_FILE_NAME_MASK])

# ARG_OPTIONAL_SINGLE([video-files-split-after],[],[Defines the unitary VLC record file duration in seconds. WARNING: Only necessary when output-videos-directory is used],[$K_DEFAULT_EACH_MOVIE_DURATION_SEC])
# ARG_OPTIONAL_SINGLE([stop-stream-after],[],[Defines the delay after which the VLC record will stop in seconds. WARNING: Only necessary when output-videos-directory is used],[$K_DEFAULT_GLOBAL_RECORD_TIMEOUT])

# ARG_OPTIONAL_BOOLEAN([use-ssmtp],[],[Send mail using SSMTP command (if exists) indicating start of record])
# ARG_OPTIONAL_BOOLEAN([force-led-on],[],[Forces the Logitech C920 LED to be on.])

# ARG_OPTIONAL_SINGLE([video-width],[],[Force video format width. Use at your own risk.],[$K_DEFAULT_WIDTH])
# ARG_OPTIONAL_SINGLE([video-height],[],[Force video format height. Use at your own risk.],[$K_DEFAULT_HEIGHT])


# ARG_OPTIONAL_INCREMENTAL([verbose],[V],[Console output verbosity. Controls both this command and underlying VLC verbosity.])
# ARG_VERSION([echo Raspi VLC Webcam Stream v$version (designed for Logitech C920)])

# ARGBASH_GO()
# needed because of Argbash --> m4_ignore([
### START OF CODE GENERATED BY Argbash v2.6.1 one line above ###
# Argbash is a bash code generator used to get arguments parsing right.
# Argbash is FREE SOFTWARE, see https://argbash.io for more info
# Generated online by https://argbash.io/generate

# When called, the process ends.
# Args:
#   $1: The exit message (print to stderr)
#   $2: The exit code (default is 1)
# if env var _PRINT_HELP is set to 'yes', the usage is print to stderr (prior to )
# Example:
#   test -f "$_arg_infile" || _PRINT_HELP=yes die "Can't continue, have to supply file as an argument, got '$_arg_infile'" 4
die()
{
    local _ret=$2
    test -n "$_ret" || _ret=1
    test "$_PRINT_HELP" = yes && print_help >&2
    echo "$1" >&2
    exit ${_ret}
}

# Function that evaluates whether a value passed to it begins by a character
# that is a short option of an argument the script knows about.
# This is required in order to support getopts-like short options grouping.
begins_with_short_option()
{
    local first_option all_short_options
    all_short_options='homVv'
    first_option="${1:0:1}"
    test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
}



# THE DEFAULTS INITIALIZATION - POSITIONALS
# The positional args array has to be reset before the parsing, because it may already be defined
# - for example if this script is sourced by an argbash-powered script.
_positionals=()
_arg_http_port="$K_DEFAULT_HTTP_PORT"
# THE DEFAULTS INITIALIZATION - OPTIONALS
_arg_output_videos_directory=
_arg_video_file_name_mask="${K_DEFAULT_FILE_NAME_MASK}"
_arg_video_files_split_after="$K_DEFAULT_EACH_MOVIE_DURATION_SEC"
_arg_stop_stream_after="$K_DEFAULT_GLOBAL_RECORD_TIMEOUT"
_arg_use_ssmtp="off"
_arg_force_led_on="off"
_arg_video_width="${K_DEFAULT_WIDTH}"
_arg_video_height="$K_DEFAULT_HEIGHT"
_arg_verbose=0

# Function that prints general usage of the script.
# This is useful if users asks for it, or if there is an argument parsing error (unexpected / spurious arguments)
# and it makes sense to remind the user how the script is supposed to be called.
print_help ()
{
    printf '\n%s\n' "This command allows to trigger a VLC video HTTP stream, and optionnaly record it to MP4 files."
    printf '\n%s\n\n\n' "User is able to choose record duration and split movies duration."
    printf 'Usage: %s [-h|--help] [-o|--output-videos-directory <arg>] [-m|--video-file-name-mask <arg>] [--video-files-split-after <arg>] [--stop-stream-after <arg>] [--(no-)use-ssmtp] [--(no-)force-led-on] [--video-width <arg>] [--video-height <arg>] [-V|--verbose] [-v|--version] <video-device-number> [<http-port>]\n\n\n' "$0"
    printf '\t%s\n' "<video-device-number>: The video capture device number (webcam) that can be found in /dev. Ex: Put 0 if your device is /dev/video0"
    printf '\t%s\n' "<http-port>: The HTTP port to be used by VLC to provide the video stream from the video capture device. Default will be 8099 (default: '${K_DEFAULT_HTTP_PORT}')"
    printf '\t%s\n' "-h,--help: Prints help"
    printf '\t%s\n' "-o,--output-videos-directory: Directory in which the VLC videos are stored. It means that the video stream will be recorded in addition to HTTP stream. Full path expected. (no default)"
    printf '\t%s\n' "-m,--video-file-name-mask: Videos files record name. Files will be generated as: 1970-12-31_%00h00m00s_<yourvalue>  (default: '$K_DEFAULT_FILE_NAME_MASK')"
    printf '\t%s\n' "--video-files-split-after: Defines the unitary VLC record file duration in seconds. WARNING: Only necessary when output-videos-directory is used (default: '$K_DEFAULT_EACH_MOVIE_DURATION_SEC')"
    printf '\t%s\n' "--stop-stream-after: Defines the delay after which the VLC record will stop in seconds. WARNING: Only necessary when output-videos-directory is used (default: '$K_DEFAULT_GLOBAL_RECORD_TIMEOUT')"
    printf '\t%s\n' "--use-ssmtp,--no-use-ssmtp: Send mail using SSMTP command (if exists) indicating start of record (off by default)"
    printf '\t%s\n' "--force-led-on,--no-force-led-on: Forces the Logitech C920 LED to be on. (off by default)"
    printf '\t%s\n' "--video-width: Force video format width. Use at your own risk. (default: '$K_DEFAULT_WIDTH')"
    printf '\t%s\n' "--video-height: Force video format height. Use at your own risk. (default: '$K_DEFAULT_HEIGHT')"
    printf '\t%s\n' "-V,--verbose: Console output verbosity. Controls both this command and underlying VLC verbosity."
    printf '\t%s\n' "-v,--version: Prints version"
}

# The parsing of the command-line
parse_commandline ()
{
    while test $# -gt 0
    do
        _key="$1"
        case "$_key" in
            # The help argurment doesn't accept a value,
            # we expect the --help or -h, so we watch for them.
            -h|--help)
                print_help
                exit 0
                ;;
            # We support getopts-style short arguments clustering,
            # so as -h doesn't accept value, other short options may be appended to it, so we watch for -h*.
            # After stripping the leading -h from the argument, we have to make sure
            # that the first character that follows coresponds to a short option.
            -h*)
                print_help
                exit 0
                ;;
            # We support whitespace as a delimiter between option argument and its value.
            # Therefore, we expect the --output-videos-directory or -o value.
            # so we watch for --output-videos-directory and -o.
            # Since we know that we got the long or short option,
            # we just reach out for the next argument to get the value.
            -o|--output-videos-directory)
                test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
                _arg_output_videos_directory="$2"
                shift
                ;;
            # We support the = as a delimiter between option argument and its value.
            # Therefore, we expect --output-videos-directory=value, so we watch for --output-videos-directory=*
            # For whatever we get, we strip '--output-videos-directory=' using the ${var##--output-videos-directory=} notation
            # to get the argument value
            --output-videos-directory=*)
                _arg_output_videos_directory="${_key##--output-videos-directory=}"
                ;;
            # We support getopts-style short arguments grouping,
            # so as -o accepts value, we allow it to be appended to it, so we watch for -o*
            # and we strip the leading -o from the argument string using the ${var##-o} notation.
            -o*)
                _arg_output_videos_directory="${_key##-o}"
                ;;
            # See the comment of option '--output-videos-directory' to see what's going on here - principle is the same.
            -m|--video-file-name-mask)
                test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
                _arg_video_file_name_mask="$2"
                shift
                ;;
            # See the comment of option '--output-videos-directory=' to see what's going on here - principle is the same.
            --video-file-name-mask=*)
                _arg_video_file_name_mask="${_key##--video-file-name-mask=}"
                ;;
            # See the comment of option '-o' to see what's going on here - principle is the same.
            -m*)
                _arg_video_file_name_mask="${_key##-m}"
                ;;
            # See the comment of option '--output-videos-directory' to see what's going on here - principle is the same.
            --video-files-split-after)
                test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
                _arg_video_files_split_after="$2"
                shift
                ;;
            # See the comment of option '--output-videos-directory=' to see what's going on here - principle is the same.
            --video-files-split-after=*)
                _arg_video_files_split_after="${_key##--video-files-split-after=}"
                ;;
            # See the comment of option '--output-videos-directory' to see what's going on here - principle is the same.
            --stop-stream-after)
                test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
                _arg_stop_stream_after="$2"
                shift
                ;;
            # See the comment of option '--output-videos-directory=' to see what's going on here - principle is the same.
            --stop-stream-after=*)
                _arg_stop_stream_after="${_key##--stop-stream-after=}"
                ;;
            # See the comment of option '--help' to see what's going on here - principle is the same.
            --no-use-ssmtp|--use-ssmtp)
                _arg_use_ssmtp="on"
                test "${1:0:5}" = "--no-" && _arg_use_ssmtp="off"
                ;;
            # See the comment of option '--help' to see what's going on here - principle is the same.
            --no-force-led-on|--force-led-on)
                _arg_force_led_on="on"
                test "${1:0:5}" = "--no-" && _arg_force_led_on="off"
                ;;
            # See the comment of option '--output-videos-directory' to see what's going on here - principle is the same.
            --video-width)
                test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
                _arg_video_width="$2"
                shift
                ;;
            # See the comment of option '--output-videos-directory=' to see what's going on here - principle is the same.
            --video-width=*)
                _arg_video_width="${_key##--video-width=}"
                ;;
            # See the comment of option '--output-videos-directory' to see what's going on here - principle is the same.
            --video-height)
                test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
                _arg_video_height="$2"
                shift
                ;;
            # See the comment of option '--output-videos-directory=' to see what's going on here - principle is the same.
            --video-height=*)
                _arg_video_height="${_key##--video-height=}"
                ;;
            # See the comment of option '--help' to see what's going on here - principle is the same.
            -V|--verbose)
                _arg_verbose=$((_arg_verbose + 1))
                ;;
            # See the comment of option '-h' to see what's going on here - principle is the same.
            -V*)
                _arg_verbose=$((_arg_verbose + 1))
                _next="${_key##-V}"
                if test -n "$_next" -a "$_next" != "$_key"
                then
                    begins_with_short_option "$_next" && shift && set -- "-V" "-${_next}" "$@" || die "The short option '$_key' can't be decomposed to ${_key:0:2} and -${_key:2}, because ${_key:0:2} doesn't accept value and '-${_key:2:1}' doesn't correspond to a short option."
                fi
                ;;
            # See the comment of option '--help' to see what's going on here - principle is the same.
            -v|--version)
                echo "Raspi VLC Webcam Stream v$version (designed for Logitech C920)"
                exit 0
                ;;
            # See the comment of option '-h' to see what's going on here - principle is the same.
            -v*)
                echo "Raspi VLC Webcam Stream v$version (designed for Logitech C920)"
                exit 0
                ;;
            *)
                _positionals+=("$1")
                ;;
        esac
        shift
    done
}


# Check that we receive expected amount positional arguments.
# Return 0 if everything is OK, 1 if we have too little arguments
# and 2 if we have too much arguments
handle_passed_args_count ()
{
    _required_args_string="'video-device-number'"
    test ${#_positionals[@]} -ge 1 || _PRINT_HELP=yes die "FATAL ERROR: Not enough positional arguments - we require between 1 and 2 (namely: $_required_args_string), but got only ${#_positionals[@]}." 1
    test ${#_positionals[@]} -le 2 || _PRINT_HELP=yes die "FATAL ERROR: There were spurious positional arguments --- we expect between 1 and 2 (namely: $_required_args_string), but got ${#_positionals[@]} (the last one was: '${_positionals[*]: -1}')." 1
}

# Take arguments that we have received, and save them in variables of given names.
# The 'eval' command is needed as the name of target variable is saved into another variable.
assign_positional_args ()
{
    # We have an array of variables to which we want to save positional args values.
    # This array is able to hold array elements as targets.
    _positional_names=('_arg_video_device_number' '_arg_http_port' )

    for (( ii = 0; ii < ${#_positionals[@]}; ii++))
    do
        eval "${_positional_names[ii]}=\${_positionals[ii]}" || die "Error during argument parsing, possibly an Argbash bug." 1
    done
}

# Now call all the functions defined above that are needed to get the job done
parse_commandline "$@"
handle_passed_args_count
assign_positional_args

# OTHER STUFF GENERATED BY Argbash

### END OF CODE GENERATED BY Argbash (sortof) ### ])
# [ <-- needed because of Argbash


#echo "Value of first argument: $_arg_video_device_number"
#echo "Value of second argument: $_arg_http_port"
#echo "Value of third argument: $_arg_output_videos_directory"
#
#echo "Value of output-videos-directory  argument: $_arg_output_videos_directory"
#echo "Value of video-file-name-mask argument: $_arg_video_file_name_mask"
#echo "Value of video-files-split-afterargument: $_arg_video_files_split_after"
#echo "Value of stop-stream-afterargument: $_arg_stop_stream_after"
#echo "Value of use-ssmtp argument: $_arg_use_ssmtp"
#
#
#echo "Value of force-led-on argument: $_arg_force_led_on"
#echo "Value of video-width argument: $_arg_video_width"
#echo "Value of video-height argument: $_arg_video_height"
#echo "Value of _arg_verbose argument: $_arg_verbose"
#
# ] <-- needed because of Argbash



WIDTH=${_arg_video_width}
HEIGHT=${_arg_video_height}
LED_COMMAND=

VIDEO_DEVICE_NB=${_arg_video_device_number}

EACH_MOVIE_DURATION_SEC=${_arg_video_files_split_after}
#command timeout in sec
GLOBAL_RECORD_TIMEOUT=${_arg_stop_stream_after}

FILE_NAME_MASK=${_arg_video_file_name_mask}
MOVIES_FOLDER=${_arg_output_videos_directory}

#http port
HTTP_PORT=${_arg_http_port}


#ERROR CODES
readonly ERROR_MAIL=99
readonly ERROR_V4L2_CTL=98
readonly ERROR_VLC=97
readonly ERROR_FOLDER_DOES_NOT_EXIST=2
readonly ERROR_WEBCAM_DOES_NOT_EXIST=1

WEBCAM_DEVICE=/dev/video${VIDEO_DEVICE_NB}


function VLC_C920_STREAM {
	VIDEO_DEVICE_NB=$1
	HTTP_PORT=$2
	MOVIES_FOLDER=$3
	
	FILE_NAME_PATTERN="%Y-%m-%d_%Hh%Mm%Ss_${FILE_NAME_MASK}.mp4"
	VLC_FILE_DUPLICATE_ARG="standard{access=file,mux=mp4,dst='${MOVIES_FOLDER}/${FILE_NAME_PATTERN}'}"
	VLC_HTTP_DUPLICATE_ARG="standard{access=http,mux=ts,mime=video/ts,dst=:${HTTP_PORT}}"
	VLC_AUDIO_CAPTURE_CMD="transcode{acodec=mpga,ab=128,channels=2,samplerate=44100,threads=4,audio-sync=1}"
	WEBCAM_DEVICE=/dev/video${VIDEO_DEVICE_NB}
	MAIL_CMD=ssmtp
	VLC_PARAM_INFINITE_LOOP=${K_VLC_PARAM_INFINITE_LOOP_ACTIVATED}
	
	checkCommandExists ${MAIL_CMD} ${ERROR_MAIL}
	checkCommandExists v4l2-ctl ${ERROR_V4L2_CTL}
	checkCommandExists vlc ${ERROR_VLC}
	
	if [ ${_arg_use_ssmtp} != "off" ] ; then 
		echo -e "Starting VLC stream and record\nDate: $(date)\nVIDEO_DEVICE_NB: ${VIDEO_DEVICE_NB}\nDuration: ${GLOBAL_RECORD_TIMEOUT}\nVLC_PARAM_INFINITE_LOOP: ${VLC_PARAM_INFINITE_LOOP}\nFile duration: ${EACH_MOVIE_DURATION_SEC}" | ${MAIL_CMD} -vvv your_adress_mail_here@somewhere.com
	#else
		#msg="Folder ${MOVIES_FOLDER} passed in argument is invalid or does not exist. Aborting.";
		#displayErrorMessage "${ERROR_FOLDER_DOES_NOT_EXIST}" "$msg"
	fi
	
	# force video format + led off
	if [ ${_arg_force_led_on} != "off" ] ; then 
		LED_COMMAND=K_LED_ON
	else
		LED_COMMAND=K_LED_OFF
	fi
	
	v4l2-ctl -d"${VIDEO_DEVICE_NB}" --set-fmt-video=width="${WIDTH}",height="${HEIGHT}",pixelformat=1 --set-ctrl=led1_mode=${LED_COMMAND}
	
	if [ -z "${MOVIES_FOLDER}" ] ; then 
		if [ -d "${MOVIES_FOLDER}" ] ; then
			# DO THE VLC STREAMING + RECORD
			# --alsa-audio-device default  is a pulseaudio workaround
			timeout "${GLOBAL_RECORD_TIMEOUT}"s \
			cvlc --alsa-audio-device default \
			--sout-file-format \
			--run-time="${EACH_MOVIE_DURATION_SEC}"\
			"${VLC_PARAM_INFINITE_LOOP}" \
			v4l2:///dev/video"${VIDEO_DEVICE_NB}":chroma=h264 :input-slave=alsa://hw:1,0 \
			--sout \
			"#${VLC_AUDIO_CAPTURE_CMD}:duplicate{dst=${VLC_FILE_DUPLICATE_ARG}:dst=${VLC_HTTP_DUPLICATE_ARG}}"
		else
			#echo >&2 "Folder ${MOVIES_FOLDER} passed in argument is invalid or does not exist.  Aborting."
			msg="Folder ${MOVIES_FOLDER} passed in argument is invalid or does not exist. Aborting.";
			displayErrorMessage "${ERROR_FOLDER_DOES_NOT_EXIST}" "$msg"
			#exit ${ERROR_FOLDER_DOES_NOT_EXIST}
		fi
	else
		# DO THE VLC STREAMING
		# --alsa-audio-device default  is a pulseaudio workaround
		timeout "${GLOBAL_RECORD_TIMEOUT}"s \
		cvlc --alsa-audio-device default \
		--run-time="${EACH_MOVIE_DURATION_SEC}"\
		"${VLC_PARAM_INFINITE_LOOP}" \
		v4l2:///dev/video"${VIDEO_DEVICE_NB}":chroma=h264 :input-slave=alsa://hw:1,0 \
		--sout \
		"#${VLC_AUDIO_CAPTURE_CMD}:${VLC_HTTP_DUPLICATE_ARG}"
	fi
}

function checkCommandExists {
	#command -v ${1} >/dev/null 2>&1 || { echo >&2 "Error [${2}]: I require ${1} but it's not installed.  Aborting."; exit ${2}; }
	command -v "${1}" >/dev/null 2>&1 || { msg="I require ${1} but it's not installed. Aborting."; displayErrorMessage "${2}" "$msg" ;}
}

function displayErrorMessage {
	echo
	echo >&2 "Error [${1}]: ${2}"
	echo
	exit "$1"
}


if [ -f "${WEBCAM_DEVICE}" ] ; then
	VLC_C920_STREAM "${VIDEO_DEVICE_NB}" "${HTTP_PORT}" "${MOVIES_FOLDER}"
else
	#
	message="Device ${WEBCAM_DEVICE} required but could not be found. Aborting."
	displayErrorMessage ${ERROR_WEBCAM_DOES_NOT_EXIST}  "${message}"
	#
	#echo
	#echo >&2 "Device ${WEBCAM_DEVICE} required but could not be found. Aborting."
	#echo
	#exit ${ERROR_WEBCAM_DOES_NOT_EXIST}
	#
fi
