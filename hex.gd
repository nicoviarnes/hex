extends Sprite2D

@onready var glow = $glow

var grass = preload("res://assets/Tiles/Terrain/Grass/grass_05.png")
var dirt = preload("res://assets/Tiles/Terrain/Dirt/dirt_06.png")
var stone = preload("res://assets/Tiles/Terrain/Stone/stone_07.png")
var sand = preload("res://assets/Tiles/Terrain/Sand/sand_07.png")

var neighbors = []

var occupied = false

func _on_area_2d_mouse_entered():
	if not occupied:
		glow.texture = ChoiceManager.choice
		glow.visible = true
	elif occupied && not ChoiceManager.choice:
		glow.visible = true


func _on_area_2d_mouse_exited():
	glow.visible = false


func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if not occupied && ChoiceManager.choice != null:
			self.texture = ChoiceManager.choice
			ChoiceManager.choice = null
			occupied = true
		if occupied:
			pass
			#emit a signal that updates info labels. need to connect this signal in the spawning code
#		for neighbor in neighbors:
#			neighbor.get_parent().get_node("glow").visible = true


func get_neighbors():
	print(neighbors)


func _on_neigbors_area_entered(area):
	if area.is_in_group("hex") && area.get_parent() != self:
		if not neighbors.has(area):
			neighbors.append(area)
