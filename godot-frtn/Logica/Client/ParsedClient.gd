extends Node

signal send_Pomo_Date(_pomo: int)
signal send_Mision_Pomo(misionArr, pomoArr)

signal theres_Record
signal no_Record

var idCurrentDate = null

#with fetched data of the 30s days
# Get the id from a Date main stream of requisitions
func response_Id_Date(_req):
	if Fechas01.registers.has(_req):
		idCurrentDate = Fechas01.registers[_req].id
		send_Pomo_Date.emit(Fechas01.registers[_req].pomodoro) 
		get_Fetch_Panel_Data(idCurrentDate)
		theres_Record.emit()
	else:
		no_Record.emit()

func get_Fetch_Panel_Data(_id):
	var fetchedDict = FechasMisionRegistro.register[_id]
	var misiones = []
	var pomodoros = []
	for i in fetchedDict.keys():
		misiones.append(Misiones.register[i])
		pomodoros.append(fetchedDict[i])
	
	send_Mision_Pomo.emit(misiones, pomodoros)



