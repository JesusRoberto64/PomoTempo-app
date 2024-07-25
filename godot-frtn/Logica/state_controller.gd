extends Node2D
class_name StateController

var today
var currentDay

func init_Today(_dateController: Node, _dateDisplay: Node2D, _panelMision: Node2D, _client: Node):
	today = _dateController.get_Today_String()
	currentDay = today
	set_Date_Display(_dateDisplay,today)
	_dateDisplay.today = today
	_dateDisplay.currentDay = today
	
	var misionesArr = Misiones.get_Misiones()
	var pomodorosArr = get_Pomodoro_Today_Arr(today, _client)
	_panelMision.fetch_Misions_Pomodoros(misionesArr,pomodorosArr)
	
	fetch_Date_Pomodoro(_dateDisplay,today)

func set_Date_Display(_dateDisplay: Node2D, _date: String):
	_dateDisplay.parse_Date(_date)

func fetch_Date_Pomodoro(_dateDisplay: Node2D, _date: String):
	_dateDisplay.set_Pomodoro(Fechas01.registers[_date].pomodoro)

func fetch_Panel_Date(_panelMision: Node2D, _date: String):
	var misionesArr = Misiones.get_Misiones()
	var pomodorosArr = get_Pomodoro_Date_Arr(_date)
	_panelMision.fetch_Misions(misionesArr,pomodorosArr)

func get_Pomodoro_Date_Arr(_date: String)->Array:
	var idDay = Fechas01.registers[_date].id
	var regiterDay = FechasMisionRegistro.register[idDay]
	return get_pomodoro_array(regiterDay)

func get_Pomodoro_Today_Arr(_date: String, _client: Node)->Array:
	var fechas = Fechas01.registers
	var fechaMision = FechasMisionRegistro.register
	if !fechas.has(_date):
		_client.create_New_Date(_date)
	var idDay = fechas[_date].id
	var regiterDay = fechaMision[idDay]
	return get_pomodoro_array(regiterDay)

func get_pomodoro_array(_registerDay)->Array:
	var pomodoroArr = []
	for id in Misiones.get_Misiones_Id():
		if _registerDay.has(id):
			pomodoroArr.append(_registerDay[id])
		else:
			pomodoroArr.append(0)
	return pomodoroArr

