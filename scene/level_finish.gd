extends CanvasLayer

signal restart
signal next_level

@onready var label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Label

# we can change level to string later if that is needed
func showWith(level: int):
	show()
	label.text = "Level " + str(level) + " Completed"


func _on_restart_pressed():
	emit_signal("restart")


func _on_next_level_pressed():
	emit_signal("next_level")
