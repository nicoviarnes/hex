extends Node2D

var FCT = preload("res://utility/fct.tscn")

var travel = Vector2(0, -60)
var duration = 1.5
var spread = PI/2

func show_value(value, crit=false):
	var fct = FCT.instantiate()
	add_child(fct)
	fct.show_value(str(value), travel, duration, spread, crit)
