extends Node

@onready var httpClientSend = $HTTPClientSend

func create_New_Date(_date: String):
	#get array dates
	var keys = Fechas01.registers.keys() 
	#take the last key and id register
	var id = Fechas01.registers.get(keys[keys.size()-1]).id 
	
	var newFecha = { _date : { "id": id+1, "pomodoro": 0 }} #add the last id +1
	Fechas01.registers.merge(newFecha)
	FechasMisionRegistro.register.merge({newFecha[_date].id : {}})

func add_pomodoro_Display(_todayDate: String):
	var register = Fechas01.registers[_todayDate]
	register.merge({ "id": register.id, "pomodoro": register.pomodoro + 1 }, true)
	
	#  On server Here needs to create the record of Fecha and FechaMisionRegistro
	#  Check if the records already exist so that they are not sent to the server 
	var fechaDB = {}
	httpClientSend.send_Request("GET", "fecha", register.id, {})
	await httpClientSend.error_Return
	if httpClientSend.error == null:
		#  if theres not such record, procede to create the Fecha record
		
		pass
	else:
		fechaDB = httpClientSend.dataRecived
	
	#  if is a Mission Selected : create FechaMisionRegistro 
	

func add_pomodoro_mision(_misionId: int):
	var register = MisionesRegister.register.get(_misionId)
	register.merge({ "mision": register.mision, "pomodoro": register.pomodoro+1 }, true)

func add_pomo_fecha_mision(_misionId: int):
	var today = Fechas01.get_last_Date_Id()
	var fechaMisionRegister = FechasMisionRegistro.register[today]
	if !fechaMisionRegister.has(_misionId):
		fechaMisionRegister.merge({_misionId: 0})
	
	var addedPomo = fechaMisionRegister[_misionId] + 1
	var newRegister = {_misionId: addedPomo}
	fechaMisionRegister.merge(newRegister, true)

func create_new_fecha_mision():
	var newFechaMision = {}
	for id in Misiones.get_Misiones_Id():
		newFechaMision.merge({ id : 0})
	return newFechaMision

func create_new_mision(_name: String):
	#Primero registo cementerio
	var arr = MisionesRegister.register.keys()
	#get the last key and ++ int
	var id = arr[arr.size()-1] + 1
	var newMisionRegister = { id : {"mision": _name, "pomodoro": 0 } }
	MisionesRegister.register.merge(newMisionRegister)
	var newMision = { Misiones.register.size(): {"nombre": _name, "id" : id} }
	Misiones.register.merge(newMision)
