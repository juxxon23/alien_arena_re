extends Control

signal countdown_timer()


func _process(_delta: float) -> void:
	start_timer()


func start_timer() -> void:
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("countdown_timer")
	
