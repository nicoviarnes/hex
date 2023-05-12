extends Label

func show_value(value, travel, duration, spread, crit=false):
	text = value
	var movement = travel.rotated(randf_range(-spread/2, spread/2))
	pivot_offset = size / 2


	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", position + movement, duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(self, "modulate:a", 0.0, duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
		
	tween.tween_callback(queue_free)
