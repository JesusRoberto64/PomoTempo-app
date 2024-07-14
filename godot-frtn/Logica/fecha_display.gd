extends Node2D

@onready var pomodorosLab = $pomdoros
@onready var dayLab = $calendarText/VBoxContainer/dia
@onready var monthLab = $calendarText/VBoxContainer/mes

@onready var backBtn = $back
@onready var forwardBtn = $forwar

var pomodoro: int = 0

var monDict = {1:"ENE",2:"FEB",3:"MAR",4:"ABR",5:"MAY",6:"JUN",7:"JUL",8:"AGO",9:"SEP",10:"OCT",11:"NOV",12:"DIC"}
var today
var currentDay

@onready var DateArith = $DateArithmethics 

signal send_Date_Req(_date)
signal is_Today(_bool)


func _ready():
	var t = Time.get_date_dict_from_system()
	today = {"year": t.year, "month": t.month, "day": t.day}
	currentDay = today 
	forwardBtn.disabled = true
	#Format Date is "YEAR-Month-Day" in integers Ex. 2024-01-01
	#parse_date is use to convert Time dictionary same as the Database format
	#format_date is use to draw in the UI as calendar returning strings
	#process_Date(today)
	call_deferred("process_Date", today)

func process_Date(_curDate):
	var formated_Date = format_Date(_curDate)
	send_Date_Req.emit(formated_Date)
	parse_Date(formated_Date)

#Get today date & Change format date
func format_Date(curDate):
	var y = str(curDate["year"])
	var m = "%02d" % curDate["month"]
	var d = "%02d" % curDate["day"]
	return y +"-"+ m +"-"+ d

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
	currentDay = DateArith.add_days(currentDay, -1)
	process_Date(currentDay)
	print("is NOT today")
	is_Today.emit(false)

func _on_forwar_pressed():#Days After 
	set_Pomodoro(0)
	currentDay = DateArith.add_days(currentDay, 1)
	process_Date(currentDay)
	#To dont display days after today.
	if currentDay == today: 
		forwardBtn.disabled = true
		is_Today.emit(true)
	else:
		is_Today.emit(false)


func set_Pomodoro(_pomodoro: int):
	pomodoro = _pomodoro
	pomodorosLab.text = "x" + str(pomodoro)

func add_Pomodoro():
	pomodoro += 1
	pomodorosLab.text = "x" + str(pomodoro)
