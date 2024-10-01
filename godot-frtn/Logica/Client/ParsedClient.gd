extends Node

func create_New_Date(_date: String):
	var newFecha = { _date : { "id": Fechas01.registers.size(), "pomodoro": 0 }}
	Fechas01.registers.merge(newFecha)
	FechasMisionRegistro.register.merge({newFecha[_date].id : {}})

func add_pomodoro_Display(_todayDate: String):
	var register = Fechas01.registers[_todayDate]
	register.merge({ "id": register.id, "pomodoro": register.pomodoro + 1 }, true)

func add_pomodoro_mision(_misionId: int):
	var register =  MisionesRegister.register[_misionId]
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
	var id = MisionesRegister.register.size()
	var newMisionRegister = { id : {"mision": _name, "pomodoro": 0 } }
	MisionesRegister.register.merge(newMisionRegister)
	var newMision = { Misiones.register.size(): {"nombre": _name, "id" : id} }
	Misiones.register.merge(newMision)
