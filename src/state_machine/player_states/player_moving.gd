class_name PlayerMoving
extends StateBase


func on_physics_process(_delta: float) -> void:
	movement()


func on_input(event: InputEvent) -> void:
	movement_direction()


func movement_direction() -> void:
	controlled_node.direction.x = Input.get_axis("ui_left", "ui_right")
	controlled_node.direction.y = Input.get_axis("ui_up", "ui_down")
	
	
func movement() -> void:
	if not controlled_node.can_move:
		return
		
	if controlled_node.direction:
		controlled_node.velocity = controlled_node.direction * controlled_node.SPEED
	else:
		controlled_node.velocity = Vector2.ZERO
	
	controlled_node.move_and_slide()
