extends Timer

func _on_bessie_bessie_follow():
	start()

func _on_timeout():
	stop()
	var dialog = get_node("../Dialog")
	dialog.set_dialog_data("res://Dialogs/Misc/BessieJoinsGroup.json")
	dialog.initialize_dialog()
