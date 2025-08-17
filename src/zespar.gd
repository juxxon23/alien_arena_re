extends CharacterBody2D
## This class defines the behavior of the opponent/player named "Zespar".

var speed : int = 400
var direction : Vector2
var quadrant : String = "l"
var can_move : bool = true
var body_left_area : bool = false
var obj_left_area : Variant


func on_left_area(body_entered: Variant, opt: bool) -> void:
	if not opt:
		body_left_area = false
		obj_left_area = null
		return
	
	if (
		body_entered is Thor or body_entered is Drone 
		or body_entered is Qtpi or body_entered is Spazzhatazz
	):
		body_left_area = true
		obj_left_area = body_entered
	else:
		body_left_area = false
		obj_left_area = null
		


func player_move(body_name: String, opt: bool) -> void:
	if body_name == self.name:
		can_move = opt
