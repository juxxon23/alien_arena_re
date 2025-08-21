class_name Thor
extends CharacterBody2D
## This class defines the behavior of the player named "Thor".
## It handles movement, collecting pieces, building actions,
## flushing collected pieces, and placing objects on the board.

const SPEED = 350 # (pixels/sec)

var direction : Vector2
var can_move : bool = true
var current_color : String
var quadrant : String = "r"
var pieces_count : int = 0
var must_build : bool = false
var sprite_frames = [0, 1, 2, 3] # frames en orden: parado, pie1, parado, pie2
var frames_size : int = 4

func _input(_event: InputEvent) -> void:
	flush()
	place()


func flush() -> void:
	if Input.is_action_just_pressed("flush") and not must_build:
		get_tree().call_group("builders", "flush_pieces", self.name)
		current_color = ""
		pieces_count = 0


func place() -> void:
	if Input.is_action_just_pressed("place") and must_build:
		get_tree().call_group("builders", "place_object", self.name)
		must_build = false


func pick_up_pieces(args) -> void:
	## @param args Array containing:
	##        - `args[0]` (Node2D): The body that collided with the piece.
	##        - `args[1]` (String): The color of the piece collected.
	if args[0] != self:
		return
		
	if current_color == "":
		current_color = args[1]
		get_tree().call_group("builders", "current_qcolor", quadrant, 
				current_color)
	
	pieces_count += 1
	check_must_build()
	

func check_must_build() -> void:
	if current_color == "#ff3333" and pieces_count == 3:
		must_build = true
	elif pieces_count == 4:
		must_build = true
		
	if must_build:
		get_tree().call_group("builders", "build", self.name, pieces_count)
		current_color = ""
		pieces_count = 0


func player_move(body_name: String, opt: bool) -> void:
	if body_name == self.name:
		can_move = opt
		

func set_frame(anim: String, frame_index: int) -> int:
	frame_index = (frame_index + 1) % frames_size
	$AnimatedSprite2D.animation = anim
	$AnimatedSprite2D.frame = sprite_frames[frame_index]
	return frame_index
	
