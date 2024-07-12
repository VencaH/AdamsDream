extends CharacterBody2D

enum CatState {IDLE, WALKING}

const SPEED = 20.0

@onready var cat_timer = get_node("CatTimer")
@onready var cat_state = CatState.IDLE
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

var direction:Vector2

func _physics_process(delta):
	velocity.x = direction.x * SPEED
	velocity.y = direction.y * SPEED
	pick_new_walk_state()
	update_animation()
	if cat_state == CatState.WALKING:
		move_and_slide()

func update_animation():
	if(velocity != Vector2.ZERO):
		animation_tree.set("parameters/idle/blend_position", velocity)
		animation_tree.set("parameters/walk/blend_position", velocity)
	
func switch_state():
	if cat_state == CatState.IDLE:
		cat_state = CatState.WALKING
		direction = Vector2(randi_range(-1,1),randi_range(-1,1))
	else:
		cat_state = CatState.IDLE
		direction = Vector2(0,0)

func _on_cat_timer_timeout():
	switch_state() # Replace with function body.

func pick_new_walk_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("walk")
	else:
		state_machine.travel("idle")

func _on_cat_barrier_body_entered(body):
	direction= Vector2(0,0)
	switch_state()
	update_animation()
	pick_new_walk_state() # Replace with function body.
