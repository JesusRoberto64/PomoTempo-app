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
	Pomodoro.pomodoro_alarm.connect(on_Add_Pomodoro)
	Pomodoro.break_alarm.connect(Alarm.break_Alarm)
	
	AddMision.send_Mision.connect(PanelMision.add_Mision)
	AddMision.on_Text_Edit.connect(keys_blocked)
	
	PanelMision.on_Add_Mision.connect(Client.create_new_mision)
	
	DateDisplay.on_Date_Change.connect(on_Date_Change)
	
	timerSeterPomo.set_Timer.connect(Pomodoro.set_Pomodoro_Timer)
	timerSeterBreak.set_Timer.connect(Pomodoro.set_Break_Timer)
	
	init_Today(DateControlller, DateDisplay, PanelMision, Client)

func on_Date_Change(_add):
	currentDay = DateControlller.adjust_Days(currentDay,_add)
	update_date_display()
	
	if !Fechas01.registers.has(currentDay): 
		PanelMision.reset_Panel()
	else:
		update_pomodoro_display()

func update_date_display():
	set_Date_Display(DateDisplay, currentDay)
	DateDisplay.currentDay = currentDay

func update_pomodoro_display():
	fetch_Date_Pomodoro(DateDisplay, currentDay)
	var refreshPomo = get_Pomodoro_Date_Arr(currentDay)
	PanelMision.refresh_Pomodoros(refreshPomo)

func on_Add_Pomodoro():
	Client.add_pomodoro_Display(today)
	if PanelMision.isMisionSelected:
		var curretMisionId = get_current_Mision_Id()
		add_pomodoro_to_mision(curretMisionId)
	if currentDay != today:
		currentDay = today
		update_date_display()
		DateDisplay.forwardBtn.disabled = true
		update_pomodoro_display()

func add_pomodoro_to_mision(_misionId: int):
	Client.add_pomodoro_mision(_misionId)
	Client.add_pomo_fecha_mision(_misionId)

func get_current_Mision_Id()->int:
	var curMisionIndex :int = PanelMision.curMision
	return Misiones.register[curMisionIndex].id

func keys_blocked(_Isinput: bool):
	Pomodoro.keysBlocked = _Isinput
