extends Node2D


@onready var environment = $Environment
@onready var box = $Box


func _ready():
	box.initialize(environment)
