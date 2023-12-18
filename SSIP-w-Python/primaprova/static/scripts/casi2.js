//var container1 = document.querySelector("#form1");
var container2 = document.querySelector("#nome_caso");
var lista = fetch("/casijs").then(res => res.json()).then(data => visualizza(data));
var txt = "";

//Funzione che crea una stringa che servirà per mostrare le informazioni in un menù a tendina nella pagina HTML
function visualizza(data)
{
            for (x in data) {

                txt += "<option value=\""+ data[x]+"\"> "+ data[x]   +"</option>";

            }

            //container1.innerHTML=txt;
            container2.innerHTML=txt;


}