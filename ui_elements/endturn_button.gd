extends TextureButton

signal updateTurn


func _on_pressed():
	visible = false
	TurnManager.end_turn()
	emit_signal("updateTurn")


func _on_tile_picker_make_new_hand():
	visible = true
