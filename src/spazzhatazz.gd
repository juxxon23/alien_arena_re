class_name Spazzhatazz
extends CharacterBody2D
## This buildable object moves in a zigzag pattern until it is close enough to 
## the opponent to collide with it. When a collision with the opponent occurs, 
## it awards 20 points to its owner.

@export var speed = 200 # (pixels/sec)
@export var zigzag_amplitude : float = 400.0
@export var zigzag_frequency : float = 5.0 # Oscilacion

var time_passed : float = 0.0
var player_owner : String
var player_opponent : Variant
var can_move : bool = true


func _ready() -> void:
	$AnimatedSprite2D.play("moving")


func _physics_process(delta: float) -> void:
	if not can_move:
		return
	
	if player_opponent == null:
		return
	
	time_passed += delta
	
	if position != Vector2.ZERO:
		# Direccion hacia el jugador
		var direction = (player_opponent.position - position).normalized()
		# Perpendicular para el zigzag
		var perpendicular = Vector2(-direction.y, direction.x) 
		# Oscilacion lateral
		var offset = perpendicular * sin(time_passed * zigzag_frequency) * zigzag_amplitude 
		# Direccion final con zigzag
		var zigzag_direction = (direction + offset.normalized()).normalized() 
		velocity = zigzag_direction * speed * delta
			
		var collision = move_and_collide(velocity)
		if collision:
			var wall = collision.get_collider().is_in_group("walls")
			if not wall:
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
