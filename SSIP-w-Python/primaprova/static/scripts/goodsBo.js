// Chiamata iniziale per ricevere i dati degli universi
// Chiamata iniziale per ricevere i dati degli universi
fetch("/numerogoodsBOjs")
    .then(res => res.json())
    .then(data => {
        console.log(data);
        const mainContainer = document.getElementById('main-container'); // Assicurati che questo elemento esista nel tuo HTML

        Object.keys(data).forEach((key, index) => {
            const id = key;
            const media = data[key];

            // Crea un titolo per la tabella dell'universo
            const universeTitle = document.createElement('h3');
            universeTitle.textContent = `Universo numero ${index + 1} - Media BO: ${media}`;
            universeTitle.className = 'text-2xl font-bold mb-4';

            // Crea la tabella per questo universo
            const table = document.createElement('table');
            table.className = 'w-full table-auto border-collapse rounded-md border border-separate border-gray-400';

            // Aggiungi intestazione alla tabella
            const thead = document.createElement('thead');
            thead.className = 'bg-gray-200';
            thead.innerHTML = `
                <tr>
                    <th class="border-b border-r border-gray-400 px-4 py-2">Informazione</th>
                    <th class="border-b border-gray-400 px-4 py-2">Credibilità</th>
                </tr>
            `;

            // Aggiungi il tbody alla tabella
            const tbody = document.createElement('tbody');
            tbody.id = `details-${id}`;
            table.appendChild(thead);
            table.appendChild(tbody);

            // Aggiungi il titolo e la tabella al contenitore principale
            mainContainer.appendChild(universeTitle);
            mainContainer.appendChild(table);

            // Effettua la fetch per ottenere i dettagli di questo universo
            fetch('/goods_BOjs', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json'
    },
    body: JSON.stringify({'idgood': id})
})
    .then(res => res.json())
    .then(details => {
        console.log(details);
        const keys = Object.keys(details);
        const lastKeyIndex = keys.length ; // Indice dell'ultima chiave
        let rows = "";
        let totalCredibility = 0; // Inizializza una variabile per la somma delle credibilità

        keys.forEach((key, index) => {
            const credibility = details[key];
            totalCredibility += credibility; // Aggiungi la credibilità corrente alla somma totale
            const isLastKey = index === lastKeyIndex;
            // Aggiungi le classi per il bordo solo se non è l'ultimo elemento
            const borderClasses = isLastKey ? "" : "border-b";

            // Crea una nuova riga della tabella per ogni chiave
            rows += `
                <tr class="hover:bg-gray-100">
                    <td class="${borderClasses} border-r border-gray-400 px-4 py-2 ${isLastKey ? 'rounded-bl-md' : ''}">${key}</td>
                    <td class="${borderClasses} border-gray-400 px-2 py-2 ${isLastKey ? 'rounded-br-md' : ''}">${credibility}</td>
                </tr>
            `;

        });

        const media = totalCredibility / keys.length; // Calcola la media delle credibilità
        // Aggiungi la riga per la media alla tabella
        rows += `
            <tr class="bg-gray-100">
                <td class="border-r border-gray-400 px-4 py-2 rounded-bl-md">Media</td>
                <td class="border-gray-400 px-2 py-2 ">${media.toFixed(2)}</td> <!-- Arrotonda la media a due cifre decimali -->
            </tr>
        `;

        tbody.innerHTML = rows;
    })
    .catch(error => {
        console.error('Error fetching details:', error);
    });
        });
    })
    .catch(error => {
        console.error('Error fetching universes:', error);
    });
