extends StaticBody2D


func _on_timer_timeout() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
