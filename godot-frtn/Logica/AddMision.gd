extends HBoxContainer

enum STATE {SHOW, HIDE, WITHTEXT}

@onready var textEdit: TextEdit = $TextEdit
@onready var button = $Button

signal send_Request(update, mode, id)
@export var client: Node

signal send_Mision(mision: String)

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
	if client == null: 
		send_Mision.emit(textEdit.text)
		textEdit.text = ""
		return
	button.disabled = true
	textEdit.editable = false
	
	send_Request.emit(textEdit.text,"ADD", 0)
	await client.error_Return
	button.disabled = false
	textEdit.text = ""
	textEdit.editable = true
	
	if client.error != null:
		#ERROR
		print("ERROR")
	else:
		#SUCCES
		print("SUCCES")

func disble_Add():
	textEdit.set_editable(false)

func enable_Add():
	textEdit.set_editable(false)

func _input(event):
	if event.is_action_pressed("ui_accept") and textEdit.has_focus():
		on_Button_Pressed()
		textEdit.release_focus()
