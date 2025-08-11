extends CharacterBody2D

@export var speed = 200 # (pixels/sec)
var player_owner : String
var player_opponent: Variant


func _ready() -> void:
	$AnimatedSprite2D.play("walking")


func _physics_process(delta: float) -> void:
	if player_opponent == null:
		return
	
	if position != Vector2.ZERO:
		var direction = (player_opponent.position - position).normalized()
		
		velocity = direction * speed * delta
		
		var collision = move_and_collide(velocity)
		
		if collision:
			get_tree().call_group("score", "add_score", player_owner, 20)
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
	
	
func set_player_opponent(player: Variant) -> void:
	player_opponent = player
	
