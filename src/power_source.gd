extends Area2D
## Represents the power source object in the game arena.
## It becomes visible after a certain amount of time and awards 400 points to 
## the opponent when touched.


func _on_body_entered(body: Node2D) -> void:
	get_tree().call_group("score", "add_score", body.name, 400)
	get_tree().call_group("matches", "reload_match")


func _on_ps_timer_timeout() -> void:
	set_visible(true)
	$AnimatedSprite2D.play("power_source")
