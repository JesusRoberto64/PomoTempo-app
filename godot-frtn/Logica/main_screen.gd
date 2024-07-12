extends Node2D

@onready var Pomodoro = $Pomodoro
@onready var Alarm = $Alarm
@onready var PanelMision = $MisionMiniPanel
@onready var AddMision = $AddMision

func _ready():
	Pomodoro.pomodoro_alarm.connect(Alarm.pomodoro_Alarm)
	Pomodoro.break_alarm.connect(Alarm.break_Alarm)
	Pomodoro.pomodoro_alarm.connect(PanelMision.add_Pomodoro)
	
	AddMision.send_Mision.connect(PanelMision.add_Mision)
	
