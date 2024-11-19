extends Node

enum MODE {CREATE, READ_BUNCH, READ, DELETE, UPDATE}
var curMode = MODE.READ_BUNCH

signal error_Return
var error = ""

@onready var colMisiones
var textDisplay = preload("res://Escenas/Display/text_display.tscn")

var HTTP: HTTPRequest

var recordData: String

func _ready():
	colMisiones = get_node("../ScrollContainer/colMisiones")
	HTTP = HTTPRequest.new()
	add_child(HTTP)
	
	HTTP.request_completed.connect(_on_request_completed)
	send_Request([],"READ_BUNCH", 0)

#This fuction is conncected from a UI or "view" (text_display.tscn) 
#signal, when player activates a button with a request.
func send_Request(data, _mode, _id):
	match _mode:
		"UPDATE":
			curMode = MODE.UPDATE
			#Test
			var dataToSend = {
				"Id": _id,
				"Nombre": data
			}
			var json = JSON.stringify(dataToSend)
			var headers = ["Content-Type: application/json"]
			var url = "http://localhost:5074/api/mision/update"
			HTTP.request(url, headers, HTTPClient.METHOD_PATCH, json)
		"DELETE":
			curMode = MODE.DELETE
			var url = "http://localhost:5074/api/mision/" + str(_id)
			var headers = []
			HTTP.request(url,headers,HTTPClient.METHOD_DELETE)
		"READ_BUNCH":
			curMode = MODE.READ_BUNCH
			HTTP.request("http://localhost:5074/api/mision")
		"ADD":
			curMode = MODE.CREATE
			recordData = data
			var dataToSend = {
				"Nombre": data
			}
			var json = JSON.stringify(dataToSend)
			var headers = ["Content-Type: application/json"]
			HTTP.request("http://localhost:5074/api/mision/add",headers,HTTPClient.METHOD_POST, json)

#This fuction emmits a signal to be catch the sever response
# using the await operator by the client. In this way the UI view
# can be update.
func error_Emmit():
	self.emit_signal("error_Return")

func _on_request_completed(_result, response_code, _headers, body):
	var body_text = body.get_string_from_utf8()
	var json = JSON.new()
	var err = json.parse(body_text)
	
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
			updated_Data(_data_recived)
			pass
		MODE.DELETE:
			updated_Data(_data_recived)
			pass
		MODE.CREATE:
			add_Record(_data_recived)
			pass

func fetch_Bunch_Data(_data):
	if typeof(_data) != TYPE_ARRAY:
		format_Error("Its not an Array")
		return
	
	for i in _data:
		var mision = textDisplay.instantiate()
		mision.id = i.id
		mision.client = self
		mision.call_deferred("set_Nombre",i.nombre)
		colMisiones.add_child(mision)

func fetch_Data(_data):
	pass

func updated_Data(_data):
	if typeof(_data) != TYPE_STRING:
		print(_data.message)
		return
	print("Data updated!")

func format_Error(err):
	print("Format ERROR: ",err)

func add_Record(_data):
	var newMision = textDisplay.instantiate()
	newMision.id
	newMision.id = _data
	newMision.client = self
	newMision.call_deferred("set_Nombre",recordData)
	colMisiones.add_child(newMision)
	pass
