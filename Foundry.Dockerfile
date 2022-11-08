FROM public.ecr.aws/docker/library/node:18-slim
RUN apt-get update
RUN apt-get --assume-yes install bash git curl build-essential

SHELL ["/bin/bash", "-c"]
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH=$PATH:/root/.cargo/bin
RUN curl -L https://foundry.paradigm.xyz | bash
ENV PATH=$PATH:/root/.foundry/bin
RUN /root/.foundry/bin/foundryup -C 3834c05
# WORKDIR /app

ENTRYPOINT ["bash"]
