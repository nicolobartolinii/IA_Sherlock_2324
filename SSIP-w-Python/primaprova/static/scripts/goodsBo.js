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
            universeTitle.textContent = `Universo numero ${index + 1} - Media BO: ${media.toFixed(3)} (${(media * 100).toFixed(1)}%)`;
            universeTitle.className = 'text-2xl font-bold mb-4';

            // Crea la tabella per questo universo
            const table = document.createElement('table');
            table.className = 'w-full table-auto border-collapse rounded-md border border-separate border-gray-400';

            // Aggiunge intestazione alla tabella
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
                    let rows = "";
                    let totalCredibility = 0; // Inizializza una variabile per la somma delle credibilità

                    Object.entries(details).forEach(([key, credibility], index) => {
                        totalCredibility += credibility; // Aggiungi la credibilità corrente alla somma totale
                        const isLastKey = index === Object.keys(details).length - 1;
                        const borderClasses = isLastKey ? "" : "border-b";
                        const credibilityPercentage = (credibility * 100).toFixed(1);
                        let bgColorClass = '';
                        if (credibilityPercentage >= 75) {
                            bgColorClass = 'bg-emerald-300';
                        } else if (credibilityPercentage >= 50) {
                            bgColorClass = 'bg-blue-200';
                        } else if (credibilityPercentage >= 25) {
                            bgColorClass = 'bg-yellow-200';
                        } else {
                            bgColorClass = 'bg-red-200';
                        }

                        // Crea una nuova riga della tabella per ogni chiave
                        rows += `
                            <tr class="${bgColorClass} hover:bg-gray-100">
                                <td class="${borderClasses} border-r border-gray-400 px-4 py-2">${key}</td>
                                <td class="${borderClasses} border-gray-400 px-2 py-2">${credibility.toFixed(3)} (${credibilityPercentage}%)</td>
                            </tr>
                        `;
                    });

                    const media = totalCredibility / Object.keys(details).length; // Calcola la media delle credibilità
                    // Aggiunge la riga per la media alla tabella
                    rows += `
                        <tr class="bg-gray-100">
                            <td class="border-r border-gray-400 px-4 py-2 rounded-bl-md">Media</td>
                            <td class="border-gray-400 px-2 py-2 ">${media.toFixed(3)} (${(media * 100).toFixed(1)}%)</td>
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
