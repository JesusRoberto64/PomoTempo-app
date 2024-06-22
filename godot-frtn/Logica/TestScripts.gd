extends Node

signal error_Return
var error = ""

func send_Request(data: String, variant):
	print(data, " from ", variant)
	var tween = get_tree().create_tween()
	tween.tween_callback(error_Emmit).set_delay(3)
	pass

func error_Emmit():
	self.emit_signal("error_Return")
	error = "No conection"
	print(" in func error")

