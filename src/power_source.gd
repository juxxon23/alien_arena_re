extends Area2D


func _on_ps_timer_timeout() -> void:
	set_visible(true)
	
	
func _on_body_entered(body: Node2D) -> void:
	get_tree().call_group("score", "add_score", body.name, 400)
