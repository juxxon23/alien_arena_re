extends Node

var piece_colors := ["#6699ff","#ff6699", "#99ff66", "#3333ff", "#ff3333"]
var current_color := ["",""] # [left_q, right_q]

@onready var piece_scene = preload("res://scenes/piece.tscn")
@onready var object_scene = preload("res://scenes/object.tscn")


func _ready() -> void:
	set_initial_pieces()
	
	
func random_position_in_right_quadrant() -> Vector2:
	return Vector2(randi_range(656, 1096),randi_range(104, 624))	

	
func set_initial_pieces() -> void:
	for i in 16:
		var piece = piece_scene.instantiate()
		piece.change_color(piece_colors.pick_random())
		# avoid overlapping (todo)
		piece.position = random_position_in_right_quadrant()
		piece.add_to_group("right")
		add_child(piece)
	

func group_collision(group: String, q: int) -> void:
	get_tree().call_group(group, "disable_collision_by_color", current_color[q])


func current_qcolor(arg1: String, arg2: String) -> void: # arg1: quadrant, arg2: current_color
	if arg1 == "l":
		current_color[0] = arg2
		group_collision("left", 0)
	elif arg1 == "r":
		current_color[1] = arg2
		group_collision("right", 1)
	else:
		return
	

func player_object(body_name: String, obj: Variant) -> void:
	if body_name == "Zespar":
		obj.set_object(current_color[0])
	elif body_name == "Thor":
		obj.set_object(current_color[1])
	else:
		return
	
	
func build(arg1: String, arg2: int) -> void: # arg1: body.name, arg2: pieces_count
	var object = object_scene.instantiate()
	if arg2 == 3:
		player_object(arg1, object)
	elif arg2 == 4:
		player_object(arg1, object)
	get_tree().current_scene.get_node(arg1).call_deferred("add_child", object)
