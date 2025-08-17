class_name ZesparAttacking
extends StateBase

var current_color := ["#6699ff", "#99ff66", "#ff6699"]
var builded_obj : bool = false
var placed_obj : bool = false


func start():
	get_tree().call_group("builders", "current_qcolor", 
			controlled_node.quadrant, current_color.pick_random())
	get_tree().call_group("builders", "build", controlled_node.name, 4)
	builded_obj = true
	
	
	
func on_physics_process(delta: float) -> void:
	if placed_obj:
		state_machine.change_to("ZesparDestroying")
	
	if builded_obj:
		get_tree().call_group("builders", "place_object", controlled_node.name)
		placed_obj = true
		
	
		
