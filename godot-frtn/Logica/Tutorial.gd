extends Control

var texts = [
"Contoles básicos para empezar un Pomodoro Play/Pause",
"Puedes salatarte Pomodoros o descansos.",
"Selecciona estos botones para configurar los tiempos.",
"Subir o bajar el volumen de la alarma.",
"Para agragar misione escribela y preciona el botón.",
"Recuerda siempre seleccionar la misión en la que quieras trabajar."
]

@onready var anim = $AnimationPlayer
@onready var textLab = $Panel/Label

var curText = -1

func next():
	curText += 1
	if curText >= texts.size():
		queue_free()
		return
	
	textLab.text = texts[curText]
	anim.play("Tuto-" + str(curText))
	


func _input(event):
	if event.is_action_pressed("ui_accept"):
		next()
