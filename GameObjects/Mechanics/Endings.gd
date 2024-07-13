extends Node2D

@export var dialog: Control

func one():
	dialog.connect("dialog_closed", _on_dialog_closed)
	dialog.set_dialog_data("res://Dialogs/Endings/EndingOne.json")
	dialog.initialize_dialog()

func two():
	dialog.connect("dialog_closed", _on_dialog_closed)
	dialog.set_dialog_data("res://Dialogs/Endings/EndingTwo.json")
	dialog.initialize_dialog()

func three():
	dialog.connect("dialog_closed", _on_dialog_closed)
	dialog.set_dialog_data("res://Dialogs/Endings/EndingThree.json")
	dialog.initialize_dialog()

func four():
	dialog.connect("dialog_closed", _on_dialog_closed)
	dialog.set_dialog_data("res://Dialogs/Endings/EndingOne.json")
	dialog.initialize_dialog()

func _on_dialog_closed(_answers):
	dialog.disconnect("dialog_closed", _on_dialog_closed)
	get_tree().reload_current_scene()

