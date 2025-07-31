extends Area2D


func change_color(color: String) -> void:
	$ColorRect.color = Color.html(color)


func toogle_collision(opt: bool) -> void:
	$CollisionShape2D.set_deferred("disabled", opt)
	

func _on_body_entered(body: Node2D) -> void:
	var color_piece = "#" + $ColorRect.color.to_html(false)
	get_tree().call_group("builders", "pick_up_pieces", [body, color_piece])


# La pieza verificara si su color corresponde al actual, si no lo es entonces
# desactivara su colision.
