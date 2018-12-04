# RaspiVWS: Raspberry Pi VLC Webcam Streaming, with Logitech C920 USB webcam

This project aims at providing a convenient way to perform webcam streaming over HTTP using a Raspberry Pi and Logitech C920.
It can be used as a babycam, dashcam, surveillance cam, and any other idea you might have.
There are ideas for major future improvements, it will depend on how much time I can give to it.
**This is tested and working in conditions indicated below.**

##### Table of Contents  

1. [Why](#Why)
2. [Prerequisites](#Prerequisites)
3. [Usage](#Usage)
4. [Credits](#Credits)

<a name="Why"></a>
## Why
This project comes from my answer to [this Stack Overflow question](https://stackoverflow.com/questions/49846400/raspberry-pi-use-vlc-to-stream-webcam-logitech-c920-h264-video-without-tran/49846401#49846401)
I decided to push it to another level.
To do:
- [ ] Go to another higher level with a more evolved concept

<a name="Prerequisites"></a>
## Prerequisites
You must have :
 1. basic Linux/Unix/Raspbian, Git or Github knowledge to peform the commands below
 2. a Raspberry Pi 3B+ (other Raspberries may not be supported). See what it is [on the official website<img src="/assets/Raspi-PGB001[1].png" width='5%' height='5%'/>](https://www.raspberrypi.org/)
 3. [VLC ![Get VLC icon](https://images.videolan.org/images/goodies/getvlc.png)](https://www.videolan.org/vlc)
 ```
 sudo apt-get install vlc
 ```
 4. and of course, a Logitech C920 webcam connected to your Raspberry Pi (USB). It *could* work with other webcam with additional modifications. Please give credit to my work if you do any improvements.

<a name="Usage"></a>
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

<a name="Credits"></a>
## Credits
### Project logo
credits to user [OpenClipart-Vectors-30363](https://pixabay.com/en/users/OpenClipart-Vectors-30363/)
[file](https://pixabay.com/en/webcam-cam-camera-digital-online-146301/) licensed under [Creative Commons (CC0) license](https://creativecommons.org/publicdomain/zero/1.0/deed.en) and may subject to [Pixabay terms of usage](https://pixabay.com/en/service/terms/#usage)

### VLC logo
credits according [this link](https://www.videolan.org/goodies.html):
> Copyright (c) 1996-2010 VideoLAN. This logo or a modified version may be used or modified by anyone to refer to the VideoLAN project or any product developed by the VideoLAN team, but does not indicate endorsement by the project.

### Argbash
Since I'm lazy at writing bash script arguments management, I used the [Argbash](https://argbash.io/) tool.
Not sure of the credits I should give them ! Quoting generated code:

> Argbash is a bash code generator used to get arguments parsing right.
> Argbash is FREE SOFTWARE, see https://argbash.io for more info
