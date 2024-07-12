extends CharacterBody2D

# parameters/idle/blend_position
enum PlayerState {READY, DIALOG}

const SPEED = 150.0
const JUMP_VELOCITY = -400.0
const STARTING_DIRECTION : Vector2 = Vector2(0,0.5)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@export var state : PlayerState = PlayerState.READY

func _ready():
	animation_tree.set("parameters/idle/blend_position", STARTING_DIRECTION)

func _physics_process(delta):
	if state != PlayerState.READY:
		return
	var direction_y = Input.get_axis("ui_up", "ui_down")
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	update_animation(velocity)
	move_and_slide()
	pick_new_walk_state()

func update_animation(move_direction: Vector2):
	if(move_direction != Vector2.ZERO):
		animation_tree.set("parameters/idle/blend_position", move_direction)
		animation_tree.set("parameters/walk/blend_position", move_direction)

func pick_new_walk_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("walk")
	else:
		state_machine.travel("idle")
