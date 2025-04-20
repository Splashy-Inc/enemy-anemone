extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_blast_button_pressed() -> void:
	Input.action_press("blast")


func _on_clam_button_button_down() -> void:
	Input.action_press("tower")

func _on_clam_button_button_up() -> void:
	Input.action_release("tower")
