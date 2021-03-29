FROM scnakandala/dsc102-pa2-spark:latest

RUN apt-get update && \
    apt-get install python3.8 \
		    git \
                    iputils-ping \
                    dnsutils \
                    wget -y

RUN chmod 777 / && \
    chmod 666 /etc/hosts && \
    mkdir -p /opt/spark/work && \
    chmod 777 -R /opt/spark/work

RUN rm -rf /usr/bin/python3 && \
    ln -s /usr/bin/python3.8 /usr/bin/python3

RUN wget -O /tmp/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    chmod +x /tmp/miniconda.sh && \
    /bin/bash /tmp/miniconda.sh -b -p /opt/conda

ENV PATH=/opt/conda/bin:$PATH
COPY base.yml /tmp
RUN conda env update --file /tmp/base.yml && \
    conda init bash

RUN /opt/conda/bin/pip3 install jupyter_core nbgrader==0.6.1 && \
    /opt/conda/bin/jupyter nbextension install --symlink --sys-prefix --py nbgrader && \
    /opt/conda/bin/jupyter nbextension enable --sys-prefix --py nbgrader && \
    /opt/conda/bin/jupyter serverextension enable --sys-prefix --py nbgrader

COPY spark-master /
RUN chmod 755 /spark-master /spark-worker && \
    /opt/conda/bin/pip3 install jupyterhub==0.9.2 pyspark==2.4.4

RUN useradd spark -m && \
    chown -R spark:spark /home/spark
