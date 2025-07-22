extends Timer

@export var countdown: float = 0
signal countdown_updated(count: int)


func _process(_delta: float) -> void:
	increase_countdown()


func increase_countdown() -> void:
	if Input.is_action_just_pressed("add_time"):
		countdown += 60
		emit_signal("countdown_updated", format_seconds(countdown))


func format_seconds(time : float) -> String:
	var minutes := time / 60
	var seconds := fmod(time, 60)
	
	return "%02d:%02d" % [minutes, seconds]


func _on_timeout() -> void:
	countdown -= 1
	if countdown <= 0:
		stop()
	emit_signal("countdown_updated", format_seconds(countdown))


func _on_hud_countdown_timer() -> void:
	start()
