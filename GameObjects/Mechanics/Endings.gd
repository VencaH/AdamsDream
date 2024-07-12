extends Node2D

@export var dialog: Control

func one():
	dialog.connect("dialog_closed", _on_dialog_closed)
	dialog.set_dialog_data("res://Dialogs/Endings/EndingOne.json")
	dialog.initialize_dialog()

func two():
	pass
	#dialog.connect("dialog_closed", _on_dialog_closed)
	#dialog.set_dialog_data("res://Dialogs/Endings/EndingTwo.json")
	#dialog.initialize_dialog()

func three():
	pass

func _on_dialog_closed(answers):
	dialog.disconnect("dialog_closed", _on_dialog_closed)
	get_tree().reload_current_scene()
