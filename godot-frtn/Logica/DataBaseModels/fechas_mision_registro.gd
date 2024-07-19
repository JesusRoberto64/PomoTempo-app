extends Node
#Fechas id(int) : {idMisiones(Array) : pomdotos(in), etc... }
# Im serching to register pomodotos per mision per date(fecha)
var register = {
	0 : { 0:2, 1:3 },
	1 : { 2:4 },
	2 : { 2:10, 3:3 },
	3 : { 2:10, 3:3 },
	4 : { 0:4, 1:4, 2:4, 3:4 },
	5 : { 3:15 },
	6 : { 0:5 }
}

func add_Regiter(_id):
	if register.has(_id):
		
		pass
	else:
		var newEntry = { _id : { 0 : 0 } }
		register.merge(newEntry)
		print(register)
		pass
	pass
