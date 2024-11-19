extends HTTPRequest

var url := "http://localhost:5074/api/" 
var error = null
var data_recived = null
#IMPORTANT this signal is a piece to call the await prefix; see parent NODE(boot_loader)
signal error_Return

func _ready() -> void:
	timeout = 3.0

func error_Emmit():
	error_Return.emit()

func _on_request_completed(_result, response_code, _headers, body):
	var body_text = body.get_string_from_utf8()
	var json = JSON.new()
	var err = json.parse(body_text)
	
	if err != OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", body_text, " at line ", json.get_error_line(), "Response code: ", response_code)
		error = "ERROR: " + json.get_error_message() + " code " + str(response_code)
		error_Emmit()
		return
	
	error = null
	data_recived =  json.data
	error_Return.emit()

func fetch_Data(endPoint: String):
	var err = request(url+endPoint)
	
	if err != OK:
		print("Error on send")
	
