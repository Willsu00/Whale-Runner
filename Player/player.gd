extends CharacterBody2D

@export var acceleration = 512
@export var max_speed = 100
@export var friction = 256
@export var gravity = 200
@export var jump_force = 150
@export var max_fall_velocity = 200 #128

@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D

func _enter_tree():
	MainInstance.player = self

func _physics_process(delta):
	apply_gravity(delta)
	var input_axis = Input.get_axis("ui_left", "ui_right")
	if is_moving(input_axis):
		apply_acceleration(delta, input_axis)
	else:
		apply_friction(delta)
	jump_check()
	update_animations(input_axis)
	move_and_slide()


func _exit_tree():
	MainInstance.player = null

func is_moving(input_axis):
	return input_axis != 0

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y = move_toward(velocity.y, max_fall_velocity, gravity * delta)

func apply_acceleration(delta, input_axis):
	velocity.x = move_toward(velocity.x, input_axis * max_speed, acceleration * delta)

func apply_friction(delta):
	velocity.x = move_toward(velocity.x,  0, friction * delta)

func jump_check():
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = -jump_force
	else:
		if Input.is_action_just_released("ui_up") and velocity.y < -jump_force / 2:
			velocity.y = -jump_force / 2

func update_animations(input_axis):
	if is_moving(input_axis):
		animation_player.play("run")
		if input_axis > 0:
			sprite_2d.flip_h = false
		elif input_axis < 0:
			sprite_2d.flip_h = true
	else:
		animation_player.play("idle")
	if not is_on_floor():
		animation_player.play("jump")

func death():
	queue_free()
	get_tree().change_scene_to_file("res://World/world.tscn")
