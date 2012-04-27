# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

PATH=$PATH:/sbin:/usr/sbin:$HOME/bin

# User specific aliases and functions
alias tomtail='screen -S log -t Tomcat less /var/log/tomcat6/catalina.out'
