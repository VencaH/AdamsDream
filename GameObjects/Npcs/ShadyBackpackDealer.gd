extends Npc
const Npc = preload("res://GameObjects/Npcs/Npc.gd")

signal backpack_stolen()

func _on_body_entered(body):
	if body.name == "MainCharacter":
		dialog.set_dialog_data(dialog_file)
		dialog.connect("dialog_closed", _on_dialog_closed)
		dialog.initialize_dialog()

func _on_dialog_closed(answers):
	dialog.disconnect("dialog_closed", _on_dialog_closed)
	if answers[-1] == -2:
		backpack_stolen.emit()

func _on_bessie_hidden_timer_timeout():
	dialog_file = "res://Dialogs/ShadyDealer/ShadyDealerCat.json"
