extends Node
#Registro de las misiones seleccionadas estas se pueden borrar y agregar
# Tiene que conservar su id como propiedad
#{
#	0 : {"id": 0, "nombre" : "nueva mision"},
#	1 : {"id": 1, "nombre" : "Escribir ensayo" }
#}
var register = {}

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
