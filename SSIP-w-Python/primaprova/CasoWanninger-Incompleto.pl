:- dynamic ass/4.
:- multifile ass/4.

ass(9, c([], ['Angelo era molto geloso di Christa']), 'Angelo Galassi', ['Angelo era molto geloso di Christa']).
ass(8, c(['Angelo era molto geloso di Christa'], []), 'Gerda Hodapp', ['Angelo era molto geloso di Christa']).
ass(7, c(['Angelo Galassi è il compagno di Christa'], []), 'Angelo Galassi', ['Angelo Galassi è il compagno di Christa']).
ass(6, c(['Si sentivano urla nelle scale'], []), 'Condomini', ['Si sentivano urla nelle scale']).
ass(5, c(['Gerda non ha sentito niente perchè dormiva'], []), 'Gerda Hodapp', ['Gerda non ha sentito niente perchè dormiva']).
ass(4, c(['Christa è stata uccisa da 7 coltellate'], []), 'Medico', ['Christa è stata uccisa da 7 coltellate']).
ass(3, c(['La Fracassi ha trovato Christa distesa a terra nel pianerottolo del quarto piano'], []), 'Francesca Fracassi', ['La Fracassi ha trovato Christa distesa a terra nel pianerottolo del quarto piano']).
ass(2, c(['La Fracassi ha visto Christa salire le scale'], []), 'Francesca Fracassi', ['La Fracassi ha visto Christa salire le scale']).
ass(1, c(['La Fracassi ha sentito le urla sulle scale alle 14.30'], []), 'Francesca Fracassi', ['La Fracassi ha sentito le urla sulle scale alle 14.30']).

:- dynamic atomica/1.
:- multifile atomica/1.

atomica('Angelo era molto geloso di Christa').
atomica('Angelo Galassi è il compagno di Christa').
atomica('Si sentivano urla nelle scale').
atomica('Gerda non ha sentito niente perchè dormiva').
atomica('Christa è stata uccisa da 7 coltellate').
atomica('La Fracassi ha trovato Christa distesa a terra nel pianerottolo del quarto piano').
atomica('La Fracassi ha visto Christa salire le scale').
atomica('La Fracassi ha sentito le urla sulle scale alle 14.30').

:- dynamic att/2.
:- multifile att/2.

att('Angelo Galassi', 0.7).
att('Condomini', 0.7).
att('Gerda Hodapp', 0.6).
att('Medico', 0.99).
att('Francesca Fracassi', 0.9).

:- dynamic atomica_ind/2.
:- multifile atomica_ind/2.

atomica_ind(0, 'Angelo era molto geloso di Christa').

:- dynamic significativa/3.
:- multifile significativa/3.

significativa(8, c([0], []), 'Gerda Hodapp').
significativa(9, c([], [0]), 'Angelo Galassi').

:- dynamic fonte_sign/2.
:- multifile fonte_sign/2.

fonte_sign('Gerda Hodapp', 1).
fonte_sign('Angelo Galassi', 0).

:- dynamic base_stratificata/1.
:- multifile base_stratificata/1.

base_stratificata([[c([], [0])], [c([0], [])]]).

:- dynamic cl_l/2.
:- multifile cl_l/2.

cl_l(c([], ['Angelo era molto geloso di Christa']), ['Non e\' vero che Angelo era molto geloso di Christa']).
cl_l(c(['Angelo era molto geloso di Christa'], []), ['Angelo era molto geloso di Christa']).
cl_l(c(['Angelo Galassi è il compagno di Christa'], []), ['Angelo Galassi è il compagno di Christa']).
cl_l(c(['Si sentivano urla nelle scale'], []), ['Si sentivano urla nelle scale']).
cl_l(c(['Gerda non ha sentito niente perchè dormiva'], []), ['Gerda non ha sentito niente perchè dormiva']).
cl_l(c(['Christa è stata uccisa da 7 coltellate'], []), ['Christa è stata uccisa da 7 coltellate']).
cl_l(c(['La Fracassi ha trovato Christa distesa a terra nel pianerottolo del quarto piano'], []), ['La Fracassi ha trovato Christa distesa a terra nel pianerottolo del quarto piano']).
cl_l(c(['La Fracassi ha visto Christa salire le scale'], []), ['La Fracassi ha visto Christa salire le scale']).
cl_l(c(['La Fracassi ha sentito le urla sulle scale alle 14.30'], []), ['La Fracassi ha sentito le urla sulle scale alle 14.30']).

:- dynamic asserisce_clausole/2.
:- multifile asserisce_clausole/2.

asserisce_clausole(1, [c([0], [])]).
asserisce_clausole(0, [c([], [0])]).

:- dynamic modelli/2.
:- multifile modelli/2.

modelli(c([], [0]), [0]).
modelli(c([0], []), [1]).

:- dynamic bpac/2.
:- multifile bpac/2.

bpac([0], 0.4827586206896551).
bpac([1], 0.3103448275862069).
bpac(omega, 0.20689655172413796).

:- dynamic b/2.
:- multifile b/2.

b(c([], [0]), 0.4827586206896551).
b(c([0], []), 0.3103448275862069).

:- dynamic b_ns/2.
:- multifile b_ns/2.

b_ns(7, 0.4827586206896551).
b_ns(6, 0.7).
b_ns(5, 0.3103448275862069).
b_ns(4, 0.99).
b_ns(3, 0.9).
b_ns(2, 0.9).
b_ns(1, 0.9).

:- dynamic good/3.
:- multifile good/3.

good([c([0], [])], [8], [1]).
good([c([], [0])], [9], [0]).

:- dynamic g_s/2.
:- multifile g_s/2.

g_s([c([0], [])], [[], [c([0], [])]]).
g_s([c([], [0])], [[c([], [0])], []]).

:- dynamic d_s/3.
:- multifile d_s/3.

d_s(2, [c([], [0])], 0.4827586206896551).
d_s(1, [c([0], [])], 0.3103448275862069).

:- dynamic media/3.
:- multifile media/3.

media(2, [c([], [0])], 0.7082327586206896).
media(1, [c([0], [])], 0.6866810344827586).

:- dynamic credibile/2.
:- multifile credibile/2.

credibile('Angelo Galassi', 0.4827586206896551).
credibile('Gerda Hodapp', 0.3103448275862069).

:- dynamic nuova_att/2.
:- multifile nuova_att/2.

nuova_att('Angelo Galassi', 0.4827586206896551).
nuova_att('Gerda Hodapp', 0.3103448275862069).

:- dynamic ordinatoBO/3.
:- multifile ordinatoBO/3.

ordinatoBO(1, [c([], [0])], 0.4827586206896551).
ordinatoBO(2, [c([0], [])], 0.3103448275862069).

