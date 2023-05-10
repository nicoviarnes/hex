extends Sprite2D
@onready var glow = $glow
@onready var shine = $shine

var grass = preload("res://assets/Tiles/Terrain/Grass/grass_05.png")
var dirt = preload("res://assets/Tiles/Terrain/Dirt/dirt_06.png")
var stone = preload("res://assets/Tiles/Terrain/Stone/stone_07.png")
var sand = preload("res://assets/Tiles/Terrain/Sand/sand_07.png")


var tiles = [grass, dirt, stone, sand]
# Called when the node enters the scene tree for the first time.
func _ready():
	var tile = tiles.pick_random()
	texture = tile
	glow.texture = tile
	shine.texture = tile


func _on_area_2d_mouse_entered():
	glow.visible = true


func _on_area_2d_mouse_exited():
	glow.visible = false


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		ChoiceManager.choice = texture
