FROM scnakandala/dsc102-pa2-spark:latest

RUN apt-get update && \
    apt-get install git \
                    iputils-ping \
                    dnsutils \
                    wget -y

RUN chmod 777 / && \
    chmod 666 /etc/hosts && \
    mkdir -p /opt/spark/work && \
    chmod 777 -R /opt/spark/work


COPY spark-master /
RUN chmod 755 /spark-master /spark-worker

RUN useradd spark -m && \
    chown -R spark:spark /home/spark
