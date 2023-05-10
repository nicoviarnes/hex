extends Node2D

@onready var hex = preload("res://hex.tscn")

func _ready():
	# Initialize variables
	var sprite_count = 0          # Keeps track of how many sprites have been created
	var grid_size = Vector2(6, 5) # Defines the size of the grid
	var sprite_offset = Vector2(122, 107) # Defines the spacing between sprites
	var current_position = Vector2(60, 70) # Starting position of the first sprite
	
	# Create a 2D array to store the HexTile instances
	var hex_tiles = []
	for row in range(grid_size.y):
		hex_tiles.append([])
		
	# Loop through each row in the grid
	for row in range(grid_size.y):
		# Loop through each column in the grid
		for column in range(grid_size.x):
			# Calculate x_offset for odd rows
			var x_offset = 0
			if row % 2 != 0:
				x_offset = 61

			# Instantiate a new hex sprite and position it
			var sprite = hex.instantiate()
			#var hex_tile = sprite.get_node("HexTile")
			sprite.position = current_position + Vector2(x_offset, 0)
			add_child(sprite)


			# Increment sprite count
			sprite_count += 1

			# Check if we need to move to a new row
			if fmod(sprite_count, grid_size.x) == 0:
				current_position.x = 60
				current_position.y += sprite_offset.y
			else:
				current_position.x += sprite_offset.x
