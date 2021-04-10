FROM debian:latest

RUN apt-get update \
    && apt-get install -y \
        redis-tools \
        wget

RUN mkdir /scripts
COPY ./run.sh /scripts
RUN chmod +x /scripts/run.sh
WORKDIR /scripts

# Ici on pourra basculer demo à prod si on a au moins 16Gb de RAM disponible sur l'hôte ;-p
ENTRYPOINT [ "./run.sh", "demo" ]