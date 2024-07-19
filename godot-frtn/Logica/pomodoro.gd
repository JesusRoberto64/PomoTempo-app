extends Node2D

enum STATE {PAUSE, PLAY, SKIP, HOLD}
var curState = STATE.HOLD
var holdTime = 0.0

enum POMOSTATE {POMODORO, BREAK}
var curPomoState = POMOSTATE.POMODORO

@export var Pomodoro:float = 1500
@export var Break:float = 300

@onready var timer = $Timer
@onready var timerLab = $TimerLab
@onready var labPomodoro: Sprite2D = $LabPomodoro
@onready var labBreak: Sprite2D = $LabBreak

@onready var playPauseBtn: Button = $playPause
@onready var skipBtn: Button = $skip

signal timeout(mode)
signal break_alarm
signal pomodoro_alarm

@onready var clackSnd = $clack
@onready var clack2Snd = $clack2

func _ready():
	timer.wait_time = Pomodoro
	holdTime = Pomodoro
	timerLab.text = set_Time_Format(Pomodoro)
	set_Pomodoro_State()

func _process(_delta):
	timerLab.text = set_Time_Format(timer.time_left)
	match curState:
		STATE.HOLD:
			timerLab.text = set_Time_Format(holdTime)
		STATE.SKIP:
			playPauseBtn.toggle_mode = true
			curState = STATE.HOLD
			pass

func set_Time_Format(time: float):
	var minute = fmod(time,3600) / 60
	var second = fmod(time,60)
	return "%02d:%02d" % [minute, second]

func set_Pomodoro_State():
	if curPomoState == POMOSTATE.POMODORO:
		labPomodoro.show()
		labBreak.hide()
	else:
		labPomodoro.hide()
		labBreak.show()

func _on_play_pause_pressed():
	clackSnd.play()
	if curState == STATE.PAUSE or curState == STATE.HOLD:
		timer.start(timer.time_left)
		timer.set_paused(false)
		curState = STATE.PLAY
	elif curState == STATE.PLAY:
		timer.set_paused(true)
		curState = STATE.PAUSE
	playPauseBtn.release_focus()

func change_Pomodoro_State():
	clack2Snd.play()
	if curPomoState == POMOSTATE.POMODORO:
		curPomoState = POMOSTATE.BREAK
		labPomodoro.hide()
		labBreak.show()
		timer.wait_time = Break
		holdTime = Break
	else:
		curPomoState = POMOSTATE.POMODORO
		labPomodoro.show()
		labBreak.hide()
		timer.wait_time = Pomodoro
		holdTime = Pomodoro
	
	playPauseBtn.toggle_mode = false
	playPauseBtn.release_focus()
	skipBtn.release_focus()
	timer.stop()
	curState = STATE.SKIP

func _on_skip_pressed():
	change_Pomodoro_State()

func alarm_Timeout():
	if curPomoState == POMOSTATE.POMODORO:
		pomodoro_alarm.emit()
	else:
		break_alarm.emit()
	change_Pomodoro_State()

func set_Pomodoro_Timer(_time):
	Pomodoro = _time
	timer.wait_time = Pomodoro
	if curPomoState == POMOSTATE.POMODORO:
		holdTime = Pomodoro

func set_Break_Timer(_time):
	Break = _time
	timer.wait_time = Break
	if curPomoState == POMOSTATE.BREAK:
		holdTime = Break

