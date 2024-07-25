extends Node
#Registro de misiones con pomodoro, esta no se puede borrar a menos de que 
# no exista pomodoro y no allá del mismo nombre en la tabla de misiones
#Primero se registra aquí una mision luego se copia a la tabla de misiones
# para que corresponda siempre las ids
var register = {
	0: { "mision": "Misión 1", "pomodoro": 11 },
	1: { "mision": "Misión 2", "pomodoro": 7 },
	2: { "mision": "Misión 3", "pomodoro": 28 },
	3: { "mision": "PomoTempo", "pomodoro": 25 },
}
