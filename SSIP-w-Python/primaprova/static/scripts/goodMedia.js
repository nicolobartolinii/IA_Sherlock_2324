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
            universeTitle.textContent = `Universo numero ${index + 1} - Media: ${media.toFixed(3)} (${(media * 100).toFixed(1)}%)`;
            universeTitle.className = 'text-2xl font-bold mb-4';

            // Crea la tabella per questo universo
            const table = document.createElement('table');
            table.className = 'w-full table-auto border-collapse rounded-md border border-separate border-tools-table-outline border-gray-400 border-1 border-spacing-0';

            // Aggiungi intestazione alla tabella
            const thead = document.createElement('thead');
            thead.className = 'bg-gray-200 rounded-md';
            thead.innerHTML = `
                <tr>
                    <th class="border-b border-r border-gray-400 px-4 py-2 rounded-tl-md">Informazione</th>
                    <th class="border-b border-gray-400 px-4 py-2 rounded-tr-md">Credibilità</th>
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
                let rows = "";
                const keys = Object.keys(details); // Aggiunta della dichiarazione di 'keys'

                keys.forEach((key, index) => {
                    const credibility = details[key];
                    const credibilityPercentage = (credibility * 100).toFixed(1);
                    let bgColorClass = '';
                    if (credibilityPercentage >= 75) {
                        bgColorClass = 'bg-emerald-300 hover:bg-emerald-400';
                    } else if (credibilityPercentage >= 50) {
                        bgColorClass = 'bg-blue-200 hover:bg-blue-300';
                    } else if (credibilityPercentage >= 25) {
                        bgColorClass = 'bg-yellow-200 hover:bg-yellow-300';
                    } else {
                        bgColorClass = 'bg-red-200 hover:bg-red-300';
                    }

                    const isLastKey = index === keys.length - 1;

                    // Crea una nuova riga della tabella per ogni chiave
                    rows += `
                        <tr class="${bgColorClass}">
                            <td class="border-r border-gray-400 px-4 py-2 ${isLastKey ? 'rounded-bl-md' : 'border-b'}">${key}</td>
                            <td class="border-gray-400 px-4 py-2 ${isLastKey ? 'rounded-br-md' : 'border-b'}">${credibility.toFixed(3)} (${credibilityPercentage}%)</td>
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
