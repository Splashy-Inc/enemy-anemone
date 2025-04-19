extends CharacterBody2D

@export var speed := 50
@export var target: Node2D

var in_range_targets := []

func _physics_process(delta: float) -> void:
	if not target:
		target = get_tree().get_nodes_in_group("Objective").front()
	var direction = global_position.direction_to(target.global_position)
	if direction and not target in in_range_targets:
		velocity = direction.normalized() * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

func _on_attack_radius_body_entered(body: Node2D) -> void:
	if not body in in_range_targets:
		in_range_targets.append(body)

func _on_attack_radius_body_exited(body: Node2D) -> void:
	in_range_targets.erase(body)
