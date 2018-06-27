FROM alpine:3.7

RUN apk update \
&& apk add \
    ca-certificates \
    libstdc++ \
    python3 \
&& apk add --virtual=build_dependencies \
    cmake \
    gcc \
    g++ \
    make \
    musl-dev \
    python3-dev \
&& ln -s /usr/include/locale.h /usr/include/xlocale.h \
&& python3 -m pip --no-cache-dir install pip -U \
&& python3 -m pip --no-cache-dir install \
    jupyter==1.0.0 \
    jupyterlab==0.32.1 \
&& jupyter serverextension enable --py jupyterlab --sys-prefix \
&& apk del --purge -r build_dependencies \
&& rm -rf /var/cache/apk/*

# Port 8888 is the default used by Jupyter
# Other ports are exposed for potential future applications
EXPOSE 8888 8080 7000 6000 5000 4000

ENTRYPOINT jupyter lab --allow-root --no-browser --port=8888 --ip=0.0.0.0