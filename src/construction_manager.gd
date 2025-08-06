extends Node

var piece_colors := ["#6699ff","#ff6699", "#99ff66", "#3333ff", "#ff3333"]
var current_color := ["",""] # [left_q, right_q]
var can_place : bool = false

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


func current_qcolor(quadrant: String, color: String) -> void: 
	if quadrant == "l":
		current_color[0] = color
		group_collision("left", 0)
	elif quadrant == "r":
		current_color[1] = color
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
	
	
func build(body_name: String, pieces_count: int) -> void:
	var object = object_scene.instantiate()
	
	if pieces_count == 3:
		player_object(body_name, object)
	elif pieces_count == 4:
		player_object(body_name, object)
	
	get_tree().current_scene.get_node(body_name).call_deferred("add_child", object)
	
	can_place = true
	

func flush_pieces(body_name: String) -> void:
	if body_name == "Zespar":
		current_color[0] = ""
		get_tree().call_group("left", "disable_collision", false)
	elif body_name == "Thor":
		current_color[1] = ""
		get_tree().call_group("right", "disable_collision", false)
	
	can_place = false


func place_object(body_name: String) -> void:
	var player = get_tree().current_scene.get_node(body_name)
	
	if not can_place:
		return
	
	var obj = player.get_node("Object")
	
	obj.reparent(self)
	
	flush_pieces(body_name)
	
	
