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

atomica_ind(7, 'Angelo Galassi è il compagno di Christa').
atomica_ind(6, 'Si sentivano urla nelle scale').
atomica_ind(5, 'Gerda non ha sentito niente perchè dormiva').
atomica_ind(4, 'Christa è stata uccisa da 7 coltellate').
atomica_ind(3, 'La Fracassi ha trovato Christa distesa a terra nel pianerottolo del quarto piano').
atomica_ind(2, 'La Fracassi ha visto Christa salire le scale').
atomica_ind(1, 'La Fracassi ha sentito le urla sulle scale alle 14.30').
atomica_ind(0, 'Angelo era molto geloso di Christa').

:- dynamic significativa/3.
:- multifile significativa/3.

significativa(18, c([], [0]), 'Angelo Galassi').
significativa(17, c([0], []), 'Gerda Hodapp').
significativa(7, c([7], []), 'Angelo Galassi').
significativa(16, c([7], []), 'Angelo Galassi').
significativa(6, c([6], []), 'Condomini').
significativa(15, c([6], []), 'Condomini').
significativa(5, c([5], []), 'Gerda Hodapp').
significativa(14, c([5], []), 'Gerda Hodapp').
significativa(4, c([4], []), 'Medico').
significativa(13, c([4], []), 'Medico').
significativa(3, c([3], []), 'Francesca Fracassi').
significativa(12, c([3], []), 'Francesca Fracassi').
significativa(2, c([2], []), 'Francesca Fracassi').
significativa(11, c([2], []), 'Francesca Fracassi').
significativa(1, c([1], []), 'Francesca Fracassi').
significativa(10, c([1], []), 'Francesca Fracassi').
significativa(8, c([0], []), 'Gerda Hodapp').
significativa(9, c([], [0]), 'Angelo Galassi').

:- dynamic fonte_sign/2.
:- multifile fonte_sign/2.

fonte_sign('Condomini', 4).
fonte_sign('Medico', 3).
fonte_sign('Francesca Fracassi', 2).
fonte_sign('Gerda Hodapp', 1).
fonte_sign('Angelo Galassi', 0).

:- dynamic base_stratificata/1.
:- multifile base_stratificata/1.

base_stratificata([[c([4], [])], [c([1], []), c([2], []), c([3], [])], [c([6], [])], [c([], [0]), c([7], [])], [c([0], []), c([5], [])]]).

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

asserisce_clausole(4, [c([6], []), c([6], [])]).
asserisce_clausole(3, [c([4], []), c([4], [])]).
asserisce_clausole(2, [c([3], []), c([3], []), c([2], []), c([2], []), c([1], []), c([1], [])]).
asserisce_clausole(1, [c([0], []), c([5], []), c([5], []), c([0], [])]).
asserisce_clausole(0, [c([], [0]), c([7], []), c([7], []), c([], [0])]).

:- dynamic modelli/2.
:- multifile modelli/2.

