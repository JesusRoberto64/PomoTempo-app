extends Node
#Fechas registes to fetch
var registers = {
	"2024-07-01" : {"id": 0, "pomodoro": 5 },
	"2024-07-02" : {"id": 1, "pomodoro": 8 },
	"2024-07-03" : {"id": 2, "pomodoro": 13 },
	"2024-07-04" : {"id": 3, "pomodoro": 18 },
	"2024-07-05" : {"id": 4, "pomodoro": 16 },
	"2024-07-06" : {"id": 5, "pomodoro": 15 },
	"2024-07-07" : {"id": 6, "pomodoro": 5 },
}

func print_Register():
	print(registers)

func add_Register(_today):
	print(_today)
	if registers.has(_today):
		print("Has regiter of today")
	else:
		print("Has NOT today register")
		var lastEntry = registers.keys()[registers.size()-1]
		var lastId = registers.get(lastEntry).id
		var newEntry = {
			_today : {"id": lastId+1, "pomodoro" : 0 }
		}
		registers.merge(newEntry)
		print_Register()
		FechasMisionRegistro.add_Regiter(lastId+1)
		pass
	pass
