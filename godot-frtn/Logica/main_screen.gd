extends StateController

@onready var Pomodoro = $Pomodoro
@onready var Alarm = $Alarm
@onready var PanelMision = $MisionMiniPanel
@onready var AddMision = $AddMision
@onready var DateDisplay = $Fecha_Display
@onready var timerSeterPomo = $Timer_Seter_Pomodoro
@onready var timerSeterBreak = $Timer_Seter_Break

#Clients
@onready var client = $ParsedClient

#STATESCONTROLLER
@onready var dateControlller = $DateController

func _ready():
	Pomodoro.pomodoro_alarm.connect(PanelMision.add_Pomodoro)
	Pomodoro.pomodoro_alarm.connect(DateDisplay.add_Pomodoro)
	Pomodoro.pomodoro_alarm.connect(Alarm.pomodoro_Alarm)
	Pomodoro.break_alarm.connect(Alarm.break_Alarm)
	
	AddMision.send_Mision.connect(PanelMision.add_Mision)
	
	DateDisplay.send_Date_Req.connect(client.response_Id_Date)
	DateDisplay.is_Today.connect(set_Today)
	
	client.send_Mision_Pomo.connect(PanelMision.fetch_Misions)
	client.send_Pomo_Date.connect(DateDisplay.set_Pomodoro)
	client.no_Record.connect(no_Record)
	
	timerSeterPomo.set_Timer.connect(Pomodoro.set_Pomodoro_Timer)
	timerSeterBreak.set_Timer.connect(Pomodoro.set_Break_Timer)
	get_Today_String(dateControlller)
	set_Date_Display(DateDisplay)
	#print(today)


func no_Record():
	PanelMision.reset_Panel()

func set_Today(_bool):
	if _bool:
		AddMision.show()
	else:
		AddMision.hide()


