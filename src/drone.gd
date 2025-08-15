extends CharacterBody2D
## Represents a moving constructable drone that travels horizontally until it 
## collides with a wall. Upon collision, it awards 50 points to its owner.

@export var speed = 100 # (pixels/sec)

var player_owner : String


func _ready() -> void:
	$AnimatedSprite2D.play("walking")

	
func _physics_process(_delta: float) -> void:
	if position != Vector2.ZERO:
		velocity = Vector2.ZERO
		if $AnimatedSprite2D.flip_h:
			velocity.x += speed
		else:
			velocity.x -= speed
	
	move_and_slide()
	
	if is_on_wall():
		get_tree().call_group("score", "add_score", player_owner, 50)
		queue_free()
		

func set_coll_layer(layers: Array) -> void:
	var layer_sum : int = 0
	for layer in layers:
		layer_sum += int(pow(2, layer-1))
	
	set_collision_layer(layer_sum)
	
	
func set_coll_mask(masks: Array) -> void:
	var mask_sum : int = 0
	for mask in masks:
		mask_sum += int(pow(2, mask-1))
	
	set_collision_mask(mask_sum)	
	

func set_player_owner(body_name: String) -> void:
	player_owner = body_name


func set_direction(dir: bool) -> void:
	$AnimatedSprite2D.flip_h = dir
		
	
