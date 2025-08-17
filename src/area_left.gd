extends Area2D

var count : int = 0


func _on_body_entered(body: Node2D) -> void:
	count += 1
	if count == 1:
		get_tree().call_group("builders", "on_left_area", body, true)


func _on_body_exited(body: Node2D) -> void:
	count = 0
	get_tree().call_group("builders", "on_left_area", body, false)
