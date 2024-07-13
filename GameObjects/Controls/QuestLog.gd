extends Control

@onready var weapon = get_node("CanvasLayer/Weapon")
@onready var backpack = get_node("CanvasLayer/Backpack")
@onready var companion = get_node("CanvasLayer/Companion")

func add_weapon():
	weapon.visible = true

func add_backpack():
	backpack.visible = true

func add_companion():
	companion.visible = true
