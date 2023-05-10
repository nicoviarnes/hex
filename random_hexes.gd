extends Node2D

var hex_choice = preload("res://choice.tscn")
var choice_count = 3
var x_offset = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for choice in choice_count:
		var hex = hex_choice.instantiate()
		hex.position.x = x_offset
		x_offset += 122
		add_child(hex)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
