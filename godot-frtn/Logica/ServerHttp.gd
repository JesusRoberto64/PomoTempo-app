extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	#http://localhost:5074
	$HTTPRequest.request_completed.connect(_on_request_completed)
	#GET REQUEST
	var error = $HTTPRequest.request("http://localhost:5074/misiones/1")
	if error != OK:
		push_error("An error occurred in the HTTP request.")
	
	#POST REQUEST
	#var mision = ""
	#var dataToSend = {
		#"Nombre" : mision
		#}
	#var json = JSON.stringify(dataToSend)
	#print("Data sended", json)
	#var headers = ["Content-Type: application/json"]
	#$HTTPRequest.request("http://localhost:5074/misiones/add",headers,HTTPClient.METHOD_POST, json)



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
		elif data_recived.has("id"):
			print("Objeto JSON")
			print(data_recived.id, " " ,data_recived.nombre)
		else:
			print("Unexpeted Data")
			print(data_recived)


