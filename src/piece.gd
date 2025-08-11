extends Area2D
## Represents a colored piece used to build various objects in the game.
## When a player collides with it, the piece is collected and removed from 
## the scene.


func _on_body_entered(body: Node2D) -> void:
	var color_piece = format_color($ColorRect.color)
	get_tree().call_group("builders", "pick_up_pieces", [body, color_piece])
	queue_free()


func change_color(color: String) -> void:
	$ColorRect.color = Color.html(color)


func disable_collision(opt: bool) -> void:
	$CollisionShape2D.set_deferred("disabled", opt)
	

func disable_collision_by_color(current_color: String) -> void:
	if format_color($ColorRect.color) != current_color:
		disable_collision(true)	


func format_color(color: Color) -> String:
	return "#" + color.to_html(false)
