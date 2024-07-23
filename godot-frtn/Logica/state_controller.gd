extends Node2D
class_name StateController

enum STATE {INIT, DISPLAYREFRESH, GETDATE}
var curState = STATE.INIT

var today
var currentDay
# iniciar la data del día en call_deffer

func get_Today_String(_dateController: Node):
	today = _dateController.get_Today_String()

func set_Date_Display(_dateDisplay):
	_dateDisplay.parse_Date(today)

func set_Panel_Misions(_panelMision):
	
	pass





