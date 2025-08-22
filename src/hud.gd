extends Control
## Displays player scores and manages player input for increasing the countdown 
## time and starting the match timer.  

signal increase_countdown

var scores = [0, 0] # [Zespar_score, Thor_score]
var min_increase = 0
var is_active = false


func _ready() -> void:
	reset_scores()
	
	
func _process(_delta: float) -> void:
	increase_count()
	start_timer()


func _on_hud_timer_end_match() -> void:
	is_active = false


func start_timer() -> void:
	if is_active:
		return
	
	if Input.is_action_just_pressed("ui_accept") and min_increase > 0:
		get_tree().call_group("timers", "start_timer_action")
		get_tree().call_group("builders", "set_initial_pieces")
		is_active = true


func increase_count() -> void:
	if is_active:
		return
	
	if Input.is_action_just_pressed("add_time"):
		emit_signal("increase_countdown")
		min_increase += 1
		
	
func add_score(body_name, score) -> void:
	if body_name == "Zespar":
		scores[0] += score
		$ZesparScore.text = str(scores[0])
	elif body_name == "Thor":
		scores[1] += score
		$ThorScore.text = str(scores[1])
		

func reload_timers_match() -> void:
	if is_active:
		get_tree().call_group("timers", "start_timer_action")
		get_tree().call_group("builders", "set_initial_pieces")

		
func reset_scores() -> void:
	scores = [0, 0]
