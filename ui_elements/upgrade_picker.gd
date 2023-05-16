extends TextureRect

signal showUpgrades
signal hideUpgrades


var upgrade_icons = preload("res://ui_elements/upgrade.tscn")


func show_upgrades():
	emit_signal("showUpgrades")
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(620, 236), 1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)


func hide_upgrades():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(1194, 236), 1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_callback(hide_after_tween)



func update_upgrades(node):
	var x_offset = 0
	for child in get_children():
		if child.is_in_group("upgrade"):
			child.queue_free()
	for upgrade in node.upgrades:
		var new_upgrade = upgrade_icons.instantiate()
		new_upgrade.tile_texture = upgrade
		new_upgrade.position.x = x_offset
		new_upgrade.position.y = 0
		x_offset += 122
		add_child(new_upgrade)
	show_upgrades()



func _on_backbutton_pressed():
	hide_upgrades()
	
	
func hide_after_tween():
	emit_signal("hideUpgrades")
