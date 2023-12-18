var container1 = document.querySelector("#id_lista");
var container2 = document.querySelector("#id_lista1");
var lista_collega = fetch("/infojs").then(res => res.json()).then(data => visualizza_collega(data));
var txt_collega = "";

//Funzione che crea una stringa che servirà per mostrare le informazioni in un menù a tendina nella pagina HTML
function visualizza_collega(data)
{
            for (x in data) {

                txt_collega += "<option value=\""+ data[x]+ "\"> ";

            }

            container1.innerHTML=txt_collega;
            container2.innerHTML=txt_collega;


}