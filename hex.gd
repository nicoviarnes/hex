extends Sprite2D

# Signal to connect to label script in main scene
signal selected(node)

#glow shader sprite
@onready var glow = $glow

#resource gathered popup tween
@onready var FCTManager = $FCTManager

#preloaded tile textures
var grass = preload("res://assets/Tiles/Terrain/Grass/grass_05.png")
var dirt = preload("res://assets/Tiles/Terrain/Dirt/dirt_06.png")
var stone = preload("res://assets/Tiles/Terrain/Stone/stone_07.png")
var sand = preload("res://assets/Tiles/Terrain/Sand/sand_07.png")

#tile type dictionary for setting tile info
var TILE_TYPES = {
	grass: ["grass", 1],
	dirt: ["dirt", 1],
	stone: ["stone", 1],
	sand: ["sand", 1],
}

#terrain type of the tile
var type : String

#resource produced by the tile
var production : int

#array containing neihboring hex nodes
var neighbors : Array

#boolean determing whether a tile is already filled
var occupied : bool = false

#function called when a mouse cursor is detected within the bounds of the CollisionShape2D
func _on_area_2d_mouse_entered():
	#if the tile isnt already filled change the glow shader to the currently selected choice sprite
	if not occupied:
		glow.texture = ChoiceManager.choice
		glow.visible = true
	#if the tile is filled and a choice is not currently in progress show the glow shader of the hovered tile
	elif occupied && not ChoiceManager.choice:
		glow.visible = true


#hide glow shader when mouse leaves the tile area
func _on_area_2d_mouse_exited():
	glow.visible = false


#function called on when mouse event is detected on the tile
func _on_area_2d_input_event(_viewport, event, _shape_idx):
	#check for left mouse click
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# if it is the first turn we allow the player to place the tile anywhere on the map
		if TurnManager.turn == 0:
			if ChoiceManager.choice != null:
				set_tile()
				#increment the turn in the TurnManager autoload script
				TurnManager.turn += 1
		else:
			if not occupied && ChoiceManager.choice != null:
				#on all subsequent turns we check to make sure that the player can only place tiles adjacent to an existing tile
				if is_tile_valid():
					set_tile()
				else:
					print("invalid tile")
			elif occupied:
				#signal to the label script in main scene to update the info labels
				emit_signal("selected", self)
				FCTManager.show_value(15)


# set the empty tile to the selected tile values
func set_tile():
	self.texture = ChoiceManager.choice
	ChoiceManager.choice = null
	occupied = true
	if self.texture in TILE_TYPES:
		var tile_type = TILE_TYPES[self.texture]
		type = tile_type[0]
		production = tile_type[1]
		update_self()
		update_neighbors()


func update_self():
	for neighbor in neighbors:
		if neighbor.get_parent().type == type:
			production += 1	

func update_neighbors():
	for neighbor in neighbors:
		if neighbor.get_parent().type == type:
			neighbor.get_parent().production += 1		

#check to see if there are any valid neighbors nearby on the grid
func is_tile_valid():
	for neighbor in neighbors:
		if neighbor.get_parent().type.length() > 0:
			return true
	return false


#add neighbors to the neighbor array
func _on_neigbors_area_entered(area):
	if area.is_in_group("hex") && area.get_parent() != self && area.get_parent():
		if not neighbors.has(area):
			neighbors.append(area)
