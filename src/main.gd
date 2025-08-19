extends Node

@onready var match_scn = load("res://scenes/match.tscn")
var old_match : Variant
var new_match : Variant


func reload_match() -> void:
	old_match = get_tree().current_scene.get_node("Match")
	if old_match:
		old_match.queue_free()
		await get_tree().process_frame
		create_new_match()
	
	
func create_new_match() -> void:
	if not is_instance_valid(old_match):
		new_match = match_scn.instantiate()
		add_child(new_match)
		move_child(new_match, 0)
		$HUD.reload_timers_match()
