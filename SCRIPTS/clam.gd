extends CharacterBody2D

@export var pearl_scene: PackedScene
@export var is_placed = false
@export var placing_modulate: Color

@onready var attack_timer: Timer = $AttackRadius/AttackTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var in_range_targets := []

func _ready() -> void:
	if is_placed:
		on_placed()
	else:
		modulate = placing_modulate

func _physics_process(delta: float) -> void:
	if is_placed:
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
	var new_pearl = pearl_scene.instantiate()
	get_parent().add_child(new_pearl)
	new_pearl.global_position = global_position
	new_pearl.fire(in_range_targets.front())

func on_placed():
	is_placed = true
	modulate = Color.WHITE
	$CollisionShape2D.disabled = false
	$AttackRadius/CollisionShape2D.disabled = false
