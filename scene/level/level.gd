extends Node2D
class_name Level

@export var level = 1

@onready var tileMap = $TileMap

signal level_complete

# Called when the node enters the scene tree for the first time.
func _ready():
	var boxes = get_tree().get_nodes_in_group("box")
	for box in boxes:
		box.initialize(tileMap)
	var targets = get_tree().get_nodes_in_group("target")
	for target in targets:
		target.initialize(tileMap)
		target.pressed.connect(_on_target_pressed)


func _on_target_pressed():
	# check is every target is pressed
#	print("on target pressed")
	var targets = get_tree().get_nodes_in_group("target")
	var all_pressed = targets.all(func (target: Target): return target.is_pressed)
#	print(all_pressed)
	if all_pressed:
		emit_signal("level_complete")
