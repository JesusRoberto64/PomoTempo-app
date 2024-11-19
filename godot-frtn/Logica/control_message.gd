extends Control

@onready var lab = $Panel/Label
@onready var anim = $AnimationPlayer

func _ready() -> void:
	$Panel.hide()

func show_Message(text: String)-> void:
	anim.play("show")
	if typeof(text) != TYPE_STRING :
		lab.text = "none string...{}"
		return
	lab.text = text

func hide_Message()-> void:
	anim.play_backwards("show")
