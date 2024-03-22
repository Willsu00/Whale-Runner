extends Node2D


func _ready():
	Events.claimed_all_artifacts.connect(boss_room_unlocked)


func boss_room_unlocked():
	pass


func _on_tempdoor_body_entered(body):
	get_tree().change_scene_to_file("res://World/WillMap1.tscn")
