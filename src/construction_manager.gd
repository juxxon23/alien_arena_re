extends Node

var piece_colors := ["#6699ff","#ff6699", "#99ff66", "#3333ff", "#ff3333"]
# Al colisionar con una pieza se debe guardar el color, desactivar la colision
# de las piezas de otros colores y comenzar el conteo para la construccion del
# objeto. (todo)
var current_piece : String
var pieces_count := 0

@onready var piece_scene = preload("res://scenes/piece.tscn")


func _ready() -> void:
	set_initial_pieces()
	
	
func set_initial_pieces() -> void:
	for i in 16:
		var piece = piece_scene.instantiate()
		piece.change_color(piece_colors.pick_random())
		piece.toogle_collision(true)
		# avoid overlapping (todo)
		piece.position = random_position_in_right_quadrant()
		add_child(piece)
		
		
func random_position_in_right_quadrant() -> Vector2:
	return Vector2(randi_range(656, 1096),randi_range(104, 624))
	
