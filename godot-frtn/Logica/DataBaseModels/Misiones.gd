extends Node
#Registro de las misiones seleccionadas estas se pueden borrar y agregar
# Tiene que conservar su id como propiedad
var register = {
	0: {"nombre": "Misión 1", "id" : 0},
	1: {"nombre": "Misión2", "id" : 1},
	2: {"nombre": "Misión 3", "id" : 2},
	3: {"nombre": "PomoTempo", "id" : 3},
}

func get_Misiones()->Array:
	var misiones = self.register
	var misionesArr = []
	for i in misiones.keys():
		misionesArr.append(misiones.get(i).nombre)
	return misionesArr

func get_Misiones_Id()->Array:
	var misiones = self.register
	var misionesArr = []
	for i in misiones.keys():
		misionesArr.append(misiones.get(i).id)
	return misionesArr
