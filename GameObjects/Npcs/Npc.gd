extends Area2D

enum QuestState {NOT_INITIALIZED,IN_PROGRESS, DONE}

@export_file("*.json") var dialog_file: String
@export var dialog: Control
