extends CanvasLayer

@onready var label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Label

# we can change level to string later if that is needed
func showWith(level: int):
	show()
	label.text = "Level " + str(level) + " Completed"
