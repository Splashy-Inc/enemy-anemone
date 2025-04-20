extends Node2D

class_name JoyStick

var posVector:Vector2

func _ready() -> void:
	Globals.joystick = self
