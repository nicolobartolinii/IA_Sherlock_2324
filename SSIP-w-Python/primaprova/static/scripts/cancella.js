//Script che mostra le assersioni dal database prolog
var container = document.querySelector("#id_info");
var lista = fetch("/cancellajs").then(res => res.json()).then(data => visualizza(data));
var txt = "";

function visualizza(data)
{
            txt+="<table  border=”1″ width=70%> <tr bgcolor=”#ad93ab″ > <td > N*  </td> <td> Informazione </td> </tr> "
            for (x in data) {

                txt +="<tr> <td>" +x+ " </td> <td> " + data[x] +" </td> </tr> " ;

            }
            txt += " </table>";
            container.innerHTML=txt;
			txt="";
}
