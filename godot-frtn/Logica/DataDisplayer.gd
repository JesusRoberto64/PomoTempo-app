extends Control

@onready var HTTPREQUEST = $HTTPRequest
@export var end_Point = "endpoint"
@onready var url

func _ready():
	#http://localhost:5074
	url = "http://localhost:5074" + end_Point
	$HTTPRequest.request_completed.connect(_on_request_completed)

func _send_Request():
	var error = $HTTPRequest.request(url)
	if error != OK:
		push_error("An error occurred in the HTTP request.")

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
			stack_Data(data_recived)
		else:
			print("Unexpeted Data")
			print(data_recived)

func stack_Data(data: Array):
	for i in data:
		if i.has("id") and i.has("nombre"):
			var id = Label.new()
			id.text = str(i.id)
			$HBoxContainer/IDContainer.add_child(id)
			
			var nombre = Label.new()
			nombre.text = i.nombre
			$HBoxContainer/MisionContainer.add_child(nombre)
