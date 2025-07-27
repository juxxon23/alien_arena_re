extends StaticBody2D

func change_color(color: String) -> void:
	$ColorRect.color = Color.html(color)
	
func toogle_collision(opt: bool) -> void:
	$CollisionShape2D.set_deferred("disabled", opt)
	
