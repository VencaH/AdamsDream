extends Control

signal dialog_closed(answers: Array)
signal dialog_open()

@onready var progress = 0
@onready var layer = get_node("CanvasLayer")
@onready var text = get_node("CanvasLayer/Panel/MainText")
@onready var right_button = get_node("CanvasLayer/RightButton")
@onready var middle_button = get_node("CanvasLayer/MiddleButton")
@onready var left_button = get_node("CanvasLayer/LeftButton")
@onready var dialog_data = []
@onready var answers = []

func set_dialog_data(dialog_file: String):
	var file = FileAccess.open(dialog_file, FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	var json = JSON.new()
	var error = json.parse(content)
	if error == OK:
		dialog_data = json.data
	else:
		print("Error while parsing file {file}")

func initialize_dialog():
	progress = 0
	answers = []
	layer.visible = true
	update_dialog()
	dialog_open.emit()

func update_dialog():
	var text_line = dialog_data[progress]
	var text_value = text_line["text"]
	text.clear()
	text.append_text(text_value)
	update_button_if_exists(right_button, "right_button")
	update_button_if_exists(middle_button,"middle_button")
	update_button_if_exists(left_button,"left_button")

func update_button_if_exists(button:TextureButton, key:String):
	if dialog_data[progress].has(key):
		button.get_child(0).clear() 
		button.get_child(0).append_text(dialog_data[progress][key]["text"])
		button.navigation = dialog_data[progress][key]["navigation"]
		button.visible = true
	else:
		button.visible = false

func close_dialog():
	layer.visible = false
	dialog_closed.emit(answers)

func _on_button_answered(navigation):
	answers.append(navigation)
	if navigation < 0:
		close_dialog()
	else:
		progress = navigation
		update_dialog()
