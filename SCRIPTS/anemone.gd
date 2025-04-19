extends CharacterBody2D

signal died

@export var speed := 50
@export var target: Node2D

@onready var attack_timer: Timer = $AttackRadius/AttackTimer

var in_range_targets := []

func _physics_process(delta: float) -> void:
	if not target:
		target = get_tree().get_nodes_in_group("Objective").front()
	var direction = global_position.direction_to(target.global_position)
	if direction and not target in in_range_targets:
		velocity = direction.normalized() * speed
		attack_timer.stop()
	else:
		if attack_timer.is_stopped():
			attack_timer.start()
		velocity = Vector2.ZERO

	move_and_slide()

func _on_attack_radius_body_entered(body: Node2D) -> void:
	if not body in in_range_targets:
		in_range_targets.append(body)
		if body != target:
			target = body

func _on_attack_radius_body_exited(body: Node2D) -> void:
	in_range_targets.erase(body)
	if body == target:
		target = null

func _on_attack_timer_timeout() -> void:
	if target:
		target.on_hit(1)

func on_hit(damage: int):
	remove_from_group("Enemy")
	died.emit()
	queue_free()
