FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

# Installazione di dipendenze
RUN apt update -y && \
    apt install -y software-properties-common && \
    add-apt-repository ppa:swi-prolog/stable && \
    apt install -y swi-prolog && \
    apt install -y python3.8 python3-pip

# Copia dei file nel container
COPY . /

# Installazione delle dipendenze Python
RUN pip3 install --upgrade pip && \
    pip3 install -r requirements.txt

# Settaggio della variabile PYTHONUNBUFFERED per evitare problemi di buffering nei log
ENV PYTHONUNBUFFERED=1

WORKDIR /SSIP-w-Python/primaprova

# Comando per avviare l'applicazione
CMD ["gunicorn", "-w", "3", "-b", "0.0.0.0:8000", "main:app"]
