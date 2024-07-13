extends Npc

const Npc = preload("res://GameObjects/Npcs/Npc.gd")

signal bessie_returned()
@onready var quest_state:QuestState = QuestState.NOT_INITIALIZED

var bessie_returns = false

func _on_body_entered(body):
	if body.name == "MainCharacter":
		dialog.set_dialog_data(dialog_file)
		dialog.initialize_dialog()
		if bessie_returns:
			bessie_returns = false
			dialog_file = "res://Dialogs/Amelia/AmeliaBessieHome.json"
			get_node("../Bessie").queue_free()
			bessie_returned.emit()

func _on_bessie_bessie_follow():
	dialog_file = "res://Dialogs/Amelia/AmeliaBessieFound.json"
	bessie_returns = true

func _on_bessie_hidden_timer_timeout():
	dialog_file = "res://Dialogs/Amelia/AmeliaBessieCompanion.json"
	bessie_returns = false
