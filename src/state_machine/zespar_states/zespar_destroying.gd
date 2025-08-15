class_name ZesparDestroying
extends StateBase

var thor : Node
var thor_pos : Vector2


func start():
	thor = get_tree().current_scene.get_child(4) # Thor index in Main scene
	

func on_physics_process(delta: float) -> void:
	if not controlled_node.can_move:
		return 
	
	thor_pos = thor.position
	if controlled_node.body_left_area:
		controlled_node.direction = controlled_node.position.direction_to(thor_pos)
		controlled_node.velocity = controlled_node.direction * controlled_node.speed
		controlled_node.move_and_slide()
	
