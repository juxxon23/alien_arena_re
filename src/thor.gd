class_name Thor
extends CharacterBody2D
## This class defines the behavior of the player named "Thor".
## It handles movement, collecting pieces, building actions,
## flushing collected pieces, and placing objects on the board.

@export var speed = 400 # (pixels/sec)

var current_color : String
var pieces_count : int = 0
var quadrant : String = "r"
var must_build : bool
var can_move : bool = true


func _process(_delta: float) -> void:
	flush()
	place()


func _physics_process(_delta: float) -> void:
	if not can_move:
		return
		
	velocity = Vector2.ZERO 
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
	if Input.is_action_pressed("ui_down"):
		velocity.y = speed
	if Input.is_action_pressed("ui_up"):
		velocity.y = -speed
		
	if velocity.length() > 0:
		move_and_slide()


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
	
	must_build = false
	if current_color == "#ff3333" and pieces_count == 3:
		must_build = true
	elif pieces_count == 4:
		must_build = true
		
	if must_build:
		get_tree().call_group("builders", "build", self.name, pieces_count)
		pieces_count = 0
		current_color = ""
		
		
func flush() -> void:
	if must_build:
		return
	
	if Input.is_action_just_pressed("flush"):
		pieces_count = 0
		current_color = ""
		get_tree().call_group("builders", "flush_pieces", self.name)
		

func place() -> void:
	if Input.is_action_just_pressed("place"):
		get_tree().call_group("builders", "place_object", self.name)
		

func player_move(body_name: String, opt: bool) -> void:
	if body_name == self.name:
		can_move = opt
