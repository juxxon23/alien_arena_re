extends CharacterBody2D

@export var speed = 400 # (pixels/sec)
var current_color : String
var pieces_count := 0
var q = "r" # Quadrant
	

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


func pick_up_pieces(args) -> void: # args[0]: body, args[1]: color_piece
	if args[0] != self:
		return
		
	if current_color == "":
		current_color = args[1]
		get_tree().call_group("builders", "current_qcolor", q, current_color)
	
	pieces_count += 1
	#print("from pick_up: ", current_color, " ", pieces_count)
	var must_build = false
	
	if current_color == "#ff3333" and pieces_count == 3:
		must_build = true
	elif pieces_count == 4:
		must_build = true
		
	if must_build:
		get_tree().call_group("builders", "build", self.name, pieces_count)
		pieces_count = 0
		current_color = ""
		
	
	
	
