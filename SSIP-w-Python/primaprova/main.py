from __future__ import print_function
from pyswip.prolog import Prolog
from flask import Flask, render_template, request, jsonify, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin, login_user, LoginManager, login_required, logout_user, current_user
from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField
from wtforms.validators import InputRequired, Length, ValidationError
from multiprocessing import Pool
from flask_bcrypt import Bcrypt
import os


#Permette di creare un API REST che permetterà la visualizzazione delle varie route grazie ad un web server
app = Flask(__name__, static_url_path='/static')
app.config['SECRET_KEY'] = 'IA2021Sherlock'
db = SQLAlchemy(app)
bcrypt = Bcrypt(app)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///database.db'

login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = "log_in"

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

@login_manager.unauthorized_handler
def unauthorized_callback():
    return render_template('error.html', e='Access denied')

class User(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(50), nullable=False, unique=True)
    password = db.Column(db.String(50), nullable=False)

db.create_all()

class RegisterForm(FlaskForm):
    username = StringField(validators=[InputRequired(), Length(
        min= 3, max=20)], render_kw={"placeholder": "Username"})
    password = PasswordField(validators=[InputRequired(), Length(
        min= 4, max=50)], render_kw={"placeholder": "Password"})

    submit = SubmitField("Registra")

    def validate_username(self, username):
        existing_user_username = User.query.filter_by(
            username=username.data).first()
        if existing_user_username:
            raise ValidationError(
                "Username già esistente, provane un altro."
            )

class LoginForm(FlaskForm):
    username = StringField(validators=[InputRequired(), Length(
        min= 3, max=50)], render_kw={"placeholder": "Username"})
    password = PasswordField(validators=[InputRequired(), Length(
        min= 4, max=50)], render_kw={"placeholder": "Password"})

    submit = SubmitField("Entra")

class DeleteForm(FlaskForm):
    username = StringField(validators=[InputRequired(), Length(
        min= 3, max=50)], render_kw={"placeholder": "Username"})
        
    submit = SubmitField("Cancella")

#la variabile prolog viene dichiarata globale per risolvere problemi di compatibilità multi-threding tra Python e Prolog
def pl_init():
    global prolog
    prolog = Prolog()
    prolog.consult("SSIP-main.pl")

#Cerca nel database prolog del caso in analisi tutte le informazioni delle varie fonti
def prendi_info():
    prolog.consult("SSIP-main.pl")
    informazioni = [ans["X"] for ans in prolog.query("atomica(X)")]
    print(informazioni)
    return informazioni

#Cerca nel database prolog del caso in analisi tutte le fonti che hanno fornito informazioni e le restituisce con le relative attendibilità
#inserendole all'interno di un Dict (dizionario in Python) dove la chiave è la fonte e il valore è l'attendibilità
def prendi_fonte():
    fonti={}
    prolog.consult("SSIP-main.pl")
    for ans in prolog.query("fonte(X,Y)"):
        fonti[ans["X"]] = ans["Y"]
    return fonti

#Cerca i nomi dei casi creati per poterli inserire nel menù a tendina della pagina per caricare i casi esistenti
def prendi_casi():
    casi_sporchi = next(os.walk("./casi"), (None, None, []))[2]
    casi = {}
    for caso in casi_sporchi:
        casi[caso[:-3]] = caso[:-3]
    return casi

#In prolog ogni good è etichettato con un numero crescente, per poter essere selezionato in maniera deterministica
#La funzione prende i goods, ordinati secondo Dempster-Shafer, in base all'args passato come parametro che indica che goods si vuole vedere
def prendi_goods_DS(args):
    numero = ""
    for a in args:
        numero += a
    goodsDS={}
    prolog.consult("SSIP-main.pl")
    for ans in prolog.query("goods_DS("+args+",X-Y)"):
        goodsDS[ans["X"]]=ans["Y"]
    return goodsDS

#In prolog ogni good è etichettato con un numero crescente, per poter essere selezionato in maniera deterministica
#La funzione prende i goods, ordinati secondo la media della credibilità, in base all'args passato come parametro che indica che goods si vuole vedere
def prendi_goods_media(args):
    numero = ""
    for a in args:
        numero += a
    goodsMedia={}
    prolog.consult("SSIP-main.pl")
    for ans in prolog.query("goods_media("+args+",X-Y)"):
        goodsMedia[ans["X"]]=ans["Y"]
    return goodsMedia

