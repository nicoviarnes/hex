extends Node2D

var hex_choice = preload("res://choice.tscn")
var choice_count = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	make_choices()


func make_choices():
	var x_offset = 0
	for child in get_children():
		child.queue_free()
		
	for choice in choice_count:
		var hex = hex_choice.instantiate()
		hex.position.x = x_offset
		hex.position.y = 0
		x_offset += 122
		add_child(hex)


func _on_tile_picker_make_new_hand():
	make_choices()
