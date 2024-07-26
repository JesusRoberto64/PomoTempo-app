extends Node
#Fechas registes to fetch
var registers = {
	"2024-07-11" : {"id": 0, "pomodoro": 5 },
	"2024-07-12" : {"id": 1, "pomodoro": 8 },
	"2024-07-13" : {"id": 2, "pomodoro": 13 },
	"2024-07-20" : {"id": 3, "pomodoro": 18 },
	"2024-07-21" : {"id": 4, "pomodoro": 16 },
	"2024-07-22" : {"id": 5, "pomodoro": 15 },
	"2024-07-23" : {"id": 6, "pomodoro": 5 },
}

func get_last_Date()-> String:
	var keysArr = registers.keys()
	return keysArr[keysArr.size()-1]

func get_last_Date_Id()-> int:
	var lastDate = get_last_Date()
	return registers.get(lastDate).id
