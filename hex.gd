extends Sprite2D
@onready var glow = $glow


func _on_area_2d_mouse_entered():
	glow.visible = true


func _on_area_2d_mouse_exited():
	glow.visible = false


func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		#emit_signal("clicked", self)
		self.visible = false
