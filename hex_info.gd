extends Label

@onready var type_label = $type
@onready var production_label = $production

# Called when the node enters the scene tree for the first time.
func update_info(node):
	type_label.text = "Type: " + node.type
	production_label.text = "Production: " + str(node.production)
