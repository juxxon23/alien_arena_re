extends Control

var scores = [0,0] # [Zespar_score, Thor_score]


func _ready() -> void:
	reset_scores()


func _process(_delta: float) -> void:
	start_timer()


func start_timer() -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().call_group("timers", "start_timer_action")
	
	
func add_score(body_name, score) -> void:
	if body_name == "Zespar":
		scores[0] += score
		$ZesparScore.text = str(scores[0])
	elif body_name == "Thor":
		scores[1] += score
		$ThorScore.text = str(scores[1])
		
func reset_scores() -> void:
	scores = [0,0]
