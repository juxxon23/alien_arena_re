extends CharacterBody2D

@export var speed = 400 # Rapidez (pixels/sec)
	
func _physics_process(delta: float) -> void:
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
