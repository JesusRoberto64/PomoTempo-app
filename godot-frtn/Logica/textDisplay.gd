extends VBoxContainer

@onready var text_Edit = $HBoxContainer/TextEdit
@onready var option_Button = $HBoxContainer/OptionButton
@onready var cancel = $HBoxContainer/cancel
@onready var save = $HBoxContainer/save
@onready var error_Lab = $error

signal send_Request(update, variant)
@export var client: Node

var edited_Text :String= ""
var id: int

func _ready():
	if client != null and client.has_method("send_Request"):
		send_Request.connect(client.send_Request)
	else:
		client = null
	
	edited_Text = text_Edit.text
	option_Button.item_selected.connect(_on_item_selected)
	cancel.pressed.connect(_on_cancel_pressed)
	save.pressed.connect(_on_save_pressed)

func _on_item_selected(index: int):
	match index:
		0:# Edit Text
			text_Edit.editable = true
			cancel.visible = true
			save.visible = true
			edited_Text = text_Edit.text
		1: #Remove
			cancel.visible = true
			save.visible = true
			reset_text_edit()
		2: #Hide
			_on_cancel_pressed()

func _on_cancel_pressed():
	reset_text_edit()
	save.hide()
	cancel.hide()
	error_Lab.hide()
	option_Button.selected = -1

func _on_save_pressed():
	#on edit button
	if option_Button.selected == 0 and text_Edit.text != "":
		text_Edit.editable = false
		disable_Buttons()
		
		if client == null:
			enable_Buttons()
			error_Lab.show()
			error_Lab.text = "No cliente"
			text_Edit.editable = true
			return
		
		send_Request.emit(text_Edit.text, self)
		await client.error_Return
		
		if client.error != null:
			enable_Buttons()
			error_Lab.show()
			error_Lab.text = "Error: " + client.error
			return
		
		enable_Buttons()
		save.hide()
		cancel.hide()
		option_Button.selected = -1
		edited_Text = text_Edit.text
	elif text_Edit.text == "":
		text_Edit.placeholder_text = "Llena este campo !!"
		pass

func reset_text_edit():
	text_Edit.editable = false
	text_Edit.text = edited_Text

func disable_Buttons():
	save.disabled = true
	cancel.disabled = true
	option_Button.disabled = true
	pass

func enable_Buttons():
	save.disabled = false
	cancel.disabled = false
	option_Button.disabled = false

func set_Nombre(nombre: String):
	text_Edit.text = nombre
