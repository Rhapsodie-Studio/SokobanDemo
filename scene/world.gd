extends Node2D

@onready var level_finish = $LevelFinish
var level: Level

func _ready():
	level_finish.hide()
	level = $Level1
	level.level_complete.connect(_on_level_completed)

func _on_level_completed():
	# stop every input
	level_finish.showWith(level.level)

func _on_restart_current_level():
	print("restart current level")
	reload_level()
	level_finish.hide()

func _on_go_to_next_level():
	print("go to next level")
	level_finish.hide()
	load_level(level.level + 1)

func unload_level():
	if is_instance_valid(level):
		level.queue_free()
	level = null

func load_level(level_number: int):
	var level_path = "res://scene/level/level_%d.tscn" % level_number
	load_level_with_file(level_path)

func load_level_with_file(level_file_path: String):
	unload_level()
	var level_resource = load(level_file_path)
	if level_resource:
		level = level_resource.instantiate()
		add_child(level)
		level.level_complete.connect(_on_level_completed)
	else:
		# TODO: there is no level after this one. show user that demo is over
		pass

func reload_level():
	print(level.scene_file_path)
	load_level_with_file(level.scene_file_path)
