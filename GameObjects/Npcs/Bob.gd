extends Npc

const Npc = preload("res://GameObjects/Npcs/Npc.gd")

signal bob_joins_party()

func _on_bob_body_entered(body):
	if body.name == "MainCharacter":
		dialog.set_dialog_data(dialog_file)
		dialog.connect("dialog_closed", _on_dialog_closed)
		dialog.initialize_dialog()

func _on_dialog_closed(answers):
	if answers[-1] == -2:
		bob_joins_party.emit()
