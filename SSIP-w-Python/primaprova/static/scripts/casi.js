// Seleziona il corpo della tabella dove vuoi inserire i dati
const tbody = document.querySelector("tbody");
const casellaTestoCaseTitle = document.getElementById('caseTitle');
const pulsanteCreaCaso = document.getElementById('pulsante-crea-caso');

// Fetch dei dati dal tuo endpoint Flask e chiamata della funzione per popolare la tabella
fetch("/casijs").then(res => res.json()).then(data => {
    visualizza(data);
    casellaTestoCaseTitle.addEventListener('input', () => {
        pulsanteCreaCaso.disabled = casellaTestoCaseTitle.value.length <= 0;
    });
    pulsanteCreaCaso.addEventListener('click', () => {
        const caso = casellaTestoCaseTitle.value;
        caricaCaso(caso);
    });
});

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
            <td class="${borderClasses} border-r border-gray-400 px-4 py-2">${key}</td>
            <td class="${borderClasses} border-gray-400 px-2 py-2 ${isLastKey ? 'rounded-br-md' : ''}">
                <div class="flex justify-center">
                    <button onclick="caricaCaso('${key}')" class="inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 bg-green-400 text-black hover:bg-green-500 active:bg-green-600 h-10 px-4 py-2 mx-2">Carica caso</button>
                    <button onclick="eliminaCaso('${key}')" class="inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 bg-red-500 text-white hover:bg-red-600 active:bg-red-700 h-10 px-4 py-2 mx-2">Elimina caso</button>
                </div>
            </td>
        </tr>
    `;
    });

    // Imposta l'HTML interno del corpo della tabella con le righe appena create
    tbody.innerHTML = rows;
}

// Aggiungi funzioni per gestire il caricamento e l'eliminazione dei casi
function caricaCaso(caso) {
    fetch('/carica_caso', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ Caso: caso })
    })
    .then(response => {
        if (response.ok) {
            return response.json(); // o response.text() se la risposta non è in JSON
        }
        throw new Error('Network response was not ok.');
    })
    .then(data => {
        console.log('Success:', data);
        // Qui puoi gestire il successo, come reindirizzare a una nuova pagina
        window.location.href = '/informazioni_fornite';
    })
    .catch(error => {
        console.error('Error:', error);
    });
}

function eliminaCaso(caso) {
    // Conferma prima di procedere all'eliminazione
    if (!confirm(`Sei sicuro di voler eliminare il caso "${caso}"?`)) {
        return;
    }

    // Invia la richiesta POST al server Flask
    fetch('/cancella_caso2', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: `Caso=${encodeURIComponent(caso)}`
    })
    .then(response => {
        if (response.ok) {
            fetch("/casijs").then(res => res.json()).then(data => visualizza(data));
        } else {
            throw new Error('La richiesta non è andata a buon fine.');
        }
    })
    .catch(error => {
        console.error('Si è verificato un errore:', error);
    });
}