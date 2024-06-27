extends Node

enum MODE {CREATE, READ_BUNCH, READ, DELETE, UPDATE}
var curMode = MODE.READ_BUNCH

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
	var err = HTTP.request("http://localhost:5074/misiones")
	if err != OK:
		push_error("An error occurred in the HTTP request.")

#This fuction is conncected from a UI or "view" signal, 
#when player activates a button with a reques.
func send_Request(data, _mode, _id):
	print(data, " from ", _mode, " Id: ", _id)
	
	#Request 
	match _mode:
		"UPDATE":
			curMode = MODE.UPDATE
			#Test 
			#To fake the delay request from network
			var tween = get_tree().create_tween()
			tween.tween_callback(error_Emmit).set_delay(3)
			pass
	
	#To fake the delay request from network
	#var tween = get_tree().create_tween()
	#tween.tween_callback(error_Emmit).set_delay(3)

#This fuction emmits a signal to be catch the sever response
# using the await operator by the client. In this way the UI view
# can be update.
func error_Emmit():
	self.emit_signal("error_Return")

func _on_request_completed(_result, response_code, _headers, body):
	var body_text = body.get_string_from_utf8()
	var json = JSON.new()
	var err = json.parse(body_text)
	#print(response_code)
	if err != OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", body_text, " at line ", json.get_error_line(), "Response code: ", response_code)
		error = "ERROR: " + json.get_error_message() + " code: " + str(response_code)
		error_Emmit()
		return
	
	error = null
	error_Emmit()
	var data_recived =  json.data
	mode_Match(data_recived)

func mode_Match(_data_recived):
	match curMode:
		MODE.READ_BUNCH:
			fetch_Bunch_Data(_data_recived)
		MODE.READ:
			pass
		MODE.UPDATE:
			pass

func fetch_Bunch_Data(data):
	if typeof(data) != TYPE_ARRAY:
		format_Error("Its not an Array")
		return
	
	for i in data:
		var mision = textDisplay.instantiate()
		mision.id = i.id
		mision.client = self
		mision.call_deferred("set_Nombre",i.nombre)
		colMisiones.add_child(mision)

func fetch_Data(_data):
	
	pass

func format_Error(err):
	print("Format ERROR: ",err)
