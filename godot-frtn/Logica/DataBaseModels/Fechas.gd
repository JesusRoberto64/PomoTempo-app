extends Node
#Fechas registes to fetch
#Ejemplo de modelo de tabla SQL:
# {
#   "2024-07-30" : { "id": 0, "pomodoro": 7 },
#	"2024-07-31" : { "id": 1, "pomodoro": 7 }
#}
var registers = {}

func get_last_Date()-> String:
	var keysArr = registers.keys()
	return keysArr[keysArr.size()-1]

func get_last_Date_Id()-> int:
	var lastDate = get_last_Date()
	return registers.get(lastDate).id
