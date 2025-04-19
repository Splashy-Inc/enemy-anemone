extends Level

@onready var game_pieces: Node = $GamePieces
@onready var path_follow_2d: PathFollow2D = $Environment/Boundary/Path2D/PathFollow2D

@export var anemone_scene: PackedScene

func _on_timer_timeout() -> void:
	var new_anemone = anemone_scene.instantiate()
	game_pieces.add_child(new_anemone)
	path_follow_2d.progress_ratio = randf_range(0.0, 1.0)
	new_anemone.global_position = path_follow_2d.global_position
