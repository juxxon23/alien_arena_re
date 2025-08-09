extends Area2D


func _ready() -> void:
	$AnimatedSprite2D.play("trap")


func _on_body_entered(body: Node2D) -> void:
	print(body.name, " stucked")
