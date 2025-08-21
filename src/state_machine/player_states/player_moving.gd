class_name PlayerMoving
extends StateBase

var frame_down_index : int = 0
var frame_up_index : int = 0
var frame_right_index : int = 0
var frame_left_index : int = 0


func on_physics_process(_delta: float) -> void:
	movement()


func on_input(_event: InputEvent) -> void:
	movement_direction()


func movement_direction() -> void:
	controlled_node.direction = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		frame_right_index = controlled_node.set_frame("walk_right", frame_right_index)
		controlled_node.direction.x = 1
	if Input.is_action_pressed("ui_left"):
		frame_left_index = controlled_node.set_frame("walk_left", frame_left_index)
		controlled_node.direction.x = -1
	if Input.is_action_pressed("ui_down"):
		frame_down_index = controlled_node.set_frame("walk_down", frame_down_index)
		controlled_node.direction.y = 1
	if Input.is_action_pressed("ui_up"):
		frame_up_index = controlled_node.set_frame("walk_up", frame_up_index)
		controlled_node.direction.y = -1
	
	
func movement() -> void:
	if not controlled_node.can_move:
		return
		
	if controlled_node.direction:
		controlled_node.velocity = controlled_node.direction * controlled_node.SPEED
	else:
		controlled_node.velocity = Vector2.ZERO
	
	controlled_node.move_and_slide()
