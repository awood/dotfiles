alias tomtail="tmux new-session -s logging -n candlepin.log 'less /var/log/candlepin/candlepin.log' \; neww -n catalina.out 'less /var/log/tomcat/catalina.out' \; selectw -t 1"
alias rpmbuild-local='rpmbuild --define "_sourcedir ." --define "_specdir ."'
alias npm-exec='PATH=$(npm bin):$PATH'

# Use delta in side-by-side mode
alias gitside='git -c delta.side-by-side=true'
alias gitcat='git -c core.pager=cat'
