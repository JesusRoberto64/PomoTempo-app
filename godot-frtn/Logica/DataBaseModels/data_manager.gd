extends Node

@export var data_resourse: Script

func _ready():
	#load
	var dir = DirAccess.open("res://Recursos/SavedData/")
	if !dir.file_exists("res://Recursos/SavedData/save_data_00.tres"):
		var res = data_resourse.new()
		var error = ResourceSaver.save(res,"res://Recursos/SavedData/save_data_00.tres")
		if error != OK:
			printerr("Can't save")

