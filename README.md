# Foundry Archive Binaries
Sourced from https://github.com/foundry-rs/foundry/pkgs/container/foundry/versions?filters%5Bversion_type%5D=tagged

This repo contains a list of build amd64 binaries that we can use to lock to a specific nightly buld without needing to recompile.

## How to generate a set of binaries
You must have Docker installed
1. Pick the nightly build you want from [here](https://github.com/foundry-rs/foundry/pkgs/container/foundry/versions?filters%5Bversion_type%5D=tagged)
2. Run `docker pull ghcr.io/foundry-rs/foundry:nightly-<HASH>`
3. Run `docker images` to identify the IMAGE ID
4. Run `docker run --rm -it --entrypoint <IMAGE ID>`
5. Now, within the docker instance, run `cd /usr/local/bin`, then `tar -czvf /tmp/foundry_nightly_linux_amd64.tar.gz *`
6. Grab the tar.gz out of the docker instance and upload it to this repo.  Then create a release

You can now use it by running the following commands to install within a Dockerfile (Replace `<HASH>` with the hash you made a release with)
```
ENV FOUNDRY_RELEASE_TAG=0.2.0-<HASH>
ENV FOUNDRY_RELEASE_URL="https://github.com/manifoldxyz/foundry-bin/releases/download/${FOUNDRY_RELEASE_TAG}/"
ENV FOUNDRY_BIN_TARBALL_URL="${FOUNDRY_RELEASE_URL}foundry_nightly_linux_amd64.tar.gz"
ENV FOUNDRY_MAN_TARBALL_URL="${FOUNDRY_RELEASE_URL}foundry_nightly_linux_amd64.tar.gz"
RUN mkdir -p /root/.foundry/bin
RUN mkdir -p /root/.foundry/share/man/man1
RUN curl -# -L $FOUNDRY_BIN_TARBALL_URL | tar -xzC /root/.foundry/bin
RUN curl -# -L $FOUNDRY_MAN_TARBALL_URL | tar -xzC /root/.foundry/share/man/man1
ENV PATH="${PATH}:/root/.foundry/bin"
RUN echo >> /root/.bashrc && echo "export PATH=\"\$PATH:/root/.foundry/bin\"" >> /root/.bashrc
```