extends Node2D

@onready var audioBell = $AudioBell
@onready var audioTest = $AudioTest
@onready var anim = $AnimationPlayer

@onready var plusBtn = $Plus
@onready var minusBtn = $Minus

var volume = 0
var maxVol = 12
var minVol = -14

#var VolumSpr #To make sprite feedback volumen

func pomodoro_Alarm():
	anim.play("pomoAlarm")

func break_Alarm():
	anim.play("breakAlarm")

func _on_plus_pressed():
	volume += 2
	volume = min(volume,maxVol)
	audioTest.volume_db = volume
	audioBell.volume_db = volume
	audioTest.play()

func _on_minus_pressed():
	volume -= 2
	volume = max(volume,minVol)
	if volume <= minVol:
		#Mute = volume = -14
		return
	audioTest.volume_db = volume
	audioBell.volume_db = volume
	audioTest.play()



