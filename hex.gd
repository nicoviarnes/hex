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
var sand_market = preload("res://assets/Tiles/Western/western_sheriff.png")
var sand_stone = preload("res://assets/Tiles/Terrain/Sand/sand_18.png")
var sand_tree = preload("res://assets/Tiles/Terrain/Sand/sand_14.png")

#tile type dictionary for setting tile info
var TILE_TYPES = {
	grass: ["grass", 1, "food", []],
	#grass tree upgrade 2 variety
		#grass lumber mill
	#grass stone upgrade 2 variety
	#grass farm
	#grass windmill 1 x limit
	dirt: ["dirt", 1, "wood", []],
	#dirt tree upgrade 2 variety
	#dirt stone upgrade 2 variety
		#dirt mine
	stone: ["stone", 1, "stone", []],
	#stone tree upgrade 2 variety
	#stone market 1 x limit
	sand: ["sand", 1, "gold", [sand_tree, sand_stone, sand_market]],
	#sand tree upgrade 2 variety
	#sand stone upgrade 2 variety
	sand_tree: ["sand_tree", 5, "wood", []],
	sand_stone: ["sand_stone", 5, "stone", []],
	sand_market: ["sand_market", 25, "gold", []],
}

#terrain type of the tile
var type : String

#resource produced by the tile
var production : int
var resourceProduced : String

var upgrades : Array

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
			elif occupied:
				#signal to the label script in main scene to update the info labels
				emit_signal("selected", self)
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


# set the empty tile to the selected tile values
func set_tile():
	if not TurnManager.tile_placed_this_turn:
		self.texture = ChoiceManager.choice
		ChoiceManager.choice = null
		occupied = true
		if self.texture in TILE_TYPES:
			var tile_type = TILE_TYPES[self.texture]
			type = tile_type[0]
			production = tile_type[1]
			resourceProduced = tile_type[2]
			upgrades = tile_type[3]
			update_self()
			update_neighbors()
		TurnManager.tile_placed()

func update_self():
	for neighbor in neighbors:
		if neighbor.get_parent().type == type:
			production += 1
	ResourceManager.update_production(production,resourceProduced)


func update_neighbors():
	var added_production = 0
	for neighbor in neighbors:
		if neighbor.get_parent().type == type:
			neighbor.get_parent().production += 1	
			added_production += 1
	ResourceManager.update_production(added_production, resourceProduced)


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
			

func resource_gained_popup():
	if type.length() > 0:
		FCTManager.show_value(production)
