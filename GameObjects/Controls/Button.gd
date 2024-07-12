extends TextureButton

signal answered(navigation: int)

@export var navigation: int

func _on_pressed():
	answered.emit(navigation)
