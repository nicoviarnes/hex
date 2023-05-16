extends TextureButton

signal updateTurn


func _on_pressed():
	visible = false
	TurnManager.end_turn()
	emit_signal("updateTurn")





func _on_tile_picker_make_new_hand():
	visible = true


func _on_upgrade_picker_show_upgrades():
	visible = false


func _on_upgrade_picker_hide_upgrades():
	visible = true
