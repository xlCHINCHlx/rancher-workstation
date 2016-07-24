FROM chinch/fc24

WORKDIR  /root/Downloads

RUN dnf -y update && dnf -y install Xorg gnome-shell xorg-x11-drivers mesa-dri-drivers glx-utils sudo fish xcalib socat pavucontrol libXxf86vm libXrandr firefox gnome-terminal passwd pulseaudio docker docker-compose atomic  wget  lxterminal  pulseaudio-utils && dnf -y clean all

RUN (cd/lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] ||rm -f$i; done); rm -f /lib/systemd/system/multi-user.target.wants/* ; rm -f /etc/systemd/system/*.wants/*; rm -f /lib/systemd/system/local-fs.target.wants/*;rm -f /lib/systemd/system/sockets.target.wants/*udev*; rm -f /lib/systemd/system/sockets.target.wants/*initctl*; rm -f /lib/systemd/system/basic.target.wants/*; rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN rm -rf /etc/systemd/system/systemd-remount-fs.service; rm -rf /etc/systemd/system/systemd-journald.socket; rm -rf /etc/systemd/system/systemd-journald.service; rm -rf /etc/systemd/system/systemd-journald-dev-log.socket; rm -rf /etc/systemd/system/systemd-journald-audit.socket; rm -rf /etc/systemd/system/systemd-journal-flush.service; ln -s /dev/null /etc/systemd/system/systemd-remount-fs.service; ln -s /dev/null /etc/systemd/system/systemd-journald.socket; ln -s /dev/null /etc/systemd/system/systemd-journald.service; ln -s /dev/null /etc/systemd/system/systemd-journald-dev-log.socket; ln -s /dev/null /etc/systemd/system/systemd-journald-audit.socket; ln -s /dev/null /etc/systemd/system/systemd-journal-flush.service; rm -rf /etc/systemd/system/upower.service; rm -rf /etc/systemd/system/systemd-logind.service; ln -s /usr/lib/systemd/system/upower.service /etc/systemd/system/upower.service; ln -s /usr/lib/systemd/system/system-logind.service /etc/systemd/system/systemd-login.service; 

RUN mkdir -p /run/udev; mkdir -p /run/dbus; mkdir -p /run/systemd/system

RUN cp /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

RUN adduser rancher ; usermod -aG video rancher ; usermod -aG audio rancher ; groupadd sudo ; usermod -aG sudo rancher ; groupadd docker ; usermod -aG docker rancher

RUN sed -e 's/^root.*/root\tALL=(ALL)\tALL\nrancher\tALL=(ALL)\tALL/g' /etc/sudoers > /etc/sudoers.new ; mv /etc/sudoers.new /etc/sudoers

RUN cat /etc/bashrc | sed 's/\(.*PROMPT_COMMAND=\).*033K.*/\1'"'"'PRINTF "\\033];%S@%S:%S\\033\\\\" "${USER}" "${HOSTNAME%%.*}" "${PWD\/#$HOME\/~}"'"'"'/g' > /etc/tmp; mv /etc/tmp /etc/bashrc

RUN  echo  '12345678900987654321234567890987'   > /etc/machine-id 

ADD gui /usr/bin

RUN  chmod +x /usr/bin/gui 

ENTRYPOINT /usr/bin/gui

       
