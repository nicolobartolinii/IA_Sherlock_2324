// Chiamata iniziale per ricevere i dati degli universi
fetch('/goodsjs')
    .then(res => res.json())
    .then(data => {
        const mainContainer = document.getElementById('main-container'); // Assicurati che questo elemento esista nel tuo HTML

        data.forEach((universo, index) => {
            const id = universo[0];
            const mediaDS = universo[1]; // Suppongo che questo sia il valore D-S

            // Crea un titolo per la tabella dell'universo
            const universeTitle = document.createElement('h3');
            universeTitle.textContent = `Universo numero ${index + 1} - Media D-S: ${mediaDS}`;
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
            fetch('/goods_DSjs', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({'idgood': id})
            })
            .then(res => res.json())
            .then(details => {
                let totalCredibility = 0;
                let numberOfDetails = 0;

                // Crea le righe della tabella per ogni informazione e credibilità
                for (const [key, value] of Object.entries(details)) {
                    const row = document.createElement('tr');
                    row.innerHTML = `
                        <td class="border-b border-r border-gray-400 px-4 py-2">${key}</td>
                        <td class="border-b border-gray-400 px-4 py-2">${value}</td>
                    `;
                    tbody.appendChild(row);

                    totalCredibility += parseFloat(value); // Assicurati che i valori siano numeri
                    numberOfDetails++;
                }

                // Calcola e mostra la media delle credibilità
                if (numberOfDetails > 0) {
                    const mediaCredibilita = totalCredibility / numberOfDetails;
                    const rowMedia = document.createElement('tr');
                    rowMedia.innerHTML = `
                        <tr class="bg-gray-100">
                            <td class="border-r border-gray-400 px-4 py-2 font-bold">Media Credibilità</td>
                            <td class="border-gray-400 px-4 py-2 font-bold">${mediaCredibilita.toFixed(2)}</td>
                        </tr>
                    `;
                    tbody.appendChild(rowMedia);
                }
            })
            .catch(error => {
                console.error('Error fetching details:', error);
            });
        });
    })
    .catch(error => {
        console.error('Error fetching universes:', error);
    });
