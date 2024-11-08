extends Node

@onready var controlMessage = $ControlMessage
@onready var request = $ClientRequest
@onready var manageData = $ManageData

const SAVEPATH := "res://Recursos/SavedData/save_data_00.tres"
@export var data_resourse: Script

var mainScene = preload("res://Escenas/Screens/main_screen.tscn")

var fetchCounter = 0

#Declare vars
var fechas = {}
var mision = {}
var misionRegistro = {}
var fechasMisionRegistro = {}

func _ready() -> void:
	controlMessage.show_Message("Cargando...")
	
	#=========SEND REQUEST===============#
	controlMessage.show_Message("Conectando...")
	request.fetch_Data("mision")
	
	await request.error_Return
	if request.error != null:
		controlMessage.show_Message(request.error)
		set_Generic_Data()
		return
	mision = manageData.mision_Data(request.data_recived)
	
	request.fetch_Data("misionregisto")
	
	
	
	#get the saved archive
	var dir = DirAccess.open("res://Recursos/SavedData/")
	var res = data_resourse.new()
	
	if !dir.file_exists(SAVEPATH):
		var error = ResourceSaver.save(res,SAVEPATH)
		if error != OK:
			controlMessage.show_Message("Can't save")
			printerr("Can't save No file path exist")
			return
		controlMessage.show_Message("Created new data")
	
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
	
	controlMessage.show_Message("Loaded data succes")

func to_Main_Screen():
	get_tree().call_deferred("change_scene_to_packed", mainScene)

func set_Generic_Data():
	fechas = {
		"2024-11-05" : { "id": 3, "pomodoro": 7 },
		"2024-11-06" : { "id": 4, "pomodoro": 6 },
		"2024-11-07" : { "id": 5, "pomodoro": 10 }
	}
	mision = {
		0 : {"id": 1, "nombre": "Mision Start 4"},
		1 : {"id": 2, "nombre": "Eliab y el Círculo del juego"},
		2 : {"id": 3, "nombre": "ChuyRonin 66"}
	}
	misionRegistro = {
		1 : { "mision": "Mision Start 4", "pomodoro": 0 },
		2 : { "mision": "Eliab y el Círculo del juego", "pomodoro": 0 },
		3 : { "mision": "ChuyRonin", "pomodoro": 0 }
	}
	# fcha_id : {mision_id: pomodoro, ... }
	fechasMisionRegistro = {
		3: { 1 : 2, 2 : 2 },
		4: { 2 : 3, 3 : 3 },
		5: { 1 : 2, 2 : 4, 3 : 1 }
	}
