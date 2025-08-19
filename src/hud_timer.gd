extends Timer
## Manages the main match countdown timer.
## This timer tracks the remaining time for the match and emits updates
## each second. When the countdown reaches zero, the timer stops automatically.

signal countdown_updated(count: int)
signal end_match()

@export var countdown: float = 0


func _on_timeout() -> void:
	countdown -= 1
	if countdown <= 0:
		stop()
		emit_signal("end_match")
	
	emit_signal("countdown_updated", format_seconds(countdown))


func _on_hud_increase_countdown() -> void:
	countdown += 60
	emit_signal("countdown_updated", format_seconds(countdown))


func start_timer_action() -> void:
	if is_stopped():
		start()


func format_seconds(time : float) -> String:
	var minutes := time / 60
	var seconds := fmod(time, 60)
	
	return "%02d:%02d" % [minutes, seconds]
