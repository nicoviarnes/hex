extends Sprite2D

signal selected(node)

@onready var glow = $glow
@onready var FCTManager = $FCTManager

var grass = preload("res://assets/Tiles/Terrain/Grass/grass_05.png")
var dirt = preload("res://assets/Tiles/Terrain/Dirt/dirt_06.png")
var stone = preload("res://assets/Tiles/Terrain/Stone/stone_07.png")
var sand = preload("res://assets/Tiles/Terrain/Sand/sand_07.png")

var TILE_TYPES = {
	grass: ["grass", "+2 food"],
	dirt: ["dirt", "+2 something"],
	stone: ["stone", "+2 something"],
	sand: ["sand", "+2 something"],
}

var type : String
var production : String

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
			if self.texture in TILE_TYPES:
				var tile_type = TILE_TYPES[self.texture]
				type = tile_type[0]
				production = tile_type[1]
		elif occupied && ChoiceManager.choice != null:
			pass
		elif occupied:
			emit_signal("selected", self)
			FCTManager.show_value(15)
			get_neighbors()


func get_neighbors():
	for neighbor in neighbors:
		if neighbor.get_parent().type.length() > 0:
			print(neighbor.get_parent().type)


func _on_neigbors_area_entered(area):
	if area.is_in_group("hex") && area.get_parent() != self:
		if not neighbors.has(area):
			neighbors.append(area)
