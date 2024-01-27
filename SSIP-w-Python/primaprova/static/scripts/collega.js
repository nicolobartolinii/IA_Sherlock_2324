const tabella = document.querySelector("tbody");
const container1 = document.querySelector("#primaInfo");
const container2 = document.querySelector("#secondaInfo");
const inputAttendibFonte = document.getElementById("attendibFonte");
const inputAttendibFonteCollega = document.getElementById("attendibFonteCollegamento");
const inputNomeFonte = document.getElementById("nomeFonte");
const inputNomeFonteCollegamento = document.getElementById("nomeFonteCollegamento");
const elenco_fonti_datalist = document.getElementById("elenco_fonti");
const info_complete = fetch("/cancellajs").then(res => res.json()).then(data => visualizza(data));
const lista = fetch("/infojs").then(res => res.json()).then(data => popolaSelect(data));
const elenco_fonti = fetch("/fontijs").then(res => res.json()).then(data => popolaElencoFonti(data));
let opzioni = "";
let opzioni_fonti = "";

//Funzione che crea una stringa che servirà per mostrare le informazioni in un menù a tendina nella pagina HTML
function visualizza(data) {
    // Converti il dizionario in un array di chiavi
    const keys = Object.keys(data);
    const lastKeyIndex = keys.length - 1; // Indice dell'ultima chiave

    // Stringa che conterrà il markup HTML delle righe della tabella
    let rows = "";

    keys.forEach((key, index) => {
        const isLastKey = index === lastKeyIndex;
        // Aggiungi le classi per il bordo solo se non è l'ultimo elemento
        const borderClasses = isLastKey ? "" : "border-b";

        // Crea una nuova riga della tabella per ogni chiave
        rows += `
        <tr class="hover:bg-gray-100">
            <td class="${borderClasses} border-r border-gray-400 px-4 py-2 ${isLastKey ? 'rounded-bl-md' : ''}">${index + 1}</td> <!-- Index + 1 come Case ID -->
            <td class="${borderClasses} border-r border-gray-400 px-4 py-2">${data[key]}</td>
            <td class="${borderClasses} border-gray-400 px-4 py-2 ${isLastKey ? 'rounded-br-md' : ''}"><form action="/cancella_info" method="post" id="form_cancella_info"><input name="informazione" type="hidden" min="1" max="${keys.length}" value="${index + 1}"/><button type="submit" onclick="eliminaInformazione()" class="inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 bg-red-500 text-white hover:bg-red-600 active:bg-red-700 h-10 px-4 py-2 mx-2">Elimina informazione</button></form></td>
        </tr>
    `;
    });

    // Imposta l'HTML interno del corpo della tabella con le righe appena create
    tabella.innerHTML = rows;
}

//Funzione che crea una stringa che servirà per popolare i menù a tendina nella pagina HTML
function popolaSelect(data) {
    // Converti il dizionario in un array di chiavi
    const keys = Object.keys(data);
    const lastKeyIndex = keys.length - 1; // Indice dell'ultima chiave

    // Stringa che conterrà il markup HTML delle righe della tabella
    let rows = "";

    keys.forEach((key, index) => {
        const isLastKey = index === lastKeyIndex;
        // Aggiungi le classi per il bordo solo se non è l'ultimo elemento
        const borderClasses = isLastKey ? "" : "border-b";

        // Crea una nuova riga della tabella per ogni chiave
        opzioni += `
        <option value="${data[key]}">${data[key]}</option>
    `;
    });

    // Imposta l'HTML interno del corpo della tabella con le righe appena create
    container1.innerHTML = opzioni;
    container2.innerHTML = opzioni;
}

//Funzione che crea una stringa che servirà per popolare l'elenco delle fonti nella pagina HTML
function popolaElencoFonti(data) {
    // Converti il dizionario in un array di chiavi
    const keys = Object.keys(data);
    const lastKeyIndex = keys.length - 1; // Indice dell'ultima chiave

    // Stringa che conterrà il markup HTML delle righe della tabella
    let rows = "";

    keys.forEach((key, index) => {
        // Crea una nuova riga della tabella per ogni chiave
        opzioni_fonti += `
        <option value="${key}">${key}</option>
    `;
    });

    // Imposta l'HTML interno del corpo della tabella con le righe appena create
    elenco_fonti_datalist.innerHTML = opzioni_fonti;


    inputNomeFonte.addEventListener("input", function() {
        if (keys.includes(inputNomeFonte.value)) {
            inputAttendibFonte.value = data[inputNomeFonte.value];
        }
    });

    inputNomeFonteCollegamento.addEventListener("input", function() {
        if (keys.includes(inputNomeFonteCollegamento.value)) {
            inputAttendibFonteCollega.value = data[inputNomeFonteCollegamento.value];
        }
    });
}

document.addEventListener("DOMContentLoaded", function () {
    const connectors = document.querySelectorAll(".---connector");
    const firstInfoSelect = document.getElementById("primaInfo"); // Aggiungi l'id corretto del tuo primo select
    const submitButton = document.getElementById("buttonCollega");
    const notSelectedMessage = document.getElementById("not-selected-message");

    connectors.forEach((connector) => {
        connector.addEventListener("click", function () {
            if (connector.classList.contains("bg-cyan-400/50")) {
                connectors.forEach((c) => c.classList.remove("bg-cyan-400/50"));
                firstInfoSelect.disabled = false;
                return;
            }
            // Rimuovi la classe selected da tutti i connettori
            connectors.forEach((c) => c.classList.remove("bg-cyan-400/50"));

            // Aggiungi la classe selected al connettore cliccato
            connector.classList.add("bg-cyan-400/50");

            //let oldValue = firstInfoSelect.value;
            // Se il connettore è NOT, disabilita il primo select
            //firstInfoSelect.value = connector.getAttribute("data-connector-type") === "non" ? "" : oldValue;
            if (connector.getAttribute("data-connector-type") === "non") {
                container1.classList.add("bg-red-500");
                notSelectedMessage.classList.toggle("hidden");
            }

            // Sblocca il pulsante di submit
            submitButton.disabled = false;

            // Imposta il valore del connettore selezionato (assumi di avere un input nascosto per questo)
            document.getElementById("selected-connector-input").value =
                connector.getAttribute("data-connector-type");
        });
    });
});

function eliminaInformazione() {
    alert("Informazione eliminata con successo!")
}