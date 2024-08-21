extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	#http://localhost:5074
	$HTTPRequest.request_completed.connect(_on_request_completed)
	#================
	
	#GET REQUEST MISION LIST
	#var error = $HTTPRequest.request("http://localhost:5074/misiones")
	#if error != OK:
		#push_error("An error occurred in the HTTP request.")
	
	#DELETE REQUEST
	#var misionId =7
	#var url = "http://localhost:5074/misiones/" + str(misionId)
	#var headers = []
	#var error = $HTTPRequest.request(url,headers,HTTPClient.METHOD_DELETE)
	
	#POST REQUEST NEW MISION
	#var mision = "Mision Start"
	#var dataToSend = {
		#"Nombre" : mision
		#}
	#var json = JSON.stringify(dataToSend)
	#print("Data sended", json)
	#var headers = ["Content-Type: application/json"]
	#$HTTPRequest.request("http://localhost:5074/misiones/add",headers,HTTPClient.METHOD_POST, json)
	
	#PATCH Mision Name
	#var nombre_Nuevo = "Mision Start Update"
	#var mision_Id = 9
	#var data_To_Send = {
		#"Id": mision_Id,
		#"Nombre" : nombre_Nuevo
	#}
	#var json = JSON.stringify(data_To_Send)
	#var headers = ["Content-Type: application/json"]
	#var url = "http://localhost:5074/misiones/update"
	#$HTTPRequest.request(url, headers, HTTPClient.METHOD_PATCH, json)

func _on_request_completed(result, response_code, headers, body):
	var body_text = body.get_string_from_utf8()
	var json = JSON.new()
	var error = json.parse(body_text)
	print(response_code)
	if error != OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", body_text, " at line ", json.get_error_line())
	else:
		var data_recived =  json.data
		if typeof(data_recived) == TYPE_ARRAY:
			print("Data recivida Array")
			print(data_recived)
		elif typeof(data_recived) == TYPE_STRING:
			print("Data String message")
			print(data_recived)
		elif data_recived.has("id"):
			print("Objeto JSON ", typeof(data_recived))
			print(data_recived.id, " " ,data_recived.nombre)
		else:
			print("Unexpeted Data")
			print(data_recived)
