class_name ZesparDestroying
extends StateBase

var thor : Node
var thor_pos : Vector2


func start():
	thor = get_tree().current_scene.get_node("Match").get_child(4) # Thor index in Main scene
	

func on_physics_process(_delta: float) -> void:
	if not controlled_node.can_move:
		return 
		
	if controlled_node.body_left_area:
		if controlled_node.obj_left_area is Thor:
			thor_pos = thor.position
			controlled_node.direction = controlled_node.position.direction_to(thor_pos)
			controlled_node.check_direction()
			controlled_node.velocity = controlled_node.direction * controlled_node.speed
			controlled_node.move_and_slide()
		else:
			state_machine.change_to("ZesparCounterattacking")
