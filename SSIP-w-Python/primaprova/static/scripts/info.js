//Script che va a creare la tabella avente al suo interno le informazioni
var container = document.querySelector("#id_info");
var lista = fetch("/infojs").then(res => res.json()).then(data => visualizza(data));
var txt = "";
var numero = 1;
function visualizza(data)
{
            txt+="<table border=”10px″ width=70%> <tr bgcolor=”#ad93ab″ > <td > <h3>N° </h3> </td> <td> <h3>Informazione </h3></td> </tr> "
            for (x in data) {

                txt +="<tr> <td>" +numero+ " </td> <td> " + data[x] +" </td> </tr> " ;
                numero++;
            }
            txt += " </table> <br>";
            container.innerHTML=txt;
            txt="";
}