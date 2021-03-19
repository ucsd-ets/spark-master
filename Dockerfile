FROM scnakandala/dsc102-pa2-spark:latest

RUN apt-get update && \
    apt-get install python3.8 \
                    wget -y

RUN rm -rf /usr/bin/python3 && \
    ln -s /usr/bin/python3.8 /usr/bin/python3

RUN wget -O /tmp/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    chmod +x /tmp/miniconda.sh && \
    /bin/bash /tmp/miniconda.sh -b -p /opt/conda

ENV PATH=$PATH:/opt/conda/bin
COPY base.yml /tmp
RUN conda env update --file /tmp/base.yml
RUN conda init bash

RUN /opt/conda/bin/pip3 install jupyter_core nbgrader==0.6.1 && \
    /opt/conda/bin/jupyter nbextension install --symlink --sys-prefix --py nbgrader && \
    /opt/conda/bin/jupyter nbextension enable --sys-prefix --py nbgrader && \
    /opt/conda/bin/jupyter serverextension enable --sys-prefix --py nbgrader