#La funzione prende i goods, ordinati secondo i Best Out, in base all'args passato come parametro che indica che goods si vuole vedere
def prendi_goods_BO(args):
    numero = ""
    for a in args:
        numero += a
    goodsBO={}
    prolog.consult("SSIP-main.pl")
    for ans in prolog.query("mostra_goodsBO("+args+",X-Y)"):
        goodsBO[ans["X"]]=ans["Y"]
    return goodsBO

#Permette di prendere le informazioni fornite da una fonte, che viene passata come args, grazie alla query prolog e le restituisce in
#un dict che ha come chiave la frase e come valore la credibilità di quella frase
def prendi_info_fonte(*args):
    fonte=""
    for a in args :
        fonte += a
    informazioni = {}
    prolog.consult("SSIP-main.pl")
    for ans in prolog.query("informazioni_fornite('"+fonte+"',X,Y)"):
        informazioni[ans["X"]] = ans["Y"]
    return informazioni

#La funzione prende in ingresso il numero di una asserzione e lo passa al predicato prolog per cancellarla
def rimuoviInfo(*args):
    info = ""
    for a in args:
        info += a
    prolog.consult("SSIP-main.pl")
    for i in prolog.query("cancella_info("+info+")"):
        continue
    return True
#Ritorna un dizionario che ha come chiave le etichette dei d_s e come valore il relativo valore ordinato in senso decrescente
def ordinaDS():
    goodsDS={}
    prolog = Prolog()
    prolog.consult("SSIP-main.pl")
    for ans in prolog.query("d_s(X,_,Y)"):
        goodsDS[ans["X"]] = ans["Y"]
    goodsDSordinato = sorted(goodsDS.items(), key=lambda x: x[1],reverse=True)
    return goodsDSordinato

#Ritorna un dizionario che ha come chiave le etichette dei media e come valore il relativo valore ordinato in senso decrescente
def ordinaMedia():
    goodsMedia={}
    prolog = Prolog()
    prolog.consult("SSIP-main.pl")
    for ans in prolog.query("media(X,_,Y)"):
        goodsMedia[ans["X"]] = ans["Y"]
    goodsMediaOrdinato = sorted(goodsMedia.items(), key=lambda x: x[1],reverse=True)
    return goodsMediaOrdinato

#La funzione conta il numero di goods e lo restituisce
def contagoodsBO():
    prolog = Prolog()
    goodsBO = {}
    prolog.consult("SSIP-main.pl")
    for ans in prolog.query("ordinatoBO(X,_,Y)"):
        goodsBO[ans["X"]] = ans["Y"]
    return goodsBO

#La funzione richiama le asserzioni nel database prolog del caso e le restituisce
def cancellaInfo():
    infoDaCancellare = {}
    prolog.consult("SSIP-main.pl")
    for ans in prolog.query("stampa_ass(N,X)"):
        infoDaCancellare[ans["N"]] = ans["X"]
    return infoDaCancellare

#Permette di inserire una nuova informazione del database prolog del caso in analisi
def aggiungi_info(info,fonte,att):
    prolog.consult("SSIP-main.pl")
    for i in prolog.query("aggiungi("+info+",'"+fonte+"',"+att+")"):
        continue
    return True

# Permette di chiamare le funzioni, che a loro volta chiamano funzioni Prolog. Tale funzione viene
# chiamata quando si ha bisogno dal lato front-end di visualizzare l'output che viene prodotto
def process(flag):
    if flag == 1:
     return pool.apply(prendi_info)
    elif flag == 2:
        return pool.apply(prendi_fonte)
    elif flag == 3:
        return pool.apply(ordinaDS)
    elif flag == 4:
        return pool.apply(ordinaMedia)
    elif flag == 5:
        return pool.apply(contagoodsBO)
    elif flag == 6:
        return pool.apply(cancellaInfo)
    elif flag == 7:
        return pool.apply(prendi_casi)

# Permette di chiamare la funzione aggiungi_info passandoli gli argomenti presi in input dal front-end, e ne restituisce l'output
def process1(Info,Fonte,Att):
    return pool.apply(aggiungi_info, args=(Info, Fonte, Att))

# Permette di chiamare la funzione prendi_info_fonte passando l'argomento preso in input dal front-end, e ne restituisce l'output
def process2(info_fonte):
    return pool.apply(prendi_info_fonte, args=info_fonte)

