extends StateController

@onready var Pomodoro = $Pomodoro
@onready var Alarm = $Alarm
@onready var PanelMision = $MisionMiniPanel
@onready var AddMision = $AddMision
@onready var DateDisplay = $Fecha_Display
@onready var timerSeterPomo = $Timer_Seter_Pomodoro
@onready var timerSeterBreak = $Timer_Seter_Break

@onready var Client = $Client

@onready var DateControlller = $DateController

func _ready():
	Pomodoro.pomodoro_alarm.connect(PanelMision.add_Pomodoro)
	Pomodoro.pomodoro_alarm.connect(DateDisplay.add_Pomodoro)
	Pomodoro.pomodoro_alarm.connect(Alarm.pomodoro_Alarm)
	Pomodoro.break_alarm.connect(Alarm.break_Alarm)
	
	AddMision.send_Mision.connect(PanelMision.add_Mision)
	
	PanelMision
	
	DateDisplay.on_Date_Change.connect(on_Date_Change)
	
	timerSeterPomo.set_Timer.connect(Pomodoro.set_Pomodoro_Timer)
	timerSeterBreak.set_Timer.connect(Pomodoro.set_Break_Timer)
	
	init_Today(DateControlller, DateDisplay, PanelMision, Client)

func on_Date_Change(_add):
	currentDay = DateControlller.adjust_Days(currentDay,_add)
	set_Date_Display(DateDisplay, currentDay)
	DateDisplay.currentDay = currentDay
	
	if !Fechas01.registers.has(currentDay): 
		PanelMision.reset_Panel()
		return
	
	fetch_Date_Pomodoro(DateDisplay, currentDay)
	var refreshPomo = get_Pomodoro_Date_Arr(currentDay)
	PanelMision.refresh_Pomodoros(refreshPomo)
	





