extends CharacterBody2D

enum state {LOST, FOLLOW}

signal bessie_follow

@onready var main_character = get_node("../MainCharacter")
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@export var dialog: Control
@export_file("*.json") var dialog_file

const SPEED = 150.0
const JUMP_VELOCITY = -400.0

var cat_state = state.LOST

func _physics_process(_delta):
	var direction = get_direction()
	if cat_state == state.FOLLOW:
		velocity = direction * SPEED
		move_and_slide()
		pick_new_walk_state()
		update_animation()

func get_direction():
	var distance = main_character.position - position
	if abs(distance.x) + abs(distance.y) < 50:
		return Vector2(0,0)
	var x = 0
	var y = 0
	match distance.x:
		var a when a > 10 :
			x = 1
		var a when a < - 10:
			x = -1
		_:
			x = 0

	match distance.y:
		var a when a > 10 :
			y = 1
		var a when a < - 10:
			y = -1
		_:
			y = 0
			
	return Vector2(x,y)
	
func pick_new_walk_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("walk")
	else:
		state_machine.travel("idle")

func update_animation():
			animation_tree.set("parameters/idle/blend_position", velocity)
			animation_tree.set("parameters/walk/blend_position", velocity)
			
func start_following():
	bessie_follow.emit()
	cat_state = state.FOLLOW

func _on_body_entered(body):
	if body.name == "MainCharacter" && cat_state == state.LOST:
		dialog.set_dialog_data(dialog_file)
		dialog.initialize_dialog()
		start_following()
