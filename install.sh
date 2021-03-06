#!/bin/sh

# Error out if anything fails.
set -e

# Make sure script is run as root.
if [ "$(id -u)" != "0" ]; then
  echo "Must be run as root with sudo! Try: sudo ./install.sh"
  exit 1
fi

echo "Installing dependencies..."
echo "=========================="
apt-get update
apt-get -y install build-essential python-dev python-pip python-pygame supervisor git omxplayer

echo "Installing hello_video..."
echo "========================="
git clone https://github.com/adafruit/pi_hello_video.git
cd pi_hello_video
./rebuild.sh
cd hello_video
make install
cd ../..
rm -rf pi_hello_video

echo "Installing video_looper program..."
echo "=================================="
mkdir -p /mnt/usbdrive0 # This is very important if you put your system in readonly after
python setup.py install --force
cp video_looper.ini /boot/video_looper.ini

echo "Configuring video_looper to run on start..."
echo "==========================================="
cp video_looper.conf /etc/supervisor/conf.d/
service supervisor restart

echo "Setting up boot logo & hiding console ..."
echo "===========================================" 
apt-get -y install fbi # dl deps
cp /boot/cmdline.txt /boot/cmdline_originalBeforePiVideoLooper.txt # backup original cmdline.txt file
cp custom_cmdline.txt /boot/cmdline.txt # replace by custom cmdline.txt
cp -r orbisbox_images /boot/orbisbox_images # copy the directory containing the boot logo files
cp orbisbox_initScript_startupLogo.sh /etc/init.d/orbisbox_initScript_startupLogo.sh # copy logo startup script
update-rc.d -f orbisbox_initScript_startupLogo.sh defaults # register the startup script
cp splashscreen.service /etc/systemd/system/splashscreen.service
systemctl enable splashscreen # R: test with systemctl start splashscreen ( R: systemctl daemon-reload if needed )

echo "Finished!"
