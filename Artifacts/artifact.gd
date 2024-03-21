extends Area2D

func _on_body_entered(body):
	queue_free()
	var artifact = get_tree().get_nodes_in_group("Artifact")
	if artifact.size() == 1:
		Events.claimed_all_artifacts.emit()
