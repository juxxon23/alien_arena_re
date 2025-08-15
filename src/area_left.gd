extends Area2D


func _on_body_entered(body: Node2D) -> void:
	get_tree().call_group("builders", "on_left_area", body, true)


func _on_body_exited(body: Node2D) -> void:
	get_tree().call_group("builders", "on_left_area", body, false)
