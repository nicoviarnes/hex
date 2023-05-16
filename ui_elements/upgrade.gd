extends TextureRect

@export var tile_texture : CompressedTexture2D


# Called when the node enters the scene tree for the first time.
func _ready():
	texture = tile_texture

