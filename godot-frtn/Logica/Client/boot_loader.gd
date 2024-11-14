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
	var test = get_Data_Test(test1, 25)
	print(test)
	return
	
	#=========SEND REQUEST===============#
	controlMessage.show_Message("Conectando...")
	request.fetch_Data("mision")
	await request.error_Return
	if request.error != null:
		controlMessage.show_Message(request.error)
		set_Generic_Data()
	else:
		mision = manageData.mision_Data(request.data_recived)
	
	request.fetch_Data("misionregistro")
	await request.error_Return
	if request.error != null:
		controlMessage.show_Message(request.error)
		set_Generic_Data()
	else :
		misionRegistro = manageData.mision_Register_Data(request.data_recived)
	
	request.fetch_Data("fecha")
	await request.error_Return
	if request.error != null:
		controlMessage.show_Message(request.error)
		set_Generic_Data()
	else :
		fechas = manageData.fechas_Data(request.data_recived)
	
	request.fetch_Data("fechamisionregistro")
	await  request.error_Return
	if request.error != null:
		controlMessage.show_Message(request.error)
		set_Generic_Data()
	else :
		fechasMisionRegistro = manageData.fecha_Mision_Registro_Data(request.data_recived)
	
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
	#to_Main_Screen()

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

func get_Data(endpoint: String, process_Func: Callable, generic_Func: Callable):
	request.fetch_Data(endpoint)
	await request.error_Return
	if request.error != null:
		controlMessage.show_Message(request.error)
		return generic_Func.call(endpoint)
	return process_Func.call(request.data_recived)

func get_Data_Test(proces_Func: Callable, num: int):
	return proces_Func.call(num)

func test1(num: int):
	return "tested = " + str(num) 