modelli(c([], [0]), [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 66, 68, 70, 72, 74, 76, 78, 80, 82, 84, 86, 88, 90, 92, 94, 96, 98, 100, 102, 104, 106, 108, 110, 112, 114, 116, 118, 120, 122, 124, 126, 128, 130, 132, 134, 136, 138, 140, 142, 144, 146, 148, 150, 152, 154, 156, 158, 160, 162, 164, 166, 168, 170, 172, 174, 176, 178, 180, 182, 184, 186, 188, 190, 192, 194, 196, 198, 200, 202, 204, 206, 208, 210, 212, 214, 216, 218, 220, 222, 224, 226, 228, 230, 232, 234, 236, 238, 240, 242, 244, 246, 248, 250, 252, 254]).
modelli(c([0], []), [1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129, 131, 133, 135, 137, 139, 141, 143, 145, 147, 149, 151, 153, 155, 157, 159, 161, 163, 165, 167, 169, 171, 173, 175, 177, 179, 181, 183, 185, 187, 189, 191, 193, 195, 197, 199, 201, 203, 205, 207, 209, 211, 213, 215, 217, 219, 221, 223, 225, 227, 229, 231, 233, 235, 237, 239, 241, 243, 245, 247, 249, 251, 253, 255]).
modelli(c([1], []), [2, 3, 6, 7, 10, 11, 14, 15, 18, 19, 22, 23, 26, 27, 30, 31, 34, 35, 38, 39, 42, 43, 46, 47, 50, 51, 54, 55, 58, 59, 62, 63, 66, 67, 70, 71, 74, 75, 78, 79, 82, 83, 86, 87, 90, 91, 94, 95, 98, 99, 102, 103, 106, 107, 110, 111, 114, 115, 118, 119, 122, 123, 126, 127, 130, 131, 134, 135, 138, 139, 142, 143, 146, 147, 150, 151, 154, 155, 158, 159, 162, 163, 166, 167, 170, 171, 174, 175, 178, 179, 182, 183, 186, 187, 190, 191, 194, 195, 198, 199, 202, 203, 206, 207, 210, 211, 214, 215, 218, 219, 222, 223, 226, 227, 230, 231, 234, 235, 238, 239, 242, 243, 246, 247, 250, 251, 254, 255]).
modelli(c([2], []), [4, 5, 6, 7, 12, 13, 14, 15, 20, 21, 22, 23, 28, 29, 30, 31, 36, 37, 38, 39, 44, 45, 46, 47, 52, 53, 54, 55, 60, 61, 62, 63, 68, 69, 70, 71, 76, 77, 78, 79, 84, 85, 86, 87, 92, 93, 94, 95, 100, 101, 102, 103, 108, 109, 110, 111, 116, 117, 118, 119, 124, 125, 126, 127, 132, 133, 134, 135, 140, 141, 142, 143, 148, 149, 150, 151, 156, 157, 158, 159, 164, 165, 166, 167, 172, 173, 174, 175, 180, 181, 182, 183, 188, 189, 190, 191, 196, 197, 198, 199, 204, 205, 206, 207, 212, 213, 214, 215, 220, 221, 222, 223, 228, 229, 230, 231, 236, 237, 238, 239, 244, 245, 246, 247, 252, 253, 254, 255]).
modelli(c([3], []), [8, 9, 10, 11, 12, 13, 14, 15, 24, 25, 26, 27, 28, 29, 30, 31, 40, 41, 42, 43, 44, 45, 46, 47, 56, 57, 58, 59, 60, 61, 62, 63, 72, 73, 74, 75, 76, 77, 78, 79, 88, 89, 90, 91, 92, 93, 94, 95, 104, 105, 106, 107, 108, 109, 110, 111, 120, 121, 122, 123, 124, 125, 126, 127, 136, 137, 138, 139, 140, 141, 142, 143, 152, 153, 154, 155, 156, 157, 158, 159, 168, 169, 170, 171, 172, 173, 174, 175, 184, 185, 186, 187, 188, 189, 190, 191, 200, 201, 202, 203, 204, 205, 206, 207, 216, 217, 218, 219, 220, 221, 222, 223, 232, 233, 234, 235, 236, 237, 238, 239, 248, 249, 250, 251, 252, 253, 254, 255]).
modelli(c([4], []), [16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255]).
modelli(c([5], []), [32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255]).
modelli(c([6], []), [64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255]).
modelli(c([7], []), [128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255]).

:- dynamic bpac/2.
:- multifile bpac/2.

bpac([222, 254], 0.30109655172413785).
bpac([158, 190, 222, 254], 0.12904137931034482).
bpac([206, 222, 238, 254], 0.0030413793103448296).
bpac([142, 158, 174, 190, 206, 222, 238, 254], 0.0013034482758620702).
bpac([208, 210, 212, 214, 216, 218, 220, 222, 240, 242, 244, 246, 248, 250, 252, 254], 0.03345517241379309).
bpac([144, 146, 148, 150, 152, 154, 156, 158, 176, 178, 180, 182, 184, 186, 188, 190, 208, 210, 212, 214, 216, 218, 220, 222, 240, 242, 244, 246, 248, 250, 252, 254], 0.014337931034482755).
bpac([192, 194, 196, 198, 200, 202, 204, 206, 208, 210, 212, 214, 216, 218, 220, 222, 224, 226, 228, 230, 232, 234, 236, 238, 240, 242, 244, 246, 248, 250, 252, 254], 0.0003379310344827587).
bpac([128, 130, 132, 134, 136, 138, 140, 142, 144, 146, 148, 150, 152, 154, 156, 158, 160, 162, 164, 166, 168, 170, 172, 174, 176, 178, 180, 182, 184, 186, 188, 190, 192, 194, 196, 198, 200, 202, 204, 206, 208, 210, 212, 214, 216, 218, 220, 222, 224, 226, 228, 230, 232, 234, 236, 238, 240, 242, 244, 246, 248, 250, 252, 254], 0.00014482758620689662).
bpac([127, 255], 0.19356206896551723).
bpac([63, 127, 191, 255], 0.08295517241379312).
bpac([111, 127, 239, 255], 0.0019551724137931055).
bpac([47, 63, 111, 127, 175, 191, 239, 255], 0.0008379310344827596).
bpac([113, 115, 117, 119, 121, 123, 125, 127, 241, 243, 245, 247, 249, 251, 253, 255], 0.021506896551724133).
bpac([49, 51, 53, 55, 57, 59, 61, 63, 113, 115, 117, 119, 121, 123, 125, 127, 177, 179, 181, 183, 185, 187, 189, 191, 241, 243, 245, 247, 249, 251, 253, 255], 0.009217241379310345).
bpac([97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 225, 227, 229, 231, 233, 235, 237, 239, 241, 243, 245, 247, 249, 251, 253, 255], 0.00021724137931034498).
bpac([33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 161, 163, 165, 167, 169, 171, 173, 175, 177, 179, 181, 183, 185, 187, 189, 191, 225, 227, 229, 231, 233, 235, 237, 239, 241, 243, 245, 247, 249, 251, 253, 255], 9.310344827586214e-5).
bpac([94, 95, 126, 127, 222, 223, 254, 255], 0.12904137931034484).
bpac([30, 31, 62, 63, 94, 95, 126, 127, 158, 159, 190, 191, 222, 223, 254, 255], 0.05530344827586209).
bpac([78, 79, 94, 95, 110, 111, 126, 127, 206, 207, 222, 223, 238, 239, 254, 255], 0.0013034482758620704).
bpac([14, 15, 30, 31, 46, 47, 62, 63, 78, 79, 94, 95, 110, 111, 126, 127, 142, 143, 158, 159, 174, 175, 190, 191, 206, 207, 222, 223, 238, 239, 254, 255], 0.0005586206896551732).
bpac([80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255], 0.014337931034482755).
bpac([16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255], 0.006144827586206897).
bpac([64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255], 0.00014482758620689668).
bpac(omega, 6.206896551724144e-5).

