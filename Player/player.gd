extends CharacterBody2D

@export var acceleration = 512
@export var max_speed = 64
@export var friction = 256
@export var gravity = 200
@export var jump_force = 128
@export var max_fall_speed = 80


func _physics_process(delta):
	if not is_on_floor():
		velocity.y = move_toward(velocity.y, max_fall_speed, gravity * delta)
	
	var input_axis = Input.get_axis("ui_left", "ui_right")
	
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, input_axis * max_speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x,  0, friction * delta)
	
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = -jump_force
		
	move_and_slide()
