extends Node2D

@onready var pomodorosLab = $pomdoros
@onready var dayLab = $calendarText/dia
@onready var monthLab = $calendarText/mes

@onready var backBtn = $back
@onready var forwardBtn = $forwar

var pomodoro: int = 0

var monDict = {1:"ENE",2:"FEB",3:"MAR",4:"ABR",5:"MAY",6:"JUN",7:"JUL",8:"AGO",9:"SEP",10:"OCT",11:"NOV",12:"DIC"}
var today
var currentDay

signal on_Date_Change(_add)

func parse_Date(_date:String):
	#get_slice is a in Godot fuction to get portions of string in between
	# the first parameter character, in this case "-", but normally is use "/"
	var month = _date.get_slice("-",1)
	var day = _date.get_slice("-",2)
	#convert the integer from month in string from the mesDict
	monthLab.text = monDict[int(month)]
	dayLab.text = day

#Send request signal
func _on_back_pressed():#Days Before
	# To enable forward button
	if currentDay == today: 
		forwardBtn.disabled = false
	set_Pomodoro(0)
	on_Date_Change.emit(-1)

func _on_forwar_pressed():#Days After 
	set_Pomodoro(0)
	on_Date_Change.emit(1)
	#To dont display days after today.
	if currentDay == today: 
		forwardBtn.disabled = true

func set_Pomodoro(_pomodoro: int):
	pomodoro = _pomodoro
	pomodorosLab.text = "x" + str(pomodoro)

func add_Pomodoro():
	pomodoro += 1
	pomodorosLab.text = "x" + str(pomodoro)
