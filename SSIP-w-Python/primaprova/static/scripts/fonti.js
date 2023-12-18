var container = document.querySelector("#id_fonti");
var container1=document.querySelector("#nomiFonti");
var lista = fetch("/fontijs").then(res => res.json()).then(data => visualizza(data));
var txt = "";
var txt1= "";

//Funzione che crea una stringa che servirà per mostrare le fonti e le loro relative attendibilità in un menù a tendina nella pagina HTML
//La funzione crea anche una stringa che andrà a rappresentare la tabella in HTML, con i dati al suo interno
function visualizza(data)
{
                txt+="<table  border=”1″ width=70%><tr bgcolor=”#ad93ab″ > <td > Fonte  </td> <td width=25%> Attendibilità </td> </tr> "
            for (x in data) {
                txt +="<tr> <td>" + x + " </td> <td> " + data[x] +" </td> </tr> " ;

                txt1 += "<option value=\""+x+"\">"+ x   +"</option>";
            }
            txt += " </table> </h1>";
            container.innerHTML=txt;
            container1.innerHTML=txt1;
}
