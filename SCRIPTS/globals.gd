extends Node

signal enemies_remaining_updated

var cur_level_scene: PackedScene

var joypad_connected := false

var round = 1
var enemies_remaining = 0

var joystick: JoyStick

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.joy_connection_changed.connect(_on_joy_connection_changed)
	joypad_connected = Input.get_connected_joypads().size() > 0
	update_enemies_remaining(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_joy_connection_changed(device, connected):
	joypad_connected = Input.get_connected_joypads().size() > 0

func update_enemies_remaining(new_count: int):
	enemies_remaining = new_count
	enemies_remaining_updated.emit(enemies_remaining)
