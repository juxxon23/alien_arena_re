extends Area2D


func _ready() -> void:
	$AnimatedSprite2D.play("mine")


func _on_body_entered(body: Node2D) -> void:
	get_tree().call_group("score", "add_score", body.name, 100)