# Permette di chiamare la funzione prendi_goods_DS passando l'argomento preso in input dal front-end, e ne restituisce l'output
def process3(numeroGood):
    numeroG = str(numeroGood)
    return pool.apply(prendi_goods_DS,args=numeroG)

# Permette di chiamare la funzione prendi_goods_media passando l'argomento preso in input dal front-end, e ne restituisce l'output
def process4(numeroGood):
    numeroG = str(numeroGood)
    return pool.apply(prendi_goods_media,args=numeroG)

# Permette di chiamare la funzione prendi_goods_BO passando l'argomento preso in input dal front-end, e ne restituisce l'output
def process5(numeroGood):
    numeroG = str(numeroGood)
    return pool.apply(prendi_goods_BO,args=numeroG)

# Permette di chiamare la funzione prendi_rimuoviInfo passando l'argomento preso in input dal front-end, e ne restituisce l'output
def process6(n_informazione):
    n_info = str(n_informazione)
    return pool.apply(rimuoviInfo, args=n_info)

# Schermata iniziale di login
@app.route("/", methods=['GET','POST'])
def log_in():
    form = LoginForm()
    if form.validate_on_submit():
        user = User.query.filter_by(username=form.username.data).first()
        if user:
            if bcrypt.check_password_hash(user.password, form.password.data):
                login_user(user)
                if(user.username == 'admin'):
                    return redirect('/sign_in')
                else:
                    return redirect('/seleziona_caso')
        form.username.data = ""
        return render_template('log_in.html', form=form, invalid = True)
    return render_template('log_in.html', form=form)

# Gestione Logout
@app.route("/logout", methods=['GET'])
@login_required
def logout():
    logout_user()
    return redirect('/')

# Registrazione nuovo utente 
@app.route("/sign_in", methods=['GET','POST'])
@login_required
def sign_in():
    if current_user.username != 'admin':
        return render_template('error.html', error='Accesso non autorizzato')
        
    form = RegisterForm()
    if form.validate_on_submit():
        hashed_password = bcrypt.generate_password_hash(form.password.data)
        new_user = User(username=form.username.data, password=hashed_password)
        db.session.add(new_user)
        db.session.commit()
        form.username.data = ""
        return render_template('sign_in.html', form=form, inserted=True)
    elif(form.username.data != None or form.password.data != None):
        form.username.data = ""
        return render_template('sign_in.html', form=form, invalid=True)
    return render_template('sign_in.html', form=form)

#Cancellazione utente esistente che non sia admin
@app.route("/delete_account", methods=['GET','POST'])
@login_required
def delete_account():
    if current_user.username != 'admin':
        return render_template('error.html', error="Accesso non autorizzato")
    form = DeleteForm()
    if form.validate_on_submit():
        remove_user = User.query.filter_by(username=form.username.data).first()
        form.username.data= ""
        if remove_user and remove_user.username != 'admin':
            db.session.delete(remove_user)
            db.session.commit()
            users = User.query.order_by(User.username)
            return render_template('delete.html', form=form, deleted=True, users_list=users)
        users = User.query.order_by(User.username)
        return render_template('delete.html', form=form, invalid=True, users_list=users)
    users = User.query.order_by(User.username)
    return render_template('delete.html', form=form, users_list=users)

#Route chiamata dopo l'accesso con utente normale, chiama il template HTML relativo a carica_caso
@app.route("/seleziona_caso")
@login_required
def seleziona_caso():
    if current_user.username == 'admin':
        return render_template('error.html', error="Accesso non autorizzato")
    return render_template('carica_caso.html')

#Permette di selezionare un caso esistente da cancellare. Se il caso non esiste ritorna una condizione di errore
@app.route("/cancella_caso")
@login_required
def seleziona_cancella_caso():
    if current_user.username == 'admin':
        return render_template('error.html', error="Accesso non autorizzato")
    return render_template('cancella_caso.html')

#E' la route che reindirizza al template HTML relativo a Aggiungi_informazione
@app.route("/gestisci_info")
@login_required
def aggiungi():
    if current_user.username == 'admin':
        return render_template('error.html', error="Accesso non autorizzato")
    return render_template('gestisci_informazioni.html')

#E' la route che reindirizza al template HTML relativo a fonti
@app.route("/fonti1")
@login_required
def fonti():
    if current_user.username == 'admin':
        return render_template('error.html', error="Accesso non autorizzato")
    return render_template('fonti.html')