:- dynamic b/2.
:- multifile b/2.

b(c([], [0]), 0.4827586206896551).
b(c([0], []), 0.31034482758620685).
b(c([1], []), 0.8999999999999999).
b(c([2], []), 0.8999999999999999).
b(c([3], []), 0.8999999999999999).
b(c([4], []), 0.99).
b(c([5], []), 0.31034482758620685).
b(c([6], []), 0.6999999999999998).
b(c([7], []), 0.4827586206896551).

:- dynamic b_ns/2.
:- multifile b_ns/2.


:- dynamic good/3.
:- multifile good/3.

good([c([0], []), c([1], []), c([2], []), c([3], []), c([4], []), c([5], []), c([6], []), c([7], [])], [17, 8, 1, 10, 2, 11, 3, 12, 4, 13, 5, 14, 6, 15, 7, 16], [255]).
good([c([], [0]), c([1], []), c([2], []), c([3], []), c([4], []), c([5], []), c([6], []), c([7], [])], [18, 9, 1, 10, 2, 11, 3, 12, 4, 13, 5, 14, 6, 15, 7, 16], [254]).

:- dynamic g_s/2.
:- multifile g_s/2.

g_s([c([0], []), c([1], []), c([2], []), c([3], []), c([4], []), c([5], []), c([6], []), c([7], [])], [[c([4], [])], [c([1], []), c([2], []), c([3], [])], [c([6], [])], [c([7], [])], [c([0], []), c([5], [])]]).
g_s([c([], [0]), c([1], []), c([2], []), c([3], []), c([4], []), c([5], []), c([6], []), c([7], [])], [[c([4], [])], [c([1], []), c([2], []), c([3], [])], [c([6], [])], [c([], [0]), c([7], [])], [c([5], [])]]).

:- dynamic d_s/3.
:- multifile d_s/3.

d_s(2, [c([], [0]), c([1], []), c([2], []), c([3], []), c([4], []), c([5], []), c([6], []), c([7], [])], 0).
d_s(1, [c([0], []), c([1], []), c([2], []), c([3], []), c([4], []), c([5], []), c([6], []), c([7], [])], 0).

:- dynamic media/3.
:- multifile media/3.

media(2, [c([], [0]), c([1], []), c([2], []), c([3], []), c([4], []), c([5], []), c([6], []), c([7], [])], 0.7082327586206895).
media(1, [c([0], []), c([1], []), c([2], []), c([3], []), c([4], []), c([5], []), c([6], []), c([7], [])], 0.6866810344827586).

:- dynamic credibile/2.
:- multifile credibile/2.

credibile('Angelo Galassi', 0.4827586206896551).
credibile('Gerda Hodapp', 0.31034482758620685).
credibile('Francesca Fracassi', 0.8999999999999999).
credibile('Medico', 0.99).
credibile('Condomini', 0.6999999999999998).

:- dynamic nuova_att/2.
:- multifile nuova_att/2.

nuova_att('Angelo Galassi', 0.48275862068965486).
nuova_att('Gerda Hodapp', 0.31034482758620685).
nuova_att('Francesca Fracassi', 0.8999999999999999).
nuova_att('Medico', 0.9899999999999998).
nuova_att('Condomini', 0.6999999999999998).

:- dynamic ordinatoBO/3.
:- multifile ordinatoBO/3.

ordinatoBO(1, [c([], [0]), c([1], []), c([2], []), c([3], []), c([4], []), c([5], []), c([6], []), c([7], [])], 0).
ordinatoBO(2, [c([0], []), c([1], []), c([2], []), c([3], []), c([4], []), c([5], []), c([6], []), c([7], [])], 0).

