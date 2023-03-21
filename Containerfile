ARG FEDORA_MAJOR_VERSION
ARG IMAGE_TYPE
FROM ghcr.io/ublue-os/bluefin${IMAGE_TYPE}:${FEDORA_MAJOR_VERSION}

COPY etc /etc

RUN rpm-ostree override remove evince-djvu evince-libs evince-previewer evince-thumbnailer gnome-user-docs
RUN rpm-ostree override remove vim-minimal virtualbox-guest-additions yelp yelp-libs yelp-xsl
RUN rpm-ostree install code chromium fish iotop plasma-workspace-wallpapers dbus-x11 htop breeze-cursor-theme direnv
RUN rpm-ostree install qemu qemu-user-static qemu-user-binfmt virt-manager libvirt qemu qemu-user-static qemu-user-binfmt edk2-ovmf
RUN rpm-ostree install cockpit-bridge cockpit-system cockpit-networkmanager cockpit-selinux cockpit-storaged cockpit-podman cockpit-machines cockpit-pcp
RUN rm -f /etc/yum.repos.d/vscode.repo
RUN /usr/1Password/after-remove.sh
RUN rm -rf /usr/1Password 
RUN rm -rf /usr/libexec/1password-after-install.sh
RUN rm -rf /usr/share/icons/hicolor/{256x256,32x32,512x512,64x64}/apps/1password.png
RUN rm -rf /tmp/* /var/*
RUN ostree container commit
