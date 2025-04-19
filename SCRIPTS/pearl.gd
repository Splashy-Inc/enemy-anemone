extends Area2D

var target: Node2D
var speed = 300

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target:
		# Move toward the enemy
		if global_position.distance_to(target.global_position) > 0:
			global_position = global_position.move_toward(target.global_position, delta * speed)

func fire(new_target: Node2D):
	target = new_target

func _on_body_entered(body: Node2D) -> void:
	body.on_hit(1)
	queue_free()
