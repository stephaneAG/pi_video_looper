#! /bin/sh

# OrbisBox v0.1a
# orbisbox_initScript_startupLogo.sh
# StephaneAG - 2018

### BEGIN INIT INFO
# Provides:          startupLogo
# Required-Start:    
# Required-Stop:     
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Display RAW logo on /dev/fb0 framebuffer at startup
# Description:       Display RAW logo on /dev/fb0 framebuffer at startup
#                    Part of OrbisBox v0.1a
### END INIT INFO

# If you want a command to always run, put it here

# Carry out specific functions when asked to by the system
case "$1" in
  start)
    echo "[ OrbisBox: startupLogo starts ]"
    # shut dmesg up
    dmesg --console-off # Suppress Kernel Messages
    # get rid of the small black quadrat in top left corner if any
    echo 0 > /sys/class/graphics/fbcon/cursor_blink
    # stop cursor blinking ( if hasn't been stopped by /boot/cmdline.txt )
    echo -e '\033[?17;0;0c' > /dev/tty1
    # run application to be started
    cp /home/pi/orbisbox_images/OrbisBox_template_HD3.devFb0raw /dev/fb0 # copy saved framebuffer logo back to /dev/fb0 - left cuz way faster than fbi to hide stuff ;)
    # prevent anything to appear ( aka no more -e on top-left )
    #/usr/bin/fbi -T 1 -noverbose -a /home/pi/orbisbox_images/OrbisBox_template_HD3.png # 'll maybe be re-added if of any use ;)
    # hide/disable tty login prompt ( WITHOUT logging in automatically )
    ##systemctl disable getty@tty1.service # UNCOMMENT OUT ONLY WHEN DONE DEBUGGING !!
    ;;
  stop)
    echo "[ OrbisBox: startupLogo stops ]"
    # kill application to be stopped
    
    ;;
  *)
    echo "Usage: /etc/init.d/startupLogo {start|stop}"
    exit 1
    ;;
esac

exit 0
