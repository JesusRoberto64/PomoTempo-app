extends Node

func mision_Data(data)-> Dictionary:
	var newDir = {}
	for i in data.size():
		newDir.merge({i : data[i]})
	return newDir

func mision_Register_Data(data)-> Dictionary:
	var newDir = {}
	for i in data:
		newDir.merge({int(i.id) : {"mision": i.nombre, "pomodoro": i.pomodoro}})
	return newDir

func fechas_Data(data)-> Dictionary:
	var newDir = {}
	for i in data:
		newDir.merge({i.fecha : { "id": int(i.id), "pomodoro": i.pomodoros }})
	return newDir

func fecha_Mision_Registro_Data(data)-> Dictionary:
	var newDir = {}
	for i in data:
		newDir.merge({int(i.fecha_id): {}})
		var regDir = newDir.get(int(i.fecha_id))
		regDir.merge({int(i.mision_id): i.pomodoros})
	return newDir

func set_Generic_Data(dirVal):
	print("USED GENRIC!!")
	match dirVal:
		"fechas":
			return {
				"2024-11-05" : { "id": 3, "pomodoro": 7 },
				"2024-11-06" : { "id": 4, "pomodoro": 6 },
				"2024-11-07" : { "id": 5, "pomodoro": 10 }
				}
		"mision":
			return {
				0 : {"id": 1, "nombre": "Mision Start 4"},
				1 : {"id": 2, "nombre": "Eliab y el Círculo del juego"},
				2 : {"id": 3, "nombre": "ChuyRonin 66"}
				}
		"misionregistro":
			return {
				1 : { "mision": "Mision Start 4", "pomodoro": 0 },
				2 : { "mision": "Eliab y el Círculo del juego", "pomodoro": 0 },
				3 : { "mision": "ChuyRonin", "pomodoro": 0 }
				}
		"fechamisionregistro":
			return {
				3: { 1 : 2, 2 : 2 },
				4: { 2 : 3, 3 : 3 },
				5: { 1 : 2, 2 : 4, 3 : 1 }
				}
	pass
