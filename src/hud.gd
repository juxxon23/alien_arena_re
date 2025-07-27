extends Control


func _process(_delta: float) -> void:
	start_timer()


func start_timer() -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().call_group("timers", "start_timer_action")
	
