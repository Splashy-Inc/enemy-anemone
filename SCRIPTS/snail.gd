extends StaticBody2D

signal died

@export var max_health := 100
var cur_health := max_health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_hit(damage: int):
	cur_health = clamp(cur_health - damage, 0, max_health)
	if cur_health <= 0:
		died.emit()
