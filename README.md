# SSIP-Sherlock
Sistema di supporto alle indagini di polizia che si occupa, data le prove e testimonianze fornite, di rilevare le contraddizioni fra esse

# Comandi per creazione immagine e container docker
- Assicurarsi che docker sia attivo (impostare la creazione di immagini e container Linux se si utilizza Windows come SO)
- Accedere alla cartella contenente i file di questo repository dopo averlo clonato
  tramite linea di comando
## Costruzione immagine
docker build . -t "nome immagine" (es.supporto-indagini-polizia)
## Esecuzione container
docker run -d -p "porta estera":"porta interna"(es. 444:8000) "nome immagine" <br />
NOTA: impostare la porta 8000 come porta intera del container essendo che nel comando di esecuzione del sistema di supporto (all'interno del Dockerfile) viene selezionata la suddetta porta
## Credenziali per l'accesso
### Amministratore
Nome utente: admin <br />
Password: admin
### Utente normale
Nome utente: user1 <br />
Password: user1
