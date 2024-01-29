// Chiamata iniziale per ricevere i dati degli universi
fetch('/goodsMediajs')
    .then(res => res.json())
    .then(data => {
        const mainContainer = document.getElementById('main-container'); // Assicurati che questo elemento esista nel tuo HTML

        data.forEach((universo, index) => {
            const id = universo[0];
            const media = universo[1];

            // Crea un titolo per la tabella dell'universo
            const universeTitle = document.createElement('h3');
            universeTitle.textContent = `Universo numero ${index + 1} - Media: ${media}`;
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
            fetch('/goods_Mediajs', {
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
                    const lastKeyIndex = keys.length - 1; // Indice dell'ultima chiave
                    let rows = "";
                    keys.forEach((key, index) => {
                        const isLastKey = index === lastKeyIndex;
                        // Aggiungi le classi per il bordo solo se non è l'ultimo elemento
                        const borderClasses = isLastKey ? "" : "border-b";

                        // Crea una nuova riga della tabella per ogni chiave
                        rows += `
        <tr class="hover:bg-gray-100">
            <td class="${borderClasses} border-r border-gray-400 px-4 py-2 ${isLastKey ? 'rounded-bl-md' : ''}">${key}</td> <!-- Index + 1 come Case ID -->
            <td class="${borderClasses} border-gray-400 px-2 py-2 ${isLastKey ? 'rounded-br-md' : ''}">${details[key]}</td>
        </tr>
    `;
                    });
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
