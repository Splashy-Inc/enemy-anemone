extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var blast_cooldown: Timer = $BlastCooldown

@export var blast_scene: PackedScene

func _physics_process(delta: float) -> void:
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

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("blast"):
		blast_attack()

func blast_attack():
	if blast_cooldown.is_stopped():
		blast_cooldown.start()
		var new_blast = blast_scene.instantiate()
		get_parent().add_child(new_blast)
		new_blast.global_position = global_position
		new_blast.activate()
