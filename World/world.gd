extends Node2D


func _ready():
	Events.claimed_all_artifacts.connect(boss_room_unlocked)


func boss_room_unlocked():
	pass
