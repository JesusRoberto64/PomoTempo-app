extends Node2D

@export var mision_array: Array
@export var pomo_arry: Array

signal send_Fetched(_misiones, _pomodoros)

func _on_button_pressed():
	send_Fetched.emit(mision_array,pomo_arry)
