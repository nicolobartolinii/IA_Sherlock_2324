//Script che va a creare la tabella avente all'interno informazione e credibilità della fonte scelta in precendenza
var container1 = document.querySelector("#id_info_fonte");
fetch("/info_fontejs").then(res => res.json()).then(data => mostra(data));
var txt = "";
function mostra(data)
{
            txt+="<table  border=”1″ width=70%><tr bgcolor=”#ad93ab″ > <td > Fonte  </td> <td width=25%> Attendibilità </td> </tr> "
            for (x in data) {
                txt +="<tr> <td>" + x + " </td> <td> " + data[x] +" </td> </tr> " ;
            }
            txt += " </table> </h1>";
            container1.innerHTML=txt;
}