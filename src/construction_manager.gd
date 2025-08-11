extends Node
## ConstructionManager is responsible for managing the collection, placement, 
## and instantiation of buildable objects in the game.


var piece_colors := ["#6699ff","#ff6699", "#99ff66", "#3333ff", "#ff3333"]
var current_color := ["",""] # [left_q, right_q]
var can_place : bool = false

@onready var piece_scn = preload("res://scenes/piece.tscn")
@onready var mine_scn = preload("res://scenes/mine.tscn")
@onready var trap_scn = preload("res://scenes/trap.tscn")
@onready var drone_scn = preload("res://scenes/drone.tscn")
@onready var qtpi_scn = preload("res://scenes/qtpi.tscn")
@onready var spazzhatazz_scn = preload("res://scenes/spazzhatazz.tscn")


func _ready() -> void:
	set_initial_pieces()
	

func set_initial_pieces() -> void:
	for i in 16:
		var piece = piece_scn.instantiate()
		piece.change_color(piece_colors.pick_random())
		# avoid overlapping (todo)
		piece.position = random_position_in_right_quadrant()
		piece.add_to_group("right")
		add_child(piece)
	

func current_qcolor(quadrant: String, color: String) -> void: 
	if quadrant == "l":
		current_color[0] = color
		group_collision("left", 0)
	elif quadrant == "r":
		current_color[1] = color
		group_collision("right", 1)
	else:
		return
	

func flush_pieces(body_name: String, dis_coll: bool = false) -> void:
	if body_name == "Zespar":
		current_color[0] = ""
		get_tree().call_group("left", "disable_collision", dis_coll)
	elif body_name == "Thor":
		current_color[1] = ""
		get_tree().call_group("right", "disable_collision", dis_coll)
	
	can_place = false
	

func build(body_name: String, pieces_count: int) -> void:
	var object : Variant
	if pieces_count == 3:
		object = player_object(body_name)
	elif pieces_count == 4:
		object = player_object(body_name)

	get_tree().current_scene.get_node(body_name).call_deferred("add_child",
			 object)
	flush_pieces(body_name, true)
	can_place = true


func place_object(body_name: String) -> void:
	var player = get_tree().current_scene.get_node(body_name)
	if not can_place:
		return
	
	var obj = player.get_child(-1)
	obj.reparent(self)
	flush_pieces(body_name)


func player_object(body_name: String) -> Variant:
	var obj : Variant
	if body_name == "Zespar":
		var opponent = get_tree().current_scene.get_node("Thor")
		match current_color[0]:
			"#ff3333": obj = mine_scn.instantiate()
			"#3333ff": obj = trap_scn.instantiate()
			"#6699ff": obj = drone_scn.instantiate()
			"#99ff66": 
				obj = qtpi_scn.instantiate()
				obj.set_player_opponent(opponent)
			"#ff6699": 
				obj = spazzhatazz_scn.instantiate()
				obj.set_player_opponent(opponent)
			_: return
		obj.set_coll_layer([7])
		obj.set_coll_mask([1, 3, 6, 8])
		obj.set_player_owner(body_name)
		return obj
	elif body_name == "Thor":
		var opponent = get_tree().current_scene.get_node("Zespar")
		match current_color[1]:
			"#ff3333": obj = mine_scn.instantiate()
			"#3333ff": obj = trap_scn.instantiate()
			"#6699ff": obj = drone_scn.instantiate()
			"#99ff66": 
				obj = qtpi_scn.instantiate()
				obj.set_player_opponent(opponent)
			"#ff6699": 
				obj = spazzhatazz_scn.instantiate()
				obj.set_player_opponent(opponent)
			_: return
		obj.set_coll_layer([6])
		obj.set_coll_mask([2, 4, 7, 8])
		obj.set_player_owner(body_name)
		return obj
	else:
		return	
	

func group_collision(group: String, quadrant: int) -> void:
	get_tree().call_group(group, "disable_collision_by_color", 
			current_color[quadrant])	


func random_position_in_right_quadrant() -> Vector2:
	return Vector2(randi_range(656, 1096),randi_range(104, 624))	
