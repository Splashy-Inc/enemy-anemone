extends CharacterBody2D

signal died

@export var speed := 50
@export var target: Node2D

@onready var attack_timer: Timer = $AttackRadius/AttackTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sfx_manager: Node2D = $SFXManager

var in_range_targets := []
var dying = false

func _physics_process(delta: float) -> void:
	if not dying:
		if not target and get_tree().get_nodes_in_group("Objective").size() > 0:
			target = get_tree().get_nodes_in_group("Objective").front()
			target.died.connect(_on_target_died)
		if target:
			var direction = global_position.direction_to(target.global_position)
			if direction and not target in in_range_targets:
				velocity = direction.normalized() * speed
				attack_timer.stop()
			else:
				if attack_timer.is_stopped():
					target.on_hit(1)
					attack_timer.start()
					sfx_manager.play("Attacking")
				velocity = Vector2.ZERO

			move_and_slide()

func _on_attack_radius_body_entered(body: Node2D) -> void:
	if not body in in_range_targets:
		in_range_targets.append(body)
		if body != target:
			if target:
				target.died.disconnect(_on_target_died)
			target = body
			target.died.connect(_on_target_died)

func _on_attack_radius_body_exited(body: Node2D) -> void:
	in_range_targets.erase(body)
	if body == target:
		target = null

func _on_attack_timer_timeout() -> void:
	if target:
		target.on_hit(1)

func on_hit(damage: int):
	dying = true
	call_deferred("_disable_collision")
	animation_player.play("die")

func _disable_collision():
	collision_shape_2d.disabled = true

func _die():
	remove_from_group("Enemy")
	died.emit()
	queue_free()

func _on_target_died():
	target = null
	sfx_manager.stop()
