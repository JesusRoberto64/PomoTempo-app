extends Node

signal error_Return
var error = ""

@onready var colMisiones
var textDisplay = preload("res://Escenas/text_display.tscn")

func _ready():
	colMisiones = get_node("../ScrollContainer/colMisiones")
	#GET REQUEST MISION LIST
	var HTTP = HTTPRequest.new()
	add_child(HTTP)
	
	HTTP.request_completed.connect(_on_request_completed)
	var error = HTTP.request("http://localhost:5074/misiones")
	if error != OK:
		push_error("An error occurred in the HTTP request.")
	

func send_Request(data: String, variant):
	print(data, " from ", variant)
	var tween = get_tree().create_tween()
	tween.tween_callback(error_Emmit).set_delay(3)
	pass

func error_Emmit():
	error = null
	self.emit_signal("error_Return")
	print(" in func error")

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
			fetch_Data(data_recived)
		else:
			print("Unexpeted Data")
			print(data_recived)

func fetch_Data(data):
	for i in data:
		var mision = textDisplay.instantiate()
		mision.id = i.id
		mision.client = self
		mision.call_deferred("set_Nombre",i.nombre)
		colMisiones.add_child(mision)
	pass
