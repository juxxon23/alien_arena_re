extends StaticBody2D


func set_object(color: String) -> void:
	match color:
		"#ff3333": $AnimatedSprite2D.play("mine")
		"#3333ff": $AnimatedSprite2D.play("trap")
		"#6699ff": $AnimatedSprite2D.play("drone")
		"#99ff66": $AnimatedSprite2D.play("qtpi")
		"#ff6699": $AnimatedSprite2D.play("spazzhatazz")
		_: return
