extends Node

@onready var controlMessage = $ControlMessage
@onready var DataMannager = $DataManager

const SAVEPATH := "res://Recursos/SavedData/save_data_00.tres"
@export var data_resourse: Script

func _ready() -> void:
	controlMessage.show_Message("Cargando...")
	
	#Declare var
	var fechas = {}
	var mision = {}
	var misionRegistro = {}
	var fechasMisionRegistro = {}
	#fetch_from_db 
	controlMessage.show_Message("Fetching Data")
	fechas = {
		"2024-09-25" : { "id": 3, "pomodoro": 7 },
		"2024-09-26" : { "id": 4, "pomodoro": 6 },
		"2024-09-27" : { "id": 5, "pomodoro": 10 }
	}
	
	mision = {
		0 : {"id": 0, "nombre": "Mision Start 4"},
		1 : {"id": 2, "nombre": "Eliab y el Círculo del juego"},
		2 : {"id": 3, "nombre": "ChuyRonin"}
	}
	
	misionRegistro = {
		
	}
	
	
	#get the saved archive
	var dir = DirAccess.open("res://Recursos/SavedData/")
	var res = data_resourse.new()
	
	if !dir.file_exists(SAVEPATH):
		var error = ResourceSaver.save(res,SAVEPATH)
		if error != OK:
			controlMessage.show_Message("Can't save")
			printerr("Can't save No file path exist")
			return
		else:
			controlMessage.show_Message("Created new data")
			print("Created new data")
	
	#Update
	res.misionResgistro = misionRegistro
	res.misiones = mision
	res.fechasMisionRegistro = fechasMisionRegistro
	res.fechas = fechas
	
	var saveError = ResourceSaver.save(res,SAVEPATH)
	if saveError != OK:
		controlMessage.show_Message("Can't Update data")
		printerr("Can't updte data")
		return
	else:
		controlMessage.show_Message("Updated data")
		print("Updated data")
	
	controlMessage.show_Message("Fetched Data")
	print("Fetched loaded")
