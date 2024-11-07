extends HTTPRequest

var url := "http://localhost:5074/api/" 
var error = null
var data_recived = null

signal error_Return

func error_Emmit():
	print(get_http_client_status())
	error_Return.emit()

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
	data_recived =  json.data

func fetch_Mision():
	
	var err = request(url+"mision")
	
	if err != OK:
		error = "Cant connect..."
		error_Return.emit()
	
	print(RESULT_CONNECTION_ERROR)
	error = null
	
	#Temporal
	#var tween = get_tree().create_tween()
	#tween.tween_callback(error_Emmit).set_delay(1)
