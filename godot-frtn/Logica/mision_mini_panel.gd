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

signal on_Add_Mision(_name: String)

var isMisionSelected :bool = true

func _on_back_pressed():
	if misiones.size() == 0: return
	var nextIndx = curPanel - 1
	#Basic logic to dont let module % return a negative number
	curPanel = (nextIndx % misiones.size() + misiones.size()) % misiones.size()
	titleLabel.text = misiones[curPanel]
	set_Selected_Mision()
	set_Pomodoros_Mision(pomoArr[curPanel])

func _on_forward_pressed():
	if misiones.size() == 0: return
	var nextIndx = curPanel + 1
	titleLabel.text = misiones[nextIndx % misiones.size()]
	curPanel = nextIndx % misiones.size()
	set_Selected_Mision()
	set_Pomodoros_Mision(pomoArr[curPanel])

func _on_selected_toggled(toggled_on):
	if misiones.size() == 0: 
		selectedBtn.button_pressed = false
		return
	if toggled_on:
		curMision = curPanel
		isMisionSelected = true
	elif toggled_on == false and curMision == curPanel:
		curMision = misiones.size()
		isMisionSelected = false

func set_Selected_Mision():
	if curMision != curPanel:
		selectedBtn.button_pressed = false
	else:
		selectedBtn.button_pressed = true

func set_Pomodoros_Mision(_pomodoros: int):
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

func fetch_Misions_Pomodoros(_misiones: Array, _pomodoros: Array):
	if _misiones.size() == 0:
		print("Error empty mision array")
		isMisionSelected = false
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
	set_Pomodoros_Mision(pomoArr[curPanel])

func add_Mision(_new: String):
	misiones.append(_new)
	pomoArr.append(0)
	
	titleLabel.text = misiones[misiones.size()-1]
	curPanel = misiones.size()-1
	curMision = curPanel
	set_Selected_Mision()
	set_Pomodoros_Mision(pomoArr[curPanel])
	on_Add_Mision.emit(_new)

func add_Pomodoro():
	if misiones.size() == 0 or !isMisionSelected: 
		return
	
	pomoArr[curMision] += 1
	
	curPanel = curMision
	titleLabel.text = misiones[curPanel]
	
	set_Pomodoros_Mision(pomoArr[curPanel])
	set_Selected_Mision()

func reset_Panel():
	for i in pomoPanel.get_children():
		i.hide()
	numberLab.text = "x0"
	
	var resetArr = []
	for m in pomoArr.size():
		resetArr.append(0)
	pomoArr = resetArr

func refresh_Pomodoros(_newPomodoros : Array):
	if pomoArr.size() <= 0:
		return
	pomoArr = _newPomodoros
	set_Pomodoros_Mision(pomoArr[curPanel])
	
