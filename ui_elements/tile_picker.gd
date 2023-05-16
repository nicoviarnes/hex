extends TextureRect

signal makeNewHand


func _ready():
	show_hand()
	TurnManager.tilePlaced.connect(hide_hand)

func show_hand():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(620, 439), 1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)

func hide_hand():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(1194, 439), 1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_callback(make_new_hand)


func make_new_hand():
	emit_signal("makeNewHand")

func _on_endturn_button_pressed():
	show_hand()
