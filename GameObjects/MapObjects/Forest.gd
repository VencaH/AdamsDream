extends StaticBody2D

@export_file("*.json") var dialog_file: String
@export var dialog: Control

func _on_forest_warning_body_entered(body):
	if body.name == "MainCharacter":
		dialog.set_dialog_data(dialog_file)
		dialog.initialize_dialog()
