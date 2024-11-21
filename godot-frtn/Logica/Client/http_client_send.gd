extends HTTPRequest

@onready var controlMessage = $ControlMessage
var url := "http://localhost:5074/api/" 
signal error_Return
var error = null
var dataRecived

func _ready() -> void:
	request_completed.connect(_on_request_completed)
	timeout = 0.5

func send_Request(mode, endPoint: String, _id, _data: Dictionary)-> void :
	#_data must be a json with the model(class C#) = {}
	# {"Property" : value, ...}
	controlMessage.show_Message("Saving...")
	match mode:
		"UPDATE":
			pass
		"DELETE":
			pass
		"CREATE":
			var json = JSON.stringify(_data)
			var headers = ["Content-Type: application/json"]
			request(url + endPoint + "/add", headers, HTTPClient.METHOD_POST, json)
		"GET":
			request(url + endPoint + "/" + str(_id))

func _on_request_completed(_result, response_code, _headers, body):
	var body_text = body.get_string_from_utf8()
	var json = JSON.new()
	var err = json.parse(body_text)
	
	if err != OK:
		print("JSON parse error: ", json.get_error_message(), " in ", body_text, " at line ", json.get_error_line(), " Response code: ", response_code)
		error = "ERROR: " + json.get_error_message() + " code: " + str(response_code)
		error_Return.emit()
		controlMessage.show_Message(error)
		return
	
	dataRecived = json.data
	if dataRecived.has("status"):
		if dataRecived["status"] == 404:
			error = "Record not found"
			controlMessage.show_Message(error)
			error_Return.emit()
			return
	if dataRecived.has("Id"):
		dataRecived = dataRecived["Id"]
	
	error = null
	error_Return.emit()

func hide_Message():
	controlMessage.hide_Message()
