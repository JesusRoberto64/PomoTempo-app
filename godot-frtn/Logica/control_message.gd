extends Control

@onready var lab = $Panel/Label
@onready var anim = $AnimationPlayer

func show_Message(text: String)-> void:
	anim.play("show")
	lab.text = text

func hide_Message()-> void:
	anim.play_backwards("show")
