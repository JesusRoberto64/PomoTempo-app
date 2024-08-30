extends VBoxContainer

@onready var text_Edit = $HBoxContainer/TextEdit
@onready var option_Button = $HBoxContainer/OptionButton
@onready var cancel = $HBoxContainer/cancel
@onready var save = $HBoxContainer/save
@onready var error_Lab = $error

signal send_Request(update, mode, id)
@export var client: Node

var edited_Text :String= ""
var id: int

func _ready():
	#Check node(control_test.tscn), when that father node instantiate
	#this node(text_display.tscn) reference his father in the var client, 
	#and then connect to its signal to a fuction with the same name (send_Request())
	if client != null and client.has_method("send_Request"):
		send_Request.connect(client.send_Request)
	else:
		client = null
	
	edited_Text = text_Edit.text
	option_Button.item_selected.connect(_on_item_selected)
	cancel.pressed.connect(_on_cancel_pressed)
	save.pressed.connect(_on_save_pressed)

func _on_item_selected(index: int): #This was connected on _ready
	#This fuction manage the UI interacion
	match index:
		0:# Edit Text
			text_Edit.editable = true
			cancel.visible = true
			save.visible = true
			save.text = "Save"
			save.modulate = Color(1,1,1,1)
			edited_Text = text_Edit.text
			option_Button.hide()
		1: #Remove
			cancel.visible = true
			save.visible = true
			save.text = "ERASE"
			save.modulate = Color(1,0,0,1)
			edited_Text = text_Edit.text
			option_Button.hide()
		2: #Hide
			_on_cancel_pressed()
			option_Button.hide()

func _on_cancel_pressed(): #This was connected on _ready
	reset_text_edit()
	save.hide()
	cancel.hide()
	error_Lab.hide()
	option_Button.selected = -1

func _on_save_pressed(): #This was connected on _ready
	#on EDIT button
	if option_Button.selected == 0 and text_Edit.text != "":
		text_Edit.editable = false
		disable_Buttons()
		
		if client == null:
			enable_Buttons()
			error_Lab.show()
			error_Lab.text = "No cliente"
			text_Edit.editable = true
			return
		
		if text_Edit.text == edited_Text:
			enable_Buttons()
			error_Lab.show()
			text_Edit.editable = true
			return
		
		send_Request.emit(text_Edit.text, "UPDATE", id)
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
		enable_Buttons()
	
	# on REMOVE BUTTON selected
	if option_Button.selected == 1:
		disable_Buttons()
		
		#Logic
		if client == null:
			enable_Buttons()
			error_Lab.show()
			error_Lab.text = "No cliente"
			return
		
		send_Request.emit(text_Edit.text, "DELETE", id)
		await client.error_Return
		
		if client.error != null:
			enable_Buttons()
			error_Lab.show()
			error_Lab.text = "Error: " + client.error
			return
		
		queue_free()

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
	edited_Text = nombre

func _on_text_edit_mouse_entered(): #This was connected on Godot Editor
	#return
	var btns = get_tree().get_nodes_in_group("textDisplay")
	for i in btns:
		if i.save.visible == true:
			return
	option_Button.show()
	for i in btns:
		if i == self:
			continue
		_on_cancel_pressed()
		i.option_Button.hide()
