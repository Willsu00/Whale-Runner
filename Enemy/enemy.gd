extends CharacterBody2D

@export var acceleration = 150
@export var max_speed = 110
@onready var pirate_ghost_placeholder = $PirateGhostPlaceholder

func is_moving(input_axis):
	return input_axis != 0

func _physics_process(delta):
	var player = MainInstance.player
	if player is CharacterBody2D:
		flip_towards_player(player)
		move_toward_position(player.global_position,delta)
			
func move_toward_position(target_position,delta):
	var direction = global_position.direction_to(target_position)
	velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
	move_and_slide()
	
#func update_animations(input_axis):
	#if is_moving(input_axis):
		#$PirateGhostPlaceholder.scale.x = sign(input_axis)

func flip_towards_player(player):
	if player.global_position.x < global_position.x:
		pirate_ghost_placeholder.flip_h = true
	else:
		pirate_ghost_placeholder.flip_h = false
	
