FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

# Installazioni:
# python 3.8
# gunicorn: consente di attivare il servizio server 
# swi-prolog: necessario per il corretto funzionamento della libreria pyswip
RUN apt update -y && \
    apt install swi-prolog -y && \
    apt install python3.8 -y && \ 
    apt install gunicorn -y

# comando pip per importare le librerie
RUN apt install python3-pip -y

# Inserimento del codice e del file testuale contenente elenco di librerie
COPY . / 

RUN pip3 install --upgrade pip

# Installazione di tutte le librerie necessarie equivale a:
# RUN pip3 install pyswip flask flask_sqlalchemy flask_login flask_wtf wtforms flask_bcrypt
RUN pip3 install -r requirements.txt

#Cambio della cartella di lavoro per eseguire il comando gunicorn
WORKDIR /SSIP-w-Python/primaprova

CMD ["gunicorn" , "-w", "3", "-b", "0.0.0.0:8000", "main:app"]
