extends Level

@onready var game_pieces: Node = $GamePieces
@onready var path_follow_2d: PathFollow2D = $Environment/Boundary/Path2D/PathFollow2D

@export var anemone_scene: PackedScene
@export var num_enemies := 10
var num_enemies_to_spawn := num_enemies

func _ready() -> void:
	num_enemies *= Globals.round

func _on_timer_timeout() -> void:
	if num_enemies_to_spawn > 0:
		var new_anemone = anemone_scene.instantiate()
		game_pieces.add_child(new_anemone)
		path_follow_2d.progress_ratio = randf_range(0.0, 1.0)
		new_anemone.global_position = path_follow_2d.global_position
		new_anemone.died.connect(_on_enemy_died)
		num_enemies_to_spawn -= 1
	else:
		$Timer.stop()

func _on_enemy_died():
	if len(get_tree().get_nodes_in_group("Enemy")) <= 0:
		won.emit()
