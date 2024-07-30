extends Node

@export var data_resourse: Script
const SAVEPATH := "res://Recursos/SavedData/save_data_00.tres"

func load_Data():
	var dir = DirAccess.open("res://Recursos/SavedData/")
	
	if !dir.file_exists(SAVEPATH):
		var res = data_resourse.new()
		var error = ResourceSaver.save(res,SAVEPATH)
		if error != OK:
			printerr("Can't save")
		else:
			print("Created new data")
	
	var resource = load(SAVEPATH)
	MisionesRegister.register = resource.misionResgistro
	Misiones.register = resource.misiones
	FechasMisionRegistro.register = resource.fechasMisionRegistro
	Fechas01.registers = resource.fechas
	
	print("Data loaded")
	#print(resource.misiones)

func save():
	var res = data_resourse.new()
	res.misionResgistro = MisionesRegister.register
	res.misiones = Misiones.register
	res.fechasMisionRegistro = FechasMisionRegistro.register
	res.fechas = Fechas01.registers
	
	var error = ResourceSaver.save(res,SAVEPATH)
	if error != OK:
		printerr("Can't save")
	else:
		print("Saved succesfully")


