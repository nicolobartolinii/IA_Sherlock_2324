//Script che va a creare la tabella avente al suo interno le informazioni
const container = document.querySelector("tbody");
const lista = fetch("/infojs").then(res => res.json()).then(data => visualizza(data));

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
            <td class="${borderClasses} border-gray-400 px-4 py-2 ${isLastKey ? 'rounded-br-md' : ''}">${data[key]}</td>
        </tr>
    `;
    });

    // Imposta l'HTML interno del corpo della tabella con le righe appena create
    container.innerHTML = rows;
}