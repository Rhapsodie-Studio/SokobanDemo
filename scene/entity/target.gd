extends Area2D
class_name Target

@onready var animated_sprite_2d = $AnimatedSprite2D

signal pressed
signal unpressed

var tile_map: TileMap
var is_pressed: bool = false

func initialize(_tile_map: TileMap):
	tile_map = _tile_map
	position = calculate_destination(Vector2.ZERO)
	

func _on_body_entered(body):
	if not body is Box:
		return
	is_pressed = true
	animated_sprite_2d.play("activated")
	emit_signal("pressed")


func _on_body_exited(body):
	if not body is Box:
		return
	is_pressed = false
	animated_sprite_2d.play("idle")
	emit_signal("unpressed")
	
func calculate_destination(direction: Vector2) -> Vector2:
	var tile_map_position = tile_map.local_to_map(global_position) + \
		Vector2i(sign(direction.x), sign(direction.y))
	return tile_map.map_to_local(tile_map_position)
