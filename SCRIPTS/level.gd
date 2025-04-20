extends Node

class_name Level

signal won
signal lost

func _ready() -> void:
	for child in get_children():
		if child is DialogBox:
			child.dialog_ended.connect(_on_dialog_ended.bind(child))
	
	for objective in get_tree().get_nodes_in_group("Objective"):
		objective.died.connect(_on_objective_died)
	
	_level_ready()

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func _on_dialog_ended(dialog_box: DialogBox):
	print_debug("Dialog ended: ", dialog_box)

func resume_play(mouse_mode: int = Input.MOUSE_MODE_VISIBLE):
	process_mode = PROCESS_MODE_INHERIT

func pause_play(mouse_mode: int = Input.MOUSE_MODE_VISIBLE):
	process_mode = PROCESS_MODE_DISABLED

func _on_objective_died():
	lost.emit()

func _level_ready():
	pass
