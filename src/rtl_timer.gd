extends RichTextLabel

var text_count: String = "00:00"


func _process(delta: float) -> void:
	text = text_count


func _on_timer_countdown_updated(count: Variant) -> void:
	text_count = count
