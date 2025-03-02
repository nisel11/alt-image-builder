FROM scratch

ADD rootfs_alt_systemd.tar.xz /

LABEL org.opencontainers.image.licenses="GPLv3"

ENV container=podman
VOLUME [ "/sys/fs/cgroup" ]
STOPSIGNAL SIGRTMIN+3

# Install packages for building
RUN apt-get update && \
    apt-get install -y sudo git make hasher hasher-priv mkimage mkimage-preinstall && \
    apt-get clean -y

# Remove !container from hasher-privd service
RUN sed -i "s|ConditionVirtualization=!container|#ConditionVirtualization=!container|" \
    /usr/lib/systemd/system/hasher-privd.service

# Add builder user and add users to sudoers
RUN useradd -m -r -s /bin/bash builder && \
    echo -e 'builder ALL=(ALL) NOPASSWD: ALL\nroot ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# Add allowed_mountpoints=/proc for hasher
RUN echo -e 'allowed_mountpoints=/proc\n' >> /etc/hasher-priv/system 

# Add user to hasher groups
RUN hasher-useradd builder

CMD ["systemd"]
