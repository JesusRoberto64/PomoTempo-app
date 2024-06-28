extends HBoxContainer

enum STATE {SHOW, HIDE, WITHTEXT}

@onready var textEdit = $TextEdit
@onready var button = $Button

signal send_Request(update, mode, id)
@export var client: Node

var edited_Text :String= ""
var id: int

func _ready():
	button.pressed.connect(on_Button_Pressed)
	
	if client != null and client.has_method("send_Request"):
		send_Request.connect(client.send_Request)
	else:
		client = null

func on_Button_Pressed():
	if textEdit.text == "":
		textEdit.placeholder_text = "Add a name!"
		return
	if client == null: return
	button.disabled = true
	
	send_Request.emit(textEdit.text,"ADD", 0)
	await client.error_Return
	button.disabled = false
	
	if client.error != null:
		#ERROR
		print("ERROR")
	else:
		#SUCCES
		print("SUCCES")
	
