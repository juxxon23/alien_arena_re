extends CharacterBody2D
## This class defines the behavior of the opponent/player named "Zespar".

var speed : int = 400
var direction : Vector2
var quadrant : String = "l"
var can_move : bool = true
var body_left_area : bool = false


func on_left_area(body_entered: Variant, opt: bool) -> void:
	if body_entered is Thor:
		body_left_area = opt
	elif body_entered is Drone:
		pass
	elif body_entered is Qtpi:
		pass
	elif body_entered is Spazzhatazz:
		pass
	else:
		body_left_area = false
		


func player_move(body_name: String, opt: bool) -> void:
	if body_name == self.name:
		can_move = opt
