extends Node2D

@onready var titlLab = $seterLab

@onready var upBtn = $Up
@onready  var downBtn = $Down

@onready var minuteBtn = $MinuteBtn
@onready var secBtn = $SecdsBtsn

@export var minutes = 25
@export var seconds = 0
@export var setName = "Pomodoro"

signal set_Timer(_time)

func _ready():
	minuteBtn.text = str(minutes)
	titlLab.text = setName

func _on_up_pressed():
	if minuteBtn.button_pressed:
		minutes += 1
		if minutes > 59:
			minutes = 0
		minuteBtn.text = "%02d" % minutes
	elif  secBtn.button_pressed:
		seconds += 1
		if seconds > 59:
			seconds = 1
		secBtn.text = "%02d" % seconds
	send_To_Second(minutes,seconds)

func _on_down_pressed():
	if minuteBtn.button_pressed:
		minutes -= 1
		if minutes < 0:
			minutes = 59
		minuteBtn.text = "%02d" % minutes
	elif  secBtn.button_pressed:
		seconds -= 1
		if seconds < 1:
			seconds = 59
		secBtn.text = "%02d" % seconds
	send_To_Second(minutes,seconds)

func _on_minute_btn_toggled(toggled_on):
	if toggled_on:
		secBtn.button_pressed = false

func _on_secds_btsn_toggled(toggled_on):
	if toggled_on:
		minuteBtn.button_pressed = false

func send_To_Second(_min, _sec):
	var t = (_min*60) + _sec
	set_Timer.emit(t)