#E' la route che reindirizza al template HTML relativo alle informazioni
@app.route("/informazioni_fornite")
@login_required
def info():
    if current_user.username == 'admin':
        return render_template('error.html', error="Accesso non autorizzato")
    return render_template('info.html')

#E' la route che reindirizza al template HTML relativo ai goods ordinati in base a Dempster-Shafer
@app.route("/goods_DS")
@login_required
def goods_DS():
    if current_user.username == 'admin':
        return render_template('error.html', error="Accesso non autorizzato")
    return render_template('goodDS.html')

#E' la route che reindirizza al template HTML relativo ai goods ordinati in base alla media
@app.route("/goods_media")
@login_required
def goods_media():
    if current_user.username == 'admin':
        return render_template('error.html', error="Accesso non autorizzato")
    return render_template('goodMedia.html')

#E' la route che reindirizza al template HTML relativo ai goods ordinati in base al Best Out
@app.route("/goods_BO")
@login_required
def ggoods_BO():
    if current_user.username == 'admin':
        return render_template('error.html', error="Accesso non autorizzato")
    return render_template('goodBO.html')

#E' la route che reindirizza al template HTML relativo alle informazioni fornite da una fonte
#Il metodo prende tramite una POST la fonte scelta e la passa al template_HTML  visualizza_info_fonte
@app.route('/info_fonte',methods=['POST'])
@login_required
def visualizza_info_fonte():
    try:
        infoFonte = request.form['info_fonte']

    except Exception as e:
        return render_template('error.html', error=str(e))
    return render_template('fonti.html', fonte_scelta=infoFonte, view=True)

#Permette di selezionare il caso da analizzare. Se il caso è gia esistente continua a
# lavorare su di esso, altrimenti genera un nuova file dove salvare il nuovo caso
# Per riuscire a lavorare su più casi, si va a modificare il file prolog SSIP-main con il nome del file del caso in questione
@app.route("/carica_caso",methods=['POST'])
def carica_caso():
    data = request.get_json()  # Ottieni dati JSON inviati dalla funzione fetch()
    caso = data['Caso']
    caso_path = "casi/" + caso + ".pl"
    #caso += ".pl"
    if not os.path.exists(caso_path):
        open(caso_path, "w").close()
    f=open("SSIP-main.pl", "r")
    lines=f.readlines()
    f.close()
    lines[0] =":-include('"+caso_path+"').\n"
    f = open("SSIP-main.pl", "w")
    f.writelines(lines)
    f.close()
    f1 = open("SSIP-scriviDB.pl", "r")
    lines1 = f1.readlines()
    f1.close()
    lines1[1] = "tell('" + caso_path + "'),\n"
    f1 = open("SSIP-scriviDB.pl", "w")
    f1.writelines(lines1)
    f1.close()
    return jsonify({"success": True, "msg": "Caso caricato con successo"})

#Permette di selezionare un caso esistente da cancellare. Se il caso non esiste ritorna una condizione di errore
@app.route("/cancella_caso2",methods=['POST'])
@login_required
def cancella_caso():
    caso = request.form['Caso']
    caso_path = f"casi/{caso}.pl"
    if os.path.exists(caso_path):
        os.remove(caso_path)
        return jsonify({"success": True, "msg": "Caso cancellato con successo"})
    else:
        return jsonify({"success": False, "msg": "Caso inesistente"})

#Una volta inseriti i tre parametri tramite una POST, richiama process1, che a sua volta chiama aggiungi_info per chiamare
#la query prolog che aggiunge l'informazione al database prolog
#Alla fine ricarica la stessa pagina nel caso l'utente abbia l'intenzione di continuare ad inserire informazioni
@app.route('/elabora', methods=['POST'])
@login_required
def aggiungi2():
    try:
        _informazione = request.form['Informazione']
        _fonte = request.form['Fonte']
        _attendibilita = request.form['Attendibilità_della_fonte']
    except Exception as e:
        return render_template('error.html', error=str(e))
    _informazione1="'"+_informazione+"'"
    process1(_informazione1,_fonte,_attendibilita)
    return redirect('/informazioni_fornite')

#Route utilizzata dallo script JS per fare la fetch per riuscire a visualizzare le informazioni ottenute da prolog
@app.route("/infojs")
def info_js():
    return jsonify(process(1))

#Route utilizzata dallo script JS per fare la fetch per riuscire a visualizzare i casi già creati precedentemente
@app.route("/casijs")
def casi_js():
    return jsonify(process(7))

