extends Node2D


@onready var environment = $Environment
@onready var box = $Box
@onready var target = $Target


func _ready():
	box.initialize(environment)
	target.initialize(environment)
