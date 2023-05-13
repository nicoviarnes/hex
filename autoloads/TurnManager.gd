extends Node

signal tilePlaced
signal turnEnded

var tile_placed_this_turn = false
var turn = 0

func tile_placed():
	tile_placed_this_turn = true
	emit_signal("tilePlaced")

func end_turn():
	turn += 1
	tile_placed_this_turn = false
	emit_signal("turnEnded")
