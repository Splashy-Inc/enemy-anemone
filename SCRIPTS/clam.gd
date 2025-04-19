extends CharacterBody2D

@export var target: Node2D

@onready var attack_timer: Timer = $AttackRadius/AttackTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var in_range_targets := []

func _physics_process(delta: float) -> void:
	if in_range_targets.size() > 0:
		transform = transform.looking_at(in_range_targets.front().global_position)
		if attack_timer.is_stopped():
			animation_player.play("fire_pearl")

func _on_attack_range_body_entered(body: Node2D) -> void:
	if not body in in_range_targets:
		in_range_targets.append(body) 
		if attack_timer.is_stopped():
			animation_player.play("fire_pearl")

func _on_attack_radius_body_exited(body: Node2D) -> void:
	in_range_targets.erase(body)

func _fire_pearl():
	pass
