extends StaticBody2D

signal died

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sfx_manager: Node2D = $SFXManager
@onready var health_bar: ProgressBar = $HealthBar

@export var max_health := 100
var cur_health := max_health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.value = cur_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_hit(damage: int):
	if cur_health > 0:
		cur_health = clamp(cur_health - damage, 0, max_health)
		animation_player.play("on_hit")
		animation_player.seek(0.0)
		health_bar.value = cur_health
		if cur_health <= 0:
			animation_player.play("die")
			remove_from_group("Objective")
			died.emit()
			await animation_player.animation_finished
			queue_free()
