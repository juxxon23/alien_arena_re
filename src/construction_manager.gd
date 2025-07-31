extends Node

var piece_colors := ["#6699ff","#ff6699", "#99ff66", "#3333ff", "#ff3333"]
var current_color := ["",""] # [left, right]

@onready var piece_scene = preload("res://scenes/piece.tscn")


func _ready() -> void:
	set_initial_pieces()
	
	
# Para multiplayer se crearan dos grupos "r"/"l" de acuerdo a su cuadrante y se
# agregaran las instancias de las piezas a dichos grupos
func set_initial_pieces() -> void:
	for i in 16:
		var piece = piece_scene.instantiate()
		# Agregar a grupo right o left
		piece.change_color(piece_colors.pick_random())
		# avoid overlapping (todo)
		piece.position = random_position_in_right_quadrant()
		add_child(piece)
		

func random_position_in_right_quadrant() -> Vector2:
	return Vector2(randi_range(656, 1096),randi_range(104, 624))
	

func current_qcolor(arg1, arg2) -> void: # arg1: quadrant, arg2: current_color
	# Segun cuadrante enviar senal al grupo del color actual
	if arg1 == "l":
		current_color[0] = arg2
	elif arg1 == "r":
		current_color[1] = arg2
	else:
		return
	
	
func build(arg1) -> void: # arg1: pieces_count
	print("from build: ", arg1)
