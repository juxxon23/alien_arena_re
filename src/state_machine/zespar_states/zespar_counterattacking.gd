class_name ZesparCounterattacking
extends StateBase

var current_obj : Variant
var current_color := ["#ff3333", "#3333ff"]
var pieces_count := { "#ff3333": 3, "#3333ff": 4 }
var builded_obj : bool = false
var placed_obj : bool = false
var obj_pos : Vector2
var min_dis := Vector2(100.0, 100.0)


func start():
	current_obj = controlled_node.obj_left_area
	var color = current_color.pick_random()
	var pieces = pieces_count[color]
	get_tree().call_group("builders", "current_qcolor", 
			controlled_node.quadrant, color)
	get_tree().call_group("builders", "build", controlled_node.name, pieces)
	builded_obj = true
	placed_obj = false
	

func on_physics_process(_delta: float) -> void:
	if not controlled_node.can_move:
		return
	
	if placed_obj:
		state_machine.change_to("ZesparDefending")
		return
		
	if is_instance_valid(current_obj):
		obj_pos = current_obj.position
		
	if abs(round(obj_pos - controlled_node.position)) < min_dis:
		controlled_node.velocity = Vector2.ZERO
		if builded_obj:
			get_tree().call_group("builders", "place_object", controlled_node.name)
			placed_obj = true
		return
			
	controlled_node.direction = controlled_node.position.direction_to(obj_pos)
	controlled_node.velocity = controlled_node.direction * controlled_node.speed
	controlled_node.move_and_slide()
	
	
