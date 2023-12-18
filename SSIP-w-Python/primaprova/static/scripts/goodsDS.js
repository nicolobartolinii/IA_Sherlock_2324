//Attraverso una fetch che richiama la route goodsMediajs, va a prendere i goods da Prolog, tramite Python,
//per poi visualizzarli in più tabelle in base al valore D-S
var container = document.querySelector("#id_good");

data1=fetch("/goodsjs").then(res => res.json()).then(data => visualizza1(data));
var count=1;
var id;
var conta=0;
var txt ="";
function visualizza1(data)
        {   for (y in data){
                    id=parseInt(data[y][0]);
                    sleep(0.06);
                    var good = {
                        'idgood': id
                        };
                        fetch('/goods_DSjs', {
                        method: 'POST',
                        body: JSON.stringify({
                        "idgood": id
                        })
                        }).then(res => res.json()).then(data1 =>{
                            var somma=0;
                            var i=0;
                            txt+="<h1> Universo numero " +count+ " : </h1> <table  border=”1″ width=70%> ";
                            txt+="<tr bgcolor=”#ad93ab″> <td > D_S  </td> <td> <strong>"+data[conta][1]+" </strong> </td> </tr>"
                            txt+="<tr bgcolor=”#ee07ba″> <td > Informazione  </td> <td> Credibilità </td> </tr> "
                            console.log(data[conta][1]);
                            for (x in data1) {
                                    txt +="<tr> <td>" + x + " </td> <td> " + data1[x] +" </td> </tr> " ;
                                    somma+=data1[x];
                                    i+=1;
                            }
                         media=somma/i;
                         txt+="<tr> <td bgcolor=”#ee07ba″> Media  </td> <td> <strong>"+ media +" </strong> </td> </tr>"
                        txt += " </table>";
                        container.innerHTML= txt ;
                        count+=1;
                        conta+=1;
                        });
                        }
                                       }


function sleep(s){
  var now = new Date().getTime();
  while(new Date().getTime() < now + (s*1000)){ /* non faccio niente */ }
}

