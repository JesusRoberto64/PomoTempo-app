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
	
	mision = await get_Data("mision",manageData.mision_Data)
	misionRegistro =  await get_Data("misionregistro", manageData.mision_Register_Data)
	fechas = await  get_Data("fecha", manageData.fechas_Data)
	fechasMisionRegistro = await get_Data("fechamisionregistro", manageData.fecha_Mision_Registro_Data)
	
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
	get_tree().call_deferred("change_scene_to_packed", mainScene)

func get_Data(endpoint: String, process_Func: Callable)-> Dictionary:
	request.fetch_Data(endpoint)
	await request.error_Return
	if request.error != null:
		controlMessage.show_Message(request.error)
		return manageData.set_Generic_Data(endpoint)
	return process_Func.call(request.data_recived)
