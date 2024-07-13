extends Node2D

enum BessieQuest {NOT_STARTED, FOLLOWING, DONE, COMPANION}
enum WeaponQuest {NOT_STARTED, DAGGER, SWORD}
enum BackpackQuest {NOT_STARTED, MAGICAL, ORDINARY}
enum Companion {NONE, BESSIE, BOB}

@onready var main_character = get_node("MainCharacter")
@onready var dialog = get_node("Dialog")
@onready var ending = get_node("Endings")
@onready var quest_log = get_node("QuestLog")

var weapon_quest = WeaponQuest.NOT_STARTED
var bessie_quest = BessieQuest.NOT_STARTED
var backpack_quest = BackpackQuest.NOT_STARTED
var companion = Companion.NONE

# Called when the node enters the scene tree for the first time.
func _ready():
	dialog.set_dialog_data("res://Dialogs/Intro/Intro.json")
	dialog.initialize_dialog()

func _on_dialog_dialog_closed(_answers: Array):
	main_character.state = 0

func _on_dialog_dialog_open():
	main_character.state = 1

func _on_soldier_obtained_weapon(id):
	quest_log.add_weapon()
	match id:
		1:
			weapon_quest = WeaponQuest.DAGGER
		2:
			weapon_quest = WeaponQuest.SWORD
	if backpack_quest != BackpackQuest.NOT_STARTED:
		get_node("Bob").dialog_file = "res://Dialogs/Bob/BobCompanion.json"
		check_end()

func _on_bessie_bessie_follow():
	bessie_quest = BessieQuest.FOLLOWING

func _on_bessie_hidden_timer_timeout():
	bessie_quest = BessieQuest.COMPANION
	companion = Companion.BESSIE
	quest_log.add_companion()

func _on_amelia_bessie_returned():
	bessie_quest = BessieQuest.DONE
	backpack_quest = BackpackQuest.MAGICAL
	quest_log.add_backpack()
	if weapon_quest != WeaponQuest.NOT_STARTED:
		get_node("Bob").dialog_file = "res://Dialogs/Bob/BobCompanion.json"

func _on_shady_backpack_dealer_backpack_stolen():
	backpack_quest = BackpackQuest.ORDINARY
	quest_log.add_backpack()
	check_end()

func check_end():
	match [weapon_quest, backpack_quest, companion]:
		[WeaponQuest.SWORD, BackpackQuest.MAGICAL, Companion.BOB]:
			ending.one()
		[WeaponQuest.DAGGER, BackpackQuest.ORDINARY, Companion.BESSIE]:
			ending.two()
		[WeaponQuest.SWORD, BackpackQuest.ORDINARY, Companion.BESSIE]:
			ending.three()
		[WeaponQuest.DAGGER, BackpackQuest.MAGICAL, Companion.BOB]:
			ending.four()

func _on_bob_bob_joins_party():
	companion = Companion.BOB
	quest_log.add_companion()
	check_end()
