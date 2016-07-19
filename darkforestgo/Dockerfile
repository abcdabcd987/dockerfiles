# DarkforestGo
# run locally:
#     nvidia-docker run --rm -it lqchen/darkforestgo /start.sh --help
# run over ssh:
#     ssh yourserver nvidia-docker run --rm -i lqchen/darkforestgo /start.sh --help


FROM nvidia/cuda:7.5-cudnn5-devel

MAINTAINER Lequn Chen <i@abcdabcd987.com>

RUN sed -i "s/archive.ubuntu.com/ftp.sjtu.edu.cn/g" /etc/apt/sources.list

# Install Dependency
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        git \
        software-properties-common

# Install Torch 7
RUN git clone https://github.com/torch/distro.git ~/torch --recursive
RUN cd ~/torch && bash install-deps
RUN cd ~/torch && printf "y\n" | ./install.sh

# Install the Torch cuDNN v4 bindings
RUN git clone -b R4 https://github.com/soumith/cudnn.torch.git ~/cudnn.torch
RUN bash -c ". ~/torch/install/bin/torch-activate && cd ~/cudnn.torch && \
    luarocks make && \
    rm -rf ~/cudnn.torch"

# Install a few packages
RUN bash -c ". ~/torch/install/bin/torch-activate && \
    luarocks install class && \
    luarocks install image && \
    luarocks install tds   && \
    luarocks install cudnn"

# Install darkforestGo
RUN git clone https://github.com/facebookresearch/darkforestGo.git ~/darkforestGo
RUN cd ~/darkforestGo && sh ./compile.sh && mkdir -p /data/local/go
COPY models /root/darkforestGo/models
COPY start.sh /

# Run server
CMD /start.sh
