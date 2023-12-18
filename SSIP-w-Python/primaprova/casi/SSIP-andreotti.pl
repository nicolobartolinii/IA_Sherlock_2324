:- dynamic ass/4.
:- multifile ass/4.

ass(7, c(['Lima era cugino dei fratelli Salvo'], []), 'Anagrafe', ['Lima era cugino dei fratelli Salvo']).
ass(6, c(['Andreotti era amico di Lima'], []), 'Andreotti', ['Andreotti era amico di Lima']).
ass(5, c(['Andreotti conosceva i fratelli Salvo'], ['Andreotti usava la macchina dei fratelli Salvo']), 'Utente', ['Andreotti conosceva i fratelli Salvo', 'Andreotti usava la macchina dei fratelli Salvo']).
ass(4, c(['Andreotti ha baciato Riina'], []), 'Buscetta', ['Andreotti ha baciato Riina']).
ass(3, c(['Andreotti usava la macchina dei fratelli Salvo'], []), 'Mutolo', ['Andreotti usava la macchina dei fratelli Salvo']).
ass(2, c(['Andreotti conosceva i fratelli Salvo'], []), 'Mannoia', ['Andreotti conosceva i fratelli Salvo']).
ass(1, c([], ['Andreotti conosceva i fratelli Salvo']), 'Andreotti', ['Andreotti conosceva i fratelli Salvo']).

:- dynamic atomica/1.
:- multifile atomica/1.

atomica('Lima era cugino dei fratelli Salvo').
atomica('Andreotti era amico di Lima').
atomica('Andreotti ha baciato Riina').
atomica('Andreotti usava la macchina dei fratelli Salvo').
atomica('Andreotti conosceva i fratelli Salvo').

:- dynamic att/2.
:- multifile att/2.

att('Anagrafe', 0.99).
att('Utente', 0.9).
att('Buscetta', 0.8).
att('Mutolo', 0.6).
att('Mannoia', 0.8).
att('Andreotti', 0.9).

:- dynamic atomica_ind/2.
:- multifile atomica_ind/2.

atomica_ind(1, 'Andreotti usava la macchina dei fratelli Salvo').
atomica_ind(0, 'Andreotti conosceva i fratelli Salvo').

:- dynamic significativa/3.
:- multifile significativa/3.

significativa(3, c([1], []), 'Mutolo').
significativa(5, c([0], [1]), 'Utente').
significativa(1, c([], [0]), 'Andreotti').
significativa(2, c([0], []), 'Mannoia').

:- dynamic fonte_sign/2.
:- multifile fonte_sign/2.

fonte_sign('Mutolo', 3).
fonte_sign('Utente', 2).
fonte_sign('Andreotti', 1).
fonte_sign('Mannoia', 0).

:- dynamic base_stratificata/1.
:- multifile base_stratificata/1.

base_stratificata([[c([0], [1])], [c([0], [])], [c([], [0])], [c([1], [])]]).

:- dynamic cl_l/2.
:- multifile cl_l/2.

cl_l(c(['Lima era cugino dei fratelli Salvo'], []), ['Lima era cugino dei fratelli Salvo']).
cl_l(c(['Andreotti era amico di Lima'], []), ['Andreotti era amico di Lima']).
cl_l(c(['Andreotti conosceva i fratelli Salvo'], ['Andreotti usava la macchina dei fratelli Salvo']), ['Andreotti usava la macchina dei fratelli Salvo implica ', 'Andreotti conosceva i fratelli Salvo']).
cl_l(c(['Andreotti ha baciato Riina'], []), ['Andreotti ha baciato Riina']).
cl_l(c(['Andreotti usava la macchina dei fratelli Salvo'], []), ['Andreotti usava la macchina dei fratelli Salvo']).
cl_l(c(['Andreotti conosceva i fratelli Salvo'], []), ['Andreotti conosceva i fratelli Salvo']).
cl_l(c([], ['Andreotti conosceva i fratelli Salvo']), ['Non e\' vero che Andreotti conosceva i fratelli Salvo']).

:- dynamic asserisce_clausole/2.
:- multifile asserisce_clausole/2.

asserisce_clausole(3, [c([1], [])]).
asserisce_clausole(2, [c([0], [1])]).
asserisce_clausole(1, [c([], [0])]).
asserisce_clausole(0, [c([0], [])]).

:- dynamic modelli/2.
:- multifile modelli/2.

modelli(c([], [0]), [0, 2]).
modelli(c([0], []), [1, 3]).
modelli(c([0], [1]), [0, 1, 3]).
modelli(c([1], []), [2, 3]).

:- dynamic bpac/2.
:- multifile bpac/2.

bpac([3], 0.32166301969365446).
bpac([1, 3], 0.17505470459518613).
bpac([0], 0.3544857768052519).
bpac([2], 0.0590809628008753).
bpac([0, 2], 0.039387308533916865).
bpac([0, 1, 3], 0.039387308533916865).
bpac([2, 3], 0.006564551422319476).
bpac(omega, 0.004376367614879651).

:- dynamic b/2.
:- multifile b/2.

b(c([], [0]), 0.4529540481400441).
b(c([0], []), 0.4967177242888406).
b(c([0], [1]), 0.8905908096280093).
b(c([1], []), 0.3873085339168493).

:- dynamic b_ns/2.
:- multifile b_ns/2.

b_ns(7, 0.99).
b_ns(6, 0.45295404814004403).
b_ns(4, 0.8).

:- dynamic good/3.
:- multifile good/3.

good([c([0], []), c([0], [1]), c([1], [])], [2, 5, 3], [3]).
good([c([], [0]), c([1], [])], [1, 3], [2]).
good([c([], [0]), c([0], [1])], [1, 5], [0]).

:- dynamic g_s/2.
:- multifile g_s/2.

g_s([c([0], []), c([0], [1]), c([1], [])], [[c([0], [1])], [c([0], [])], [], [c([1], [])]]).
g_s([c([], [0]), c([1], [])], [[], [], [c([], [0])], [c([1], [])]]).
g_s([c([], [0]), c([0], [1])], [[c([0], [1])], [], [c([], [0])], []]).

:- dynamic d_s/3.
:- multifile d_s/3.

d_s(3, [c([], [0]), c([0], [1])], 0.3544857768052519).
d_s(2, [c([], [0]), c([1], [])], 0.0590809628008753).
d_s(1, [c([0], []), c([0], [1]), c([1], [])], 0.32166301969365446).

:- dynamic media/3.
:- multifile media/3.

media(3, [c([], [0]), c([0], [1])], 0.7172997811816195).
media(2, [c([], [0]), c([1], [])], 0.6166433260393875).
media(1, [c([0], []), c([0], [1]), c([1], [])], 0.669595185995624).

:- dynamic credibile/2.
:- multifile credibile/2.

credibile('Mannoia', 0.4967177242888406).
credibile('Andreotti', 0.4529540481400441).
credibile('Utente', 0.8905908096280093).
credibile('Mutolo', 0.3873085339168493).

:- dynamic nuova_att/2.
:- multifile nuova_att/2.

nuova_att('Mannoia', 0.43763676148796526).
nuova_att('Andreotti', 0.45295404814004403).
nuova_att('Utente', 0.8468271334792128).
nuova_att('Mutolo', 0.38730853391684916).

:- dynamic ordinatoBO/3.
:- multifile ordinatoBO/3.

ordinatoBO(1, [c([0], []), c([0], [1]), c([1], [])], 0.32166301969365446).
ordinatoBO(2, [c([], [0]), c([0], [1])], 0.3544857768052519).
ordinatoBO(3, [c([], [0]), c([1], [])], 0.0590809628008753).

