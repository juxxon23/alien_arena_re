class_name ZesparDefending
extends StateBase

var zps : Node
var zps_pos : Vector2
var current_color : String = "#ff3333"
var min_dis := Vector2(5.0, 5.0)
var builded_obj : bool = false
var placed_obj : bool = false


func start():
	zps = get_tree().current_scene.get_node("Match").get_child(2) # ZPS index in Main scene
	zps_pos = zps.position
	get_tree().call_group("builders", "current_qcolor", 
			controlled_node.quadrant, current_color)
	
		
func on_physics_process(_delta: float) -> void:
	if not zps.is_visible_in_tree():
		return
	
	if not builded_obj:
		get_tree().call_group("builders", "build", controlled_node.name, 3)
		builded_obj = true
	
	if abs(round(controlled_node.position - zps_pos)) < min_dis:
		controlled_node.velocity = Vector2.ZERO
		if not placed_obj:
			get_tree().call_group("builders", "place_object", controlled_node.name)
			placed_obj = true
			return
			
		if not is_instance_valid(controlled_node.obj_left_area):
			state_machine.change_to("ZesparAttacking")
		return
	
	if controlled_node.can_move:
		controlled_node.direction = controlled_node.position.direction_to(zps_pos)
		controlled_node.velocity = controlled_node.direction * controlled_node.speed
		controlled_node.move_and_slide()
