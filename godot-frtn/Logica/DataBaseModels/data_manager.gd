extends Node

@export var data_resourse: Script
const SAVEPATH := "res://Recursos/SavedData/save_data_00.tres"

signal send_message(text: String)

func load_Data():
	var dir = DirAccess.open("res://Recursos/SavedData/")
	
	if !dir.file_exists(SAVEPATH):
		var res = data_resourse.new()
		var error = ResourceSaver.save(res,SAVEPATH)
		if error != OK:
			send_message.emit("Can't save")
			printerr("Can't save")
			return
		else:
			send_message.emit("Created new data")
			print("Created new data")
	
	var resource = load(SAVEPATH)
	MisionesRegister.register = resource.misionResgistro
	Misiones.register = resource.misiones
	FechasMisionRegistro.register = resource.fechasMisionRegistro
	Fechas01.registers = resource.fechas
	
	send_message.emit("Data loaded")
	print("Data loaded")

func save():
	var res = data_resourse.new()
	res.misionResgistro = MisionesRegister.register
	res.misiones = Misiones.register
	res.fechasMisionRegistro = FechasMisionRegistro.register
	res.fechas = Fechas01.registers
	
	var error = ResourceSaver.save(res,SAVEPATH)
	if error != OK:
		send_message.emit("Can't save")
		printerr("Can't save")
	else:
		send_message.emit("Saved succesfully")
