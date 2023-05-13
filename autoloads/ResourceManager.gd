extends Node

signal updateResources
signal updateProduction

var current_food = 0
var current_stone = 0
var current_wood = 0
var current_gold = 0

var food_per_turn = 1
var stone_per_turn = 1
var wood_per_turn = 1
var gold_per_turn = 1

func _ready():
	TurnManager.turnEnded.connect(update_resources)

func update_resources():
	current_food += food_per_turn
	current_stone += stone_per_turn
	current_wood += wood_per_turn
	current_gold += gold_per_turn
	
	emit_signal("updateResources")


func update_production(production, resourceProduced):
	print(resourceProduced)
	match resourceProduced:
		"food":
			food_per_turn += production
		"stone":
			stone_per_turn += production
		"wood":
			wood_per_turn += production
		"gold":
			gold_per_turn += production			
	emit_signal("updateProduction")
