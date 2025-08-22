class_name Qtpi
extends CharacterBody2D
## This buildable object chases the opposing player and collides with it, when 
## a collision with the opponent occurs, it awards 20 points to its owner.

@export var speed = 200 # (pixels/sec)

var player_owner : String
var player_opponent: Variant
var can_move : bool = true
var direction : Vector2


func _ready() -> void:
	$AnimatedSprite2D.play("idle")


func _physics_process(delta: float) -> void:
	if not can_move:
		$AnimatedSprite2D.play("idle")
		return
	
	if player_opponent == null:
		return
	
	if position != Vector2.ZERO:
		$AnimatedSprite2D.play("walking")
		direction = position.direction_to(player_opponent.position)
		check_direction()
		velocity = direction * speed
		
		var collision = move_and_collide(velocity * delta)
		if collision:
			get_tree().call_group("score", "add_score", player_owner, 20)
			queue_free()
	

func exploded_obj(body_obj: Variant) -> void:
	if body_obj == self:
		queue_free()


func obj_move(body_name: String, opt: bool) -> void:
	if body_name == self.name:
		can_move = opt


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


func check_direction() -> void:
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
		
