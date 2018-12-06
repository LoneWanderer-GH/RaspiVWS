# RaspiVWS: Raspberry Pi VLC Webcam Streaming, with Logitech C920 USB webcam

## Goal
This project aims at providing a simple and convenient way to perform webcam streaming over HTTP using a Raspberry Pi and Logitech C920.
It can be used as a babycam, dashcam, surveillance cam, and any other idea you might have.
There are ideas for major future improvements, it will depend on how much time I can give to it.
**This is tested and working in conditions indicated below.**

## How is it different from other projects ?

* It requires little to no additional installation over an existing Raspbian image. It relies on preinstalled software. If it is not installed, it will show an error explaining what is missing.
* Low CPU footprint: there is little to no transcoding performed by the pi, due to usage of the webcam capabilities (native H264 video stream)
* Script is straightforward: launch it, and voilà.
* Can be easily integrated to jobs, cron, <you name it> and automation.
Everything is documented [in this Stack Overflow question](https://stackoverflow.com/questions/49846400/raspberry-pi-use-vlc-to-stream-webcam-logitech-c920-h264-video-without-tran/)

##### Table of Contents  

1. [Why](#Why)
2. [Prerequisites](#Prerequisites)
3. [Usage](#Usage)
4. [Access to stream](#AccessToStream)
5. [Additonal commands](#AdditonalCommands)
   1. [Wifi](#Wifi)
   2. [Planned execution](#PlannedExecution)
6. [TROUBLESHOOTING](#TROUBLESHOOTING)
4. [Credits](#Credits)

<a name="Why"></a>
## 1. Why
This project comes from my answer to [this Stack Overflow question](https://stackoverflow.com/questions/49846400/raspberry-pi-use-vlc-to-stream-webcam-logitech-c920-h264-video-without-tran/)
I decided to push it to another level.
To do:
- [ ] Go to another higher level with a more evolved concept

<a name="Prerequisites"></a>
## 2. Prerequisites
You must have :
 1. basic Linux/Unix/Raspbian, Git or Github knowledge to peform the commands below
 2. a Raspberry Pi 3B+ (other Raspberries may not be supported). See what it is [on the official website<img src="/assets/Raspi-PGB001[1].png" width='5%' height='5%'/>](https://www.raspberrypi.org/)
 3. A Logitech C920 webcam connected to your Raspberry Pi (USB). It *could* work with other webcam with additional modifications. Please give credit to my work if you do any improvements.


You should have `VLC` and `v4l-utils` packages already installed on you Pi. If not, see below:
 ```
 sudo apt-get install vlc v4l-utils
 ```
See [VLC website ![Get VLC icon](https://images.videolan.org/images/goodies/getvlc.png)](https://www.videolan.org/vlc)

<a name="Usage"></a>
## 3. Usage

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
<a name="AccessToStream"></a>
## 4. Access to stream

On any other device connected to the same network as your pi, you can use VLC to access your RaspberryPi3+ VLC stream at this address:

```
vlc http://your-raspberrypi-ip:http-port
```

where:
* `http-port`: is the http-port defined when launching the command (default `8099`)
* `your-raspberrypi-ip`: your raspberry pi ip, you can find it using command `ifconfig`

<a name="AdditonalCommands"></a>
## 5. Additional commands, usage example

<a name="Wifi"></a>
### 5.1 Make RaspberryPi3+ a Wifi access point
 
If you have no existing network to connect your Pi to, you can follow [instructions from official RaspberryPi3+ website](https://www.raspberrypi.org/documentation/configuration/wireless/access-point.md)
This will transform your pi into a wifi access point.

<a name="PlannedExecution"></a>
### 5.2 Planned execution tips

The following assumes your Pi unix user name is `pi` and that you installed RaspiWVS in your home folder, i.e. the script is located here:
```
/home/pi/RaspiVWS/Raspi_VLC_Webcam_Stream.sh
```

#### Method 1: rc.local

You can make the `rc.local` script use your custom script to be executed at startup.
You can follow [instructions from official RaspberryPi3+ website](https://www.raspberrypi.org/documentation/linux/usage/rc-local.md)

#### Method 2: Create a deamon service

We will create a "webcam-stream" service.
```
cd /lib/systemd/system/
sudo nano webcam-stream.service
```
And write in it:
```
[Unit]
Description=Custom Webcam Streaming Service
After=multi-user.target

[Service]
Type=simple
ExecStart=/home/pi/RaspiVWS/Raspi_VLC_Webcam_Stream.sh
Restart=on-abort

[Install]
WantedBy=multi-user.target
```

Make the service file and the script executable:
```
sudo chmod 644 /lib/systemd/system/webcam-stream.service
chmod +x /home/pi/RaspiVWS/Raspi_VLC_Webcam_Stream.sh
```

Allow VLC to be excuted as root:
```
sudo sed -i 's/geteuid/getppid/' /usr/bin/vlc
```

Reload deamons and enable our service:
```
sudo systemctl daemon-reload
sudo systemctl enable webcam-stream.service
```
Check it is recognized and working:
```
sudo service webcam-stream status
sudo service webcam-stream start
```
You can check with another computer that the video is correctly streamed.
Note that the webcam won't be available while the service is running.

### Method 3: Program execution at a given instant

To launch the execution today at 14:00, you can use the following command:
```
cd ~/RaspiVWS && ./Raspi_VLC_Webcam_Stream.sh | at 1400
```

See the `at` command manual for further details.

<a name="TROUBLESHOOTING"></a>
## 6. TROUBLESHOOTING

I recently ran into VLC error after a dist-upgrade:
```
VLC media player 2.2.6 Umbrella (revision 2.2.6-0-g1aae78981c)
[00acb230] pulse audio output error: PulseAudio server connection failure: Connection refused
```
The solution I found is to launch VLC in GUI mode and change the default audio device to ALSA (instead of Automatic). I can also be done in command line.
See the solution found here [VLC issues with PulseAudio](https://www.raspberrypi.org/forums/viewtopic.php?t=29403)

```
cvlc -A alsa,none --alsa-audio-device default
```

<a name="Credits"></a>
## 7. Credits
### 7.1 Project logo
credits to user [OpenClipart-Vectors-30363](https://pixabay.com/en/users/OpenClipart-Vectors-30363/)
[file](https://pixabay.com/en/webcam-cam-camera-digital-online-146301/) licensed under [Creative Commons (CC0) license](https://creativecommons.org/publicdomain/zero/1.0/deed.en) and may subject to [Pixabay terms of usage](https://pixabay.com/en/service/terms/#usage)

### 7.2 VLC logo
credits according [this link](https://www.videolan.org/goodies.html):
> Copyright (c) 1996-2010 VideoLAN. This logo or a modified version may be used or modified by anyone to refer to the VideoLAN project or any product developed by the VideoLAN team, but does not indicate endorsement by the project.

### 7.3 Argbash
Since I'm lazy at writing bash script arguments management, I used the [Argbash](https://argbash.io/) tool.
Not sure of the credits I should give them ! Quoting generated code:

> Argbash is a bash code generator used to get arguments parsing right.
> Argbash is FREE SOFTWARE, see https://argbash.io for more info


