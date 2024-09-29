extends Node
#Registro de misiones con pomodoro, esta no se puede borrar a menos de que 
# no exista pomodoro y no allá del mismo nombre en la tabla de misiones
#Primero se registra aquí una mision luego se copia a la tabla de misiones
# para que corresponda siempre las ids
#Ejemplo:
#{
#	0#id de Misiones# : { "mision": "nueva mision", "pomodoro": 13 },
#	1: { "mision": "Escribir Ensayo", "pomodoro": 13 }
#}
var register = {}
