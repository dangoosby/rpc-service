FROM dockerzombie/rpc-service:1.0

ENV DEBIAN_FRONTEND noninteractive

# add apt resources
# CMAKE

RUN apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common && \
    add-apt-repository -y ppa:george-edison55/cmake-3.x
