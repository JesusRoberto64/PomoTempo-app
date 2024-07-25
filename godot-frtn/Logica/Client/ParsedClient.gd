extends Node

func create_New_Date(_date: String):
	var newFecha = { _date : { "id": Fechas01.registers.size(), "pomodoro": 0 } }
	Fechas01.registers.merge(newFecha)
	
	var newFechaMision = create_new_fecha_mision()
	FechasMisionRegistro.register.merge({newFecha[_date].id : newFechaMision})

func create_new_fecha_mision():
	var newFechaMision = {}
	for id in Misiones.get_Misiones_Id():
		newFechaMision.merge({ id : 0})
	return newFechaMision

func create_new_mision(_name: String):
	#primero registo cementerio
	var id = MisionesRegister.register.size()
	var newMision = { id : {"mision": _name, "pomodoro": 0 } }
	MisionesRegister.register.merge(newMision)
	print(MisionesRegister.register)
	
	pass
