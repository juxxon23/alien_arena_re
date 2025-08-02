extends Area2D


func change_color(color: String) -> void:
	$ColorRect.color = Color.html(color)

	
func format_color(color: Color) -> String:
	return "#" + color.to_html(false)


func _on_body_entered(body: Node2D) -> void:
	var color_piece = format_color($ColorRect.color)
	get_tree().call_group("builders", "pick_up_pieces", [body, color_piece])


func disable_collision(opt: bool) -> void:
	$CollisionShape2D.set_deferred("disabled", opt)


func disable_collision_by_color(current_color: String) -> void:
	if format_color($ColorRect.color) != current_color:
		disable_collision(true)	
