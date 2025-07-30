extends CharacterBody2D

@export var speed = 400 # (pixels/sec)
var current_piece : String
var pieces_count := 0
	
func _physics_process(_delta: float) -> void:
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
	if args[0] == self:
		current_piece = args[1]
		pieces_count += 1
	print("current: ", current_piece, " count: ", pieces_count)
	
