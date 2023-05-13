extends Label

@onready var type_label = $type
@onready var production_label = $production
@onready var turn_label = $turn


func update_info(node):
	type_label.text = "Type: " + node.type
	production_label.text = "Production: " + str(node.production)


func _on_endturn_button_update_turn():
	turn_label.text = "Turn: " + str(TurnManager.turn)
