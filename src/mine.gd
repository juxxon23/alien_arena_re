extends Area2D
## Represents a buildable mine object in the game.
## When an opponent touches it, the player who placed it (the owner) is awarded
## with 100 points.

var player_owner : String


func _ready() -> void:
	$AnimatedSprite2D.play("mine")


func _on_body_entered(body: Node2D) -> void:
	if body is Drone or body is Qtpi or body is Spazzhatazz:
		get_tree().call_group("objs", "exploded_obj", body) 
	else:
		get_tree().call_group("score", "add_score", player_owner, 100)
	
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
