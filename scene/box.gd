extends CharacterBody2D
class_name Box

@export var sliding_time = 0.3

var is_sliding = false

var tile_map: TileMap

func initialize(_tile_map: TileMap) -> void:
	tile_map = _tile_map
	position = calculate_destination(Vector2.ZERO)


func push(velocity: Vector2) -> void:
	if is_sliding:
		return
		
	var move_to := calculate_destination(velocity.normalized())
	if can_move(move_to):
		print(move_to)
		is_sliding = true
		var tween = create_tween()
		tween.tween_property(self, "global_position", move_to, sliding_time)
		tween.connect("finished", on_tween_finished)
		
func on_tween_finished():
	is_sliding = false


func calculate_destination(direction: Vector2) -> Vector2:
	var tile_map_position = tile_map.local_to_map(global_position) + \
		Vector2i(sign(direction.x), sign(direction.y))
	return tile_map.map_to_local(tile_map_position)
	

func can_move(move_to: Vector2) -> bool:
	return true