#Route utilizzata dallo script JS per fare la fetch per riuscire a visualizzare le fonti ottenute da prolog
@app.route("/fontijs")
def fonti_js():
    return jsonify(process(2))

#Route utilizzata dallo script JS per fare la fetch delle asserzioni nel database prolog, restituisce le asserzioni
@app.route("/cancellajs")
def cancella_js():
    return jsonify(process(6))

#Questa route permette di fare i collegamenti tra più informazioni con i vari operatori logici.
#Utilizza una POST per prendere le informazioni,l'oeratore logico, fonte e attendibilità inserite dall'utente e le
#passa alla funzione che si occuperà di aggiungerle al database prolog del caso in esame.
#Alla fine ricarica la stessa pagina HTML nel caso l'utente abbia l'intenzione di continuare ad inserire informazioni
@app.route('/inserisciInfoCollegate', methods=['GET','POST'])
@login_required
def collegaInfo():
    try:
        _informazione1 = request.form['info_fonte1']
        _operatore = request.form['operator']
        _informazione2 = request.form['info_fonte2']
        _fonte = request.form['fonte']
        _attendibilita = request.form['attendibilità']
    except Exception as e:
        return render_template('error.html', error=str(e))
    if (_operatore=="non" and _informazione1==""):
        informazioneFinale = _operatore + "'" + _informazione2+"'"
        process1(informazioneFinale, _fonte, _attendibilita)
        return redirect('/informazioni_fornite')
    else:
        informazioneFinale="'"+ _informazione1 +"'"+_operatore+"'"+_informazione2+"'"
        process1(informazioneFinale,_fonte,_attendibilita)
        return redirect('/informazioni_fornite')

#Route chimata dallo script JS e utilizzata per fare la fetch per riuscire a visualizzare le informazioni fornite da una fonte (idfonte)
@app.route("/info_fontejs",methods=['POST'])
def info_fonte_js():
    data=request.get_json('idfonte')
    return jsonify(process2(data.get('idfonte')))

#Route chimata dalla pagina HTML che tramite un metodo post fa inserire all'utente il numero dell'asserzione nel database prolog da cancellare
@app.route("/cancella_info",methods=['POST'])
@login_required
def cancella_info():
    _informazioneDaCancellare=request.form['informazione']
    process6(_informazioneDaCancellare)
    return redirect('/informazioni_fornite')

#Route chimata dallo script JS e utilizzata per fare la fetch per riuscire a visualizzare i goods in base all'etichetta dei goods,
#che in precedenza era stato ordinata in base al metodo Dempster-Shafer
@app.route("/goods_DSjs",methods=['POST'])
def goods_DSjs():
    data = request.get_json('idgood')
    return jsonify(process3(data.get('idgood')))

#Route chimata dallo script JS e utilizzata per fare la fetch per riuscire a visualizzare i goods in base all'etichetta ordinati secondo il Best Out
@app.route("/goods_BOjs",methods=['POST'])
def goods_BOjs():
    data = request.get_json('idgood')
    return jsonify(process5(data.get('idgood')))

#Route chimata dallo script JS e utilizzata per fare la fetch per riuscire a visualizzare i goods in base all'etichetta dei goods,
#che in precedenza era stato ordinata in base alla media delle credibilità delle informazioni
@app.route("/goods_Mediajs",methods=['POST'])
def goods_Mediajs():
    data = request.get_json('idgood')
    return jsonify(process4(data.get('idgood')))

#Route chimata dallo script JS e utilizzata per fare la fetch per restituire i goods DS ordinati
@app.route("/goodsjs")
def goodsjs():
    return jsonify(process(3))

#Route chiamata dallo script JS e utilizzata per fare la fetch per restituire i goods ordinati in base alla media della credibilità
# delle informazioni
@app.route("/goodsMediajs")
def goodsMediajs():
    return jsonify(process(4))

#Route chiamata dallo script JS e utilizzata per fare la fetch per restituire il numero di goods
@app.route("/numerogoodsBOjs")
def goodsBOjs():
    return jsonify(process(5))

pool = Pool(None, pl_init)

#E' il main dell'applicazione che viene lanciato quando si manda in esecuzione il programma
#La funzione Pool() permette di parallelizzare più esecuzioni di una funzione, inserito per problemi di comunicazione tra Python e Prolog
if __name__ == "__main__":
    app.run()
    app.debug = True
