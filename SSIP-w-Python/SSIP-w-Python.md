# SSIP-w-Python
Implementazione del supporto alle indagini di polizia PROLOG usando un'interfaccia Python

##  Carica caso
La schermata iniziale consente di caricare un caso da analizzare o, se questo non è presente, caricarne uno nuovo.
Ci sono 2 casi demo già creati  
- SSIP-andreotti  
- CasoWanninger-demo  
- CasoWanninger-Incompleto  
*SSIP-andreotti* presenta un semplice caso con poche informazioni inserite. 
*CasoWanninger-demo* presenta dinamiche più complesse con più informazioni e relazioni tra di esse per testare i limiti del software.
*CasoWanninger-Incompleto* è una versione più maneggevole in quanto più piccola del caso CasoWanninger-Demo.
## Menù principale

Quando è stato selezionato il caso ci si trova sul menù principale dal quale è possibile eseguire le varie operazioni: 
- ***Aggiungi informazione***
- ***Cancella informazione***
-  ***Informazioni fornite***
- ***Visualizza goods***

### Aggiungi informazione
Questa opzione consente di aggiungere nuove informazioni specificandone la fonte e la affidabilità a priori di questa.
Inoltre è possibile fare dei collegamenti logici tra le informazioni che sono già presenti nel database del caso o anche con nuove informazioni appena inserite.
Le relazioni logiche possibili sono:
 - implica (**->**)
 - se e solo se (**<->**)
 - and
 - or
 - non

Nel caso del "non" basterà spuntare il bottone e inserire solamente la seconda informazione lasciando vuota la prima.

### Cancella informazione
Questa opzione consente di rimuovere dal database una informazione fornita dagli utenti.

**Nota bene:** lo scopo è rimuovere solamente quelle informazioni che contengono che contengono un errore di battitura o di inserimento(ad esempio associate ad una fonte sbagliata). Se si rimuove un'informazione da cui è stato dedotto qualcosa o collegata a un'altra informazione, la valutazione dei goods potrebbe non essere più corretta.

### Visualizza fonti
Questa opzione permette di vedere tutte le fonti relative al caso con la loro attendibilità a priori, e per ognuna è possibile mostrare le informazioni fornite.

### Informazioni fornite
Questa opzione consente di visualizzare tutte le informazioni fornite relative al caso

### Mostra goods
Questa opzione consente di mostrare i goods (ovvero i differenti insiemi massimamente consistenti di informazioni) ordinati secondo diverse valutazioni:
- teoria delle belief function di  Dempster–Shafer
- media delle credibilità delle affermazioni
- valore di Best Out


<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE3ODY2Njk5MjNdfQ==
-->