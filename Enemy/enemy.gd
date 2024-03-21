extends CharacterBody2D

@export var acceleration = 150
@export var max_speed = 60

func is_moving(input_axis):
	return input_axis != 0

func _physics_process(delta):
	var player = MainInstance.player
	if player is CharacterBody2D:
		move_toward_position(player.global_position,delta)
			
func move_toward_position(target_position,delta):
	var direction = global_position.direction_to(target_position)
	velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
	move_and_slide()
	
func update_animations(input_axis):
	if is_moving(input_axis):
		$PirateGhostPlaceholder.scale.x = sign(input_axis)
