extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var blast_cooldown: Timer = $BlastCooldown
@onready var attack_range: TextureProgressBar = $AttackRange
@onready var player: CharacterBody2D = $"."

@export var blast_scene: PackedScene
@export var tower_scene: PackedScene
@export var towers_to_place = 1
var placing_tower: Node2D

func _physics_process(delta: float) -> void:
	attack_range.value = blast_cooldown.wait_time - blast_cooldown.time_left
	var direction := Input.get_vector("left", "right", "up", "down").normalized()
	if direction:
		if direction.x < 0:
			animated_sprite_2d.play("move")
			animated_sprite_2d.flip_h = true
		else:
			animated_sprite_2d.play("move")
			animated_sprite_2d.flip_h = false
			
		velocity = direction.normalized() * SPEED
	else:
		animated_sprite_2d.play("idle")
		velocity = Vector2.ZERO
	
	move_and_slide()
	
	if placing_tower:
		placing_tower.position = direction.normalized() * 56

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("blast"):
		blast_attack()
	elif event.is_action_pressed("tower") and towers_to_place > 0:
		_spawn_tower()
	elif event.is_action_released("tower") and placing_tower:
		_place_tower()

func blast_attack():
	if blast_cooldown.is_stopped():
		blast_cooldown.start()
		var new_blast = blast_scene.instantiate()
		get_parent().add_child(new_blast)
		new_blast.global_position = global_position
		new_blast.activate()

func _spawn_tower():
	var new_tower = tower_scene.instantiate()
	add_child(new_tower)
	placing_tower = new_tower
	towers_to_place -= 1

func _place_tower():
	placing_tower.reparent(get_parent())
	placing_tower.on_placed()
	placing_tower = null
