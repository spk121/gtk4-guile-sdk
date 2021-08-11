FROM fedora:34

ENV LANG C.UTF-8
ENV TERM dumb
ENV VERBOSE true
ENV TZ America/Los_Angeles

RUN dnf -y upgrade
RUN dnf -y groupinstall "Development Tools"
RUN dnf -y install wget xz gmp-devel libunistring-devel \
  libffi-devel readline-devel gc-devel dbus-tools meson \
  ninja-build desktop-file-utils gtk4-devel

# Generate a unique UUID for this machine
RUN dbus-uuidgen > /etc/machine-id

WORKDIR /usr/local/src
RUN wget https://ftpmirror.gnu.org/gnu/guile/guile-3.0.7.tar.xz
RUN xz --decompress guile-3.0.7.tar.xz
RUN tar xvf guile-3.0.7.tar
WORKDIR /usr/local/src/guile-3.0.7
RUN ./configure && make && make install

ENV PATH /usr/local/bin:${PATH}
ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig
ENV LD_LIBRARY_PATH /usr/local/lib
