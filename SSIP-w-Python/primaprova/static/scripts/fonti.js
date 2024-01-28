const tabellaFontiTbody = document.getElementById("tabella-fonti-tbody");
const tabellaDettagliTbody = document.getElementById("tabella-dettagli-tbody");
const sectionDettagli = document.querySelector(".---sezione-dettagli");
const titoloDettagli = document.getElementById("titolo-dettagli-fonte");
const lista = fetch("/fontijs").then(res => res.json()).then(data => visualizza(data));

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
            <td class="${borderClasses} border-r border-gray-400 px-4 py-2 ${isLastKey ? 'rounded-bl-md' : ''}">${key}</td> <!-- Index + 1 come Case ID -->
            <td class="${borderClasses} border-r border-gray-400 px-4 py-2">${data[key]}</td>
            <td class="${borderClasses} border-gray-400 px-2 py-2 ${isLastKey ? 'rounded-br-md' : ''}">
                <div class="flex justify-center">
                    <button onclick="chiamaDettagliFonte('${key}')" class="inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 bg-green-400 text-black hover:bg-green-500 active:bg-green-600 h-10 px-4 py-2 mx-2">Vedi info fornite</button>
                </div>
            </td>
        </tr>
    `;
    });

    // Imposta l'HTML interno del corpo della tabella con le righe appena create
    tabellaFontiTbody.innerHTML = rows;
}

function chiamaDettagliFonte(nomeFonte) {
    if (!sectionDettagli.classList.contains("hidden")) {
        sectionDettagli.classList.add("hidden");
    }
    tabellaDettagliTbody.innerHTML = "";
    titoloDettagli.innerHTML = `Informazioni fornite da: ${nomeFonte}`;

    fetch('/info_fontejs', {
        method: 'POST',
        body: JSON.stringify({"idfonte": nomeFonte})
    }).then(res => res.json()).then(data => mostra(data));
}

function mostra(data) {
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
            <td class="${borderClasses} border-r border-gray-400 px-4 py-2 ${isLastKey ? 'rounded-bl-md' : ''}">${key}</td>
            <td class="${borderClasses} border-r border-gray-400 px-4 py-2 ${isLastKey ? 'rounded-br-md' : ''}">${data[key]}</td>
        </tr>
        `;
    });

    // Imposta l'HTML interno del corpo della tabella con le righe appena create
    tabellaDettagliTbody.innerHTML = rows;
    sectionDettagli.classList.remove("hidden");
}