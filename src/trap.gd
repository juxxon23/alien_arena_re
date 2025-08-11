extends Area2D
## It represents a trap on the board that immobilizes a player upon contact.
## The trap uses a timer to release the player after a period of time.

var player_owner : String
var player_stucked : String


func _ready() -> void:
	$AnimatedSprite2D.play("trap")
	

func _on_body_entered(body: Node2D) -> void:
	player_stucked = body.name
	get_tree().call_group("builders", "player_move", player_stucked, false)
	
	$Timer.start()
	

func _on_timer_timeout() -> void:
	get_tree().call_group("builders", "player_move", player_stucked, true)	


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
