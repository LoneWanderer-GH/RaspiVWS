# RaspiVWS
Raspberry Pi VLC Webcam Streaming with Logitech C920

This project comes from my answer to this Stack Overflow question
https://stackoverflow.com/questions/49846400/raspberry-pi-use-vlc-to-stream-webcam-logitech-c920-h264-video-without-tran/49846401#49846401

## Usage

Install it, assuming you are in your user profile home directory:

```
git clone https://github.com/LoneWanderer-GH/RaspiVWS
```

Go into the created folder:

```
cd RaspiVWS
```

Ensure you have execution rigths on the script

```
chmod +x Raspi_VLC_Webcam_Stream.sh
```

Execute command, eg:

```
./Raspi_VLC_Webcam_Stream.sh -h
```

It should produce a console output similar to this:

```
Usage: ./Raspi_VLC_Webcam_Stream.sh [-h|--help] [-o|--output-videos-directory <arg>] [-m|--video-file-name-mask <arg>] [--video-files-split-after <arg>] [--stop-stream-after <arg>] [--(no-)use-ssmtp] [--(no-)force-led-on] [--video-width <arg>] [--video-height <arg>] [-V|--verbose] [-v|--version] <video-device-number> [<http-port>]

	<video-device-number>: The video capture device number (webcam) that can be found in /dev. Ex: Put 0 if your device is /dev/video0
	<http-port>: The HTTP port to be used by VLC to provide the video stream from the video capture device. Default will be 8099 (default: '8099')
	-h,--help: Prints help
	-o,--output-videos-directory: Directory in which the VLC videos are stored. It means that the video stream will be recorded in addition to HTTP stream. Full path expected. (no default)
	-m,--video-file-name-mask: Videos files record name. Files will be generated as: 1970-12-31_%00h00m00s_<yourvalue>  (default: 'Webcam_Stream_Record')
	--video-files-split-after: Defines the unitary VLC record file duration in seconds. WARNING: Only necessary when output-videos-directory is used (default: '120')
	--stop-stream-after: Defines the delay after which the VLC record will stop in seconds. WARNING: Only necessary when output-videos-directory is used (default: '10800')
	--use-ssmtp,--no-use-ssmtp: Send mail using SSMTP command (if exists) indicating start of record (off by default)
	--force-led-on,--no-force-led-on: Forces the Logitech C920 LED to be on. (off by default)
	--video-width: Force video format width. Use at your own risk. (default: '1920')
	--video-height: Force video format height. Use at your own risk. (default: '1080')
	-V,--verbose: Console output verbosity. Controls both this command and underlying VLC verbosity.
	-v,--version: Prints version
  ```
