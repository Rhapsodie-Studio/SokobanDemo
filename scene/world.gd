extends Node2D

@onready var level_finish = $LevelFinish
var level: Level

func _ready():
	level_finish.hide()
	level = $Level1
	level.level_complete.connect(_on_level_completed)
	
func _on_level_completed():
	level_finish.showWith(level.level)
