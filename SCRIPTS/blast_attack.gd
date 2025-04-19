extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var activated

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func activate():
	animation_player.play("blast")

func _on_body_entered(body: Node2D) -> void:
	body.on_hit(1)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
