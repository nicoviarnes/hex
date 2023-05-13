extends HBoxContainer

@onready var current_food = $currentFood
@onready var food_per_turn = $foodPerTurn

@onready var current_stone = $currentStone
@onready var stone_per_turn = $stonePerTurn

@onready var current_wood = $currentWood
@onready var wood_per_turn = $woodPerTurn

@onready var current_gold = $currentGold
@onready var gold_per_turn = $goldPerTurn

# Called when the node enters the scene tree for the first time.
func _ready():
	ResourceManager.updateResources.connect(update_resources)
	ResourceManager.updateProduction.connect(update_production)
	update_resources()
	update_production()


func update_resources():
	current_food.text = str(ResourceManager.current_food)
	current_stone.text = str(ResourceManager.current_stone)
	current_wood.text = str(ResourceManager.current_wood)
	current_gold.text = str(ResourceManager.current_gold)


func update_production():
	food_per_turn.text = "(+ " + str(ResourceManager.food_per_turn) + ")"
	stone_per_turn.text = "(+ " + str(ResourceManager.stone_per_turn) + ")"
	wood_per_turn.text = "(+ " + str(ResourceManager.wood_per_turn) + ")"
	gold_per_turn.text = "(+ " + str(ResourceManager.gold_per_turn) + ")"
