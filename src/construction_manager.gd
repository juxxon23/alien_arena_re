extends Node
## ConstructionManager is responsible for managing the collection, placement, 
## and instantiation of buildable objects in the game.


var piece_colors := ["#6699ff","#ff6699", "#99ff66", "#3333ff", "#ff3333"]
var current_color := ["",""] # [left_q, right_q]
var can_place := [false, false] # [Zespar, Thor]

@onready var piece_scn = preload("res://scenes/piece.tscn")
@onready var mine_scn = preload("res://scenes/mine.tscn")
@onready var trap_scn = preload("res://scenes/trap.tscn")
@onready var drone_scn = preload("res://scenes/drone.tscn")
@onready var qtpi_scn = preload("res://scenes/qtpi.tscn")
@onready var spazzhatazz_scn = preload("res://scenes/spazzhatazz.tscn")


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
	
	set_can_place(body_name, false)
	

func build(body_name: String, pieces_count: int) -> void:
	var object : Variant
	if pieces_count == 3:
		object = player_object(body_name)
	elif pieces_count == 4:
		object = player_object(body_name)

	get_tree().current_scene.get_node("Match").get_node(body_name).call_deferred(
			"add_child", object)
	flush_pieces(body_name, true)
	set_can_place(body_name, true)


func place_object(body_name: String) -> void:
	var player = get_tree().current_scene.get_node("Match").get_node(body_name)
	if not get_can_place(body_name):
		return
	
	var obj := player.get_child(-1)
	if not obj:
		return 
	
	obj.reparent(self)
	flush_pieces(body_name)


func player_object(body_name: String) -> Variant:
	var config = get_config_player(body_name)
	if not config:
		return
		
	var opponent = get_tree().current_scene.get_node("Match").get_node(config.opponent_name)
	var color = current_color[config.index]
	var dir = config.flip
	var obj = create_object_from_color(color, opponent, dir)
	if not obj:
		return
		
	obj.set_coll_layer(config.coll_layer)
	obj.set_coll_mask(config.coll_mask)
	obj.set_player_owner(body_name)
	return obj
	
	
func get_config_player(body_name: String) -> Dictionary:
	var index : int
	var opponent_name : String
	var coll_layer : Array
	var coll_mask : Array
	match body_name:
		"Zespar":
			return {
				index = 0,
				opponent_name = "Thor",
				coll_layer = [7],
				coll_mask = [1, 3, 6, 8],
				flip = true
			}
		"Thor":
			return { 
				index = 1,
				opponent_name = "Zespar",
				coll_layer = [6],
				coll_mask = [2, 4, 7, 8],
				flip = false
			}
		_:
			return {}
	

func create_object_from_color(color: String, opponent: Node, dir: int) -> Variant:
	match color:
		"#ff3333": return mine_scn.instantiate()
		"#3333ff": return trap_scn.instantiate()
		"#6699ff": 
			var obj = drone_scn.instantiate()
			obj.set_direction(dir)
			return obj
		"#99ff66": 
			var obj = qtpi_scn.instantiate()
			obj.set_player_opponent(opponent)
			return obj
		"#ff6699": 
			var obj = spazzhatazz_scn.instantiate()
			obj.set_player_opponent(opponent)
			return obj
		_: return
	
	
func set_can_place(body_name: String, opt: bool) -> void:
	match body_name:
		"Zespar": can_place[0] = opt
		"Thor" : can_place[1] = opt
		_: return


func get_can_place(body_name: String) -> bool:
	match body_name:
		"Zespar": return can_place[0]
		"Thor" : return can_place[1]
		_: return false


func group_collision(group: String, quadrant: int) -> void:
	get_tree().call_group(group, "disable_collision_by_color", 
			current_color[quadrant])	


func random_position_in_right_quadrant() -> Vector2:
	return Vector2(randi_range(656, 1096),randi_range(104, 624))	
