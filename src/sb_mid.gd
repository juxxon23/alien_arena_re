extends StaticBody2D
## It represents the central wall in the arena that separates the two 
## quadrants. It acts as a physical barrier that prevents players from passing 
## through until the internal timer expires.


func _ready() -> void:
	$AnimatedSprite2D.animation = "locked"


func _on_timer_timeout() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimatedSprite2D.animation = "unlocked"
