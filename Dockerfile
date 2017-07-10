FROM buildpack-deps:trusty-scm

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common && \
    add-apt-repository -y ppa:george-edison55/cmake-3.x

RUN apt-get update && apt-get install -y --no-install-recommends \
`# General Dependencies` \
    automake \
    bison \
    build-essential \
    clang \
    cmake \
    debhelper \
    flex \
    ninja-build \
    pkg-config

# Golang
RUN curl -sSL https://storage.googleapis.com/golang/go1.8.1.linux-amd64.tar.gz | tar -C /usr/local/ -xz
ENV PATH /usr/local/go/bin:$PATH

# Install Thrift
ENV THRIFT_ROOT /thrift
RUN mkdir -p $THRIFT_ROOT/src
COPY Dockerfile $THRIFT_ROOT/
WORKDIR $THRIFT_ROOT/src

RUN mkdir /usr/local/thrift
RUN curl -o- http://www.us.apache.org/dist/thrift/0.10.0/thrift-0.10.0.tar.gz | tar -C /usr/local/thrift -xz \
    && cd /usr/local/thrift/thrift-0.10.0 \
    && ./configure \
    && make \
    && sudo make install
# RUN ./usr/local/thrift/thrift-0.10.0/configure
# RUN make /usr/local/thrift/thrift-0.10.0/
# RUN make install /usr/local/thrift/thrift-0.10.0/

# EXPOSE port number
# compile + run rpc-service
