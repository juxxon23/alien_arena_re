extends CharacterBody2D
## This class defines the behavior of the opponent/player named "Zespar".

var speed : int = 400
var direction : Vector2
var quadrant : String = "l"
var can_move : bool = true
var body_left_area : bool = false
var obj_left_area : Variant
var sprite_frames = [0, 1, 2, 3]
var frames_size : int = 4
var frame_down_index : int = 0
var frame_up_index : int = 0
var frame_right_index : int = 0
var frame_left_index : int = 0


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


func set_frame(anim: String, frame_index: int) -> int:
	frame_index = (frame_index + 1) % frames_size
	$AnimatedSprite2D.animation = anim
	$AnimatedSprite2D.frame = sprite_frames[frame_index]
	return frame_index
	
func check_direction() -> void:
	if direction.x > 0:
		frame_right_index = set_frame("walk_right", frame_right_index)
	if direction.x < 0:
		frame_left_index = set_frame("walk_left", frame_left_index)
	if direction.y > 0:
		frame_down_index = set_frame("walk_down", frame_down_index)
	if direction.y < 0:
		frame_up_index = set_frame("walk_up", frame_up_index)
