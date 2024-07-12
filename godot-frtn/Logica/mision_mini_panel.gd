extends Node2D

@onready var pomoPanel = $PomoPanel
@onready var titleLabel = $tilteMision/Label
@onready var numberLab = $numberLab

@onready var backBtn = $Back
@onready var forwardBtn = $Forward
@onready var selectedBtn = $Selected

@export var misiones = ["Misión 1", "Misión 2", "Misión 3",
						"Misión 4", "Misión 5", "Misión 6"]

@export var pomoArr = [99,10,0,3,0,0]

var curPanel = 0
var curMision = 0

func _ready():
	titleLabel.text = misiones[curPanel]
	set_Selected_Mision()
	get_Pomodoros_Mision(pomoArr[curPanel])

func _on_back_pressed():
	var nextIndx = curPanel - 1
	#Basic logic to dont let module % return a negative number
	curPanel = (nextIndx % misiones.size() + misiones.size()) % misiones.size()
	titleLabel.text = misiones[curPanel]
	set_Selected_Mision()
	get_Pomodoros_Mision(pomoArr[curPanel])

func _on_forward_pressed():
	var nextIndx = curPanel + 1
	titleLabel.text = misiones[nextIndx % misiones.size()]
	curPanel = nextIndx % misiones.size()
	set_Selected_Mision()
	get_Pomodoros_Mision(pomoArr[curPanel])

func _on_selected_toggled(toggled_on):
	if toggled_on:
		curMision = curPanel
		return
	if toggled_on == false and curMision == curPanel:
		curMision = misiones.size()
		return

func set_Selected_Mision():
	if curMision != curPanel:
		selectedBtn.button_pressed = false
	else:
		selectedBtn.button_pressed = true

func get_Pomodoros_Mision(_pomodoros):
	#tomar la mision id
	numberLab.text = "x" + str(_pomodoros)
	
	if _pomodoros > pomoPanel.get_child_count():
		for i in pomoPanel.get_children():
			i.show()
		return
	
	for i in pomoPanel.get_children():
		i.hide()
	
	for i in range(_pomodoros):
		pomoPanel.get_child(i).show()

#
func fetch_Misions(_misiones, _pomodoros):
	if _misiones.size() == 0:
		print("Error empty array")
		return
	if _misiones.size() != _pomodoros.size():
		print("Error Misions and Pomodoros not syncroniced")
		return
	
	misiones = _misiones
	pomoArr = _pomodoros
	
	curPanel = 0
	titleLabel.text = misiones[curPanel]
	curMision = curPanel
	
	set_Selected_Mision()
	get_Pomodoros_Mision(pomoArr[curPanel])


func add_Mision(_new):
	if typeof(_new) == TYPE_STRING:
		misiones.append(_new)
		pomoArr.append(0)
	else:
		print("Error Format: expected string or array")
		return
	
	titleLabel.text = misiones[misiones.size()-1]
	curPanel = misiones.size()-1
	curMision = curPanel
	set_Selected_Mision()
	get_Pomodoros_Mision(pomoArr[curPanel])

func add_Pomodoro():
	pomoArr[curMision] += 1
	
	curPanel = curMision
	titleLabel.text = misiones[curPanel]
	
	get_Pomodoros_Mision(pomoArr[curPanel])
	set_Selected_Mision()

