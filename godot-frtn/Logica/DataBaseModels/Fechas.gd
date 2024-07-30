extends Node
#Fechas registes to fetch
var registers = {}

func get_last_Date()-> String:
	var keysArr = registers.keys()
	return keysArr[keysArr.size()-1]

func get_last_Date_Id()-> int:
	var lastDate = get_last_Date()
	return registers.get(lastDate).id
