extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	#http://localhost:5074
	$HTTPRequest.request_completed.connect(_on_request_completed)
	#GET REQUEST
	#$HTTPRequest.request("http://localhost:5074")
	#POST REQUEST
	var mision = ""
	var dataToSend = {
		"Nombre" : mision
		}
	var json = JSON.stringify(dataToSend)
	print("Data sended", json)
	var headers = ["Content-Type: application/json"]
	$HTTPRequest.request("http://localhost:5074/misiones/add",headers,HTTPClient.METHOD_POST, json)

func _on_request_completed(result, response_code, headers, body):
	var body_text = body.get_string_from_utf8()
	print("Response body: ", body_text)
	var json = JSON.parse_string(body_text)
	print(json)
	print(result)
	print(response_code)
