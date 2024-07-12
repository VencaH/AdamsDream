extends Npc

const Npc = preload("res://GameObjects/Npcs/Npc.gd")

signal obtained_weapon(id: int)
@onready var quest_state:QuestState = QuestState.NOT_INITIALIZED

func _on_body_entered(body):
	if body.name == "MainCharacter":
		dialog.connect("dialog_closed", _on_dialog_closed)
		dialog.set_dialog_data(dialog_file)
		dialog.initialize_dialog()

func _on_dialog_closed(answers):
	if answers[-1] == -2 || answers[-1] == -1:
		quest_state = QuestState.DONE
		dialog_file = "res://Dialogs/Soldier/SoldierAfterQuest.json"
		obtained_weapon.emit(abs(answers[-1]))
	dialog.disconnect("dialog_closed", _on_dialog_closed)
