extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

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